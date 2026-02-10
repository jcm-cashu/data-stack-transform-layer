# Guia: criar novas tabelas `cashu_app` (Snowflake Bronze + dbt Staging)

Este documento padroniza o processo para criar (1) a **task do Snowflake** que materializa uma tabela `bronze.raw_cashu_app__*` a partir de um stage `@bronze.raw_cashu_app__*` e (2) o **modelo dbt `stg_cashu_app__*`** que aplica as convenções de nomenclatura.

Referências:
- Convenções de nomenclatura: `docs/convencoes_nomenclatura.md`
- Padrão de staging existente: `models/staging/cashu_app/stg_cashu_app__*.sql`
- Sources dbt: `models/staging/_sources.yml`

---

## Objetivo

Dado um DDL (ex.: Postgres) no formato:

- `CREATE TABLE public.<nome> ( ... )`

Você deve produzir:

1. **DDL da task Snowflake**: `CREATE OR REPLACE TASK bronze.raw_cashu_app__<nome> ... CREATE OR REPLACE TABLE bronze.raw_cashu_app__<nome> AS SELECT ... FROM @bronze.raw_cashu_app__<nome> t;`
2. **Modelo dbt staging**: `models/staging/cashu_app/stg_cashu_app__<nome>.sql` consumindo `{{ source('bronze', 'raw_cashu_app__<nome>') }}`
3. **Atualização do source**: adicionar `raw_cashu_app__<nome>` em `models/staging/_sources.yml`

---

## 1) Convenções de nomes (staging)

As regras estão em `docs/convencoes_nomenclatura.md`. Na prática, nos modelos `stg_cashu_app__*`:

- **snake_case + lowercase**
- **IDs**: `id`/`*_id` → `id_*` (ex.: `customer_id` → `id_cust`)
- **Números/documentos**: `nr_*` (ex.: CPF/CNPJ, NFe, boleto)
- **Valores**: `amt_*`
- **Quantidades**: `qty_*`
- **Status**: `st_*`
- **Tipos**: `tp_*`
- **Booleans**: `is_*` / `has_*`
- **Datas/Timestamps**: preferir sufixos `_date` (date) e `_at` (timestamp)

### CPF/CNPJ (gov_id)

Quando a coluna representar CPF/CNPJ, preferir padronização usando macro:

```sql
{{ standardize_bz_gov_id('<coluna>') }} as nr_doc
```

ou, dependendo do contexto do modelo, `nr_gov_id`, `nr_doc_buyer`, `nr_doc_seller`, etc.

---

## 2) DDL da task Snowflake (Bronze)

### 2.1 Nome do objeto

Para uma tabela `public.<nome>` do `cashu_app`, o padrão é:

- **Task**: `bronze.raw_cashu_app__<nome>`
- **Tabela bronze**: `bronze.raw_cashu_app__<nome>`
- **Stage**: `@bronze.raw_cashu_app__<nome>`

### 2.2 Estrutura do DDL

Template (ajuste colunas e casts):

```sql
CREATE OR REPLACE TASK bronze.raw_cashu_app__<nome>
WAREHOUSE = 'DBT_WH'
as
CREATE OR REPLACE TABLE bronze.raw_cashu_app__<nome> AS
SELECT
  -- colunas...
  $1:"_loaded_at"::datetime _etl_loaded_at
FROM @bronze.raw_cashu_app__<nome> t;
```

### 2.3 Regras de casting (prática do projeto)

Use `$1:"<col>"::<tipo> <alias>` para cada coluna do JSON.

#### Identificadores e inteiros

- `bigserial`, `bigint`, `int8` → `::int` (padrão usado nos exemplos do projeto)
- `int`, `int4` → `::int`

Ex.:

```sql
$1:"id"::int id,
$1:"customer_id"::int customer_id
```

#### Strings

- `varchar`, `text` → `::varchar`

Ex.:

```sql
$1:"document"::varchar document
```

#### Numéricos / floats

No bronze, o padrão mais comum é **materializar como `::float`** mesmo quando a origem é `numeric(10,2)` (por simplicidade no ingest). Se a precisão for requisito de negócio/contábil, alinhar antes.

Ex.:

```sql
$1:"credit_used"::float credit_used
```

#### Arrays

- `text[]` (ou `_text`) → `::array`

Ex.:

```sql
$1:"recommendation_limiters_applied_type"::array recommendation_limiters_applied_type
```

#### Timestamps (epoch em microssegundos)

Quando a origem chega como inteiro em microssegundos, converter para timestamp com:

```sql
to_timestamp(($1:"<col>"::int/1e6)::int) as <col>
```

Ex.:

```sql
to_timestamp(($1:"created_at"::int/1e6)::int) as created_at,
to_timestamp(($1:"updated_at"::int/1e6)::int) as updated_at
```

> Observação: alguns feeds podem chegar como timestamp “normal” (string/timestamp). Nesse caso, você pode usar `$1:"<col>"::timestamp <col>` — mas o padrão acima (micros) é o mais recorrente nos exemplos de ingest.

#### Colunas geradas (generated always)

Colunas `GENERATED ALWAYS AS (...) STORED` do Postgres normalmente:

- ou já vêm prontas no payload (e então você faz cast normal)
- ou não vêm (e então **não inclua no bronze**, e recrie no staging/intermediate se precisar)

---

## 3) Modelo dbt `stg_cashu_app__<nome>.sql`

### 3.1 Padrão base

Todo `stg_` deve:

- Selecionar da source bronze
- Renomear campos para o padrão de negócio (conforme convenções)
- Deduplicar usando `_etl_loaded_at`:

```sql
select
  ...
from {{ source('bronze', 'raw_cashu_app__<nome>') }}
qualify rank() over(partition by id order by _etl_loaded_at desc) = 1
```

> Se a tabela não tiver `id`, escolha a chave natural correta no `partition by` (ex.: `external_id`, combinação de colunas, etc.).

### 3.2 Renomeação (raw → convenção)

No `stg`, faça o “mapeamento semântico”:

- `id` → `id_<entidade>`
- `customer_id` → `id_cust`
- `status` → `st_<entidade>`
- `amount`/`value` → `amt_*`
- `*_rate` → `rate_*`
- `*_date`/`*_at` conforme semântica
- documentos: usar `{{ standardize_bz_gov_id('<col>') }}` quando aplicável

---

## 4) Atualizar `models/staging/_sources.yml`

Adicionar a nova tabela source em:

```yml
sources:
  - name: bronze
    schema: bronze
    tables:
      - name: raw_cashu_app__<nome>
```

Sem isso, `{{ source('bronze', 'raw_cashu_app__<nome>') }}` não resolve.

---

## 5) Checklist rápido (para cada tabela nova)

- [ ] Definir nome final: `raw_cashu_app__<nome>`
- [ ] Escrever DDL da task Snowflake seguindo o template + casts corretos
- [ ] Garantir inclusão de `_etl_loaded_at` no select do bronze
- [ ] Criar `models/staging/cashu_app/stg_cashu_app__<nome>.sql` com renomeação + dedup por `_etl_loaded_at`
- [ ] Adicionar `raw_cashu_app__<nome>` em `models/staging/_sources.yml`
- [ ] Conferir naming conventions (`docs/convencoes_nomenclatura.md`)

