# OLAP Database Naming Convention Dictionary
## Financial Services Edition

This standard is aligned with:
- **dbt** official style guide
- **FIBO** (Financial Industry Business Ontology)
- **Basel** credit risk terminology
- **Brazilian** receivables/FIDC context

---

## 1. General Principles

| Principle | Description |
|-----------|-------------|
| **Snake Case** | All columns in `snake_case` (e.g., `total_amount`) |
| **Lowercase** | Always lowercase, no special characters |
| **Character Limit** | Maximum 30 characters per column name |
| **Type Prefixes** | Use prefixes to indicate data type when necessary |
| **Semantic Booleans** | Use `is_` / `has_` prefixes for boolean columns |
| **Timestamp Suffix** | Use `_at` suffix for timestamps, `_date` for dates |

---

## 2. Standard Abbreviations Dictionary

### 2.1 Entities and Objects

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| quantity | qty | `qty_items` |
| number | nr / num | `nr_order` |
| code | cd | `cd_customer` |
| identifier | id | `id_transaction` |
| description | desc | `desc_product` |
| category | cat | `cat_product` |
| document | doc | `nr_doc` |
| receipt | rcpt | `cd_rcpt` |
| establishment | estab | `cd_estab` |
| supplier / vendor | suppl | `cd_suppl` |
| customer / client | cust | `cd_cust` |
| company | comp | `cd_comp` |
| employee | emp | `cd_emp` |
| department | dept | `cd_dept` |
| branch | brch | `cd_brch` |
| unit | unit | `cd_unit` |
| product | prod | `cd_prod` |
| service | serv | `cd_serv` |
| order | ord | `nr_ord` |
| contract | contr | `nr_contr` |
| invoice | inv | `nr_inv` |
| tax invoice (NF) | nf | `nr_nf` |
| installment | inst | `nr_inst` |
| title / security | ttl | `cd_ttl` |
| bank | bnk | `cd_bnk` |
| agency | agcy | `nr_agcy` |
| account | acct | `nr_acct` |
| transaction | txn | `cd_txn` |
| operation | oper | `cd_oper` |
| movement | mov | `cd_mov` |
| entry | entry | `cd_entry` |
| record | rec | `nr_rec` |
| sequence | seq | `nr_seq` |
| reference | ref | `cd_ref` |
| origin / source | orig | `cd_orig` |
| destination | dest | `cd_dest` |
| address | addr | `desc_addr` |
| phone | phone | `nr_phone` |
| observation / note | obs | `desc_obs` |
| portfolio | portf | `id_portf` |
| fund | fund | `id_fund` |
| position | pos | `amt_pos` |

### 2.2 Parties and Counterparties (FIBO-aligned)

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| counterparty | cpty | `id_cpty` |
| issuer | issuer | `nm_issuer` |
| holder | holder | `id_holder` |
| beneficiary | benef | `nm_benef` |
| debtor | debtor | `id_debtor` |
| creditor | creditor | `id_creditor` |
| seller | seller | `nm_seller` |
| buyer | buyer | `nm_buyer` |
| sponsor | sponsor | `nm_sponsor` |
| cedent / assignor | cedent | `id_cedent` |
| assignee | assignee | `id_assignee` |
| guarantor | guarant | `id_guarant` |
| servicer | servicer | `id_servicer` |
| custodian | custod | `id_custod` |
| trustee | trustee | `id_trustee` |
| government_id (CPF/CNPJ) | gov_id | `nr_gov_id` |

### 2.3 Values and Metrics

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| value / amount | amt | `amt_total` |
| total | tot | `amt_tot` |
| partial | part | `amt_part` |
| net | net | `amt_net` |
| gross | gross | `amt_gross` |
| discount | disc | `amt_disc` |
| addition / surcharge | surch | `amt_surch` |
| interest | int | `amt_int` |
| fine / penalty | pnlt | `amt_pnlt` |
| tax | tax | `amt_tax` |
| fee | fee | `amt_fee` |
| tariff | trf | `amt_trf` |
| commission | comm | `amt_comm` |
| balance | bal | `amt_bal` |
| average | avg | `amt_avg` |
| minimum | min | `amt_min` |
| maximum | max | `amt_max` |
| percentage | pct | `pct_disc` |
| rate | rate | `rate_margin` |
| price | prc | `prc_unit` |
| cost | cost | `cost_total` |
| spread | spread | `spread_credit` |
| premium | prem | `amt_prem` |
| notional | notl | `amt_notl` |
| principal | princ | `amt_princ` |
| face value | face | `amt_face` |
| market value | mkt | `amt_mkt` |
| book value | book | `amt_book` |

### 2.4 Financial Metrics and KPIs (Industry Standard)

| Term | Abbreviation | Usage Example | Description |
|------|--------------|---------------|-------------|
| Profit and Loss | pnl | `amt_pnl` | Revenue minus costs |
| Mark to Market | mtm | `amt_mtm` | Current market valuation |
| Net Asset Value | nav | `amt_nav` | Fund value per share |
| Assets Under Management | aum | `amt_aum` | Total managed assets |
| Return on Investment | roi | `pct_roi` | Investment return percentage |
| Return on Equity | roe | `pct_roe` | Equity return percentage |
| Return on Assets | roa | `pct_roa` | Asset return percentage |
| Internal Rate of Return | irr | `pct_irr` | Discount rate for NPV=0 |
| Net Present Value | npv | `amt_npv` | Discounted cash flow value |
| Year to Date | ytd | `amt_pnl_ytd` | Accumulated since Jan 1 |
| Month to Date | mtd | `amt_pnl_mtd` | Accumulated since month start |
| Yield to Maturity | ytm | `pct_ytm` | Bond total return if held |
| Duration | dur | `dur_mod` | Interest rate sensitivity |
| Convexity | convx | `convx_bond` | Second-order duration |
| Sharpe Ratio | sharpe | `ratio_sharpe` | Risk-adjusted return |
| Beta | beta | `beta_asset` | Market sensitivity |
| Alpha | alpha | `alpha_portf` | Excess return |
| Volatility | vol | `vol_ann` | Price variation measure |

### 2.5 Dates and Time

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| date | _date (suffix) | `due_date` |
| timestamp | _at (suffix) | `created_at` |
| date (prefix style) | dt_ | `dt_issue` |
| time / hour | tm | `tm_start` |
| year | yr | `yr_ref` |
| month | mth | `mth_ref` |
| day | day | `day_due` |
| week | wk | `nr_wk` |
| period | per | `cd_per` |
| due | due | `due_date` |
| issue | issue | `issue_date` |
| payment | pymt | `pymt_date` |
| start / begin | start | `start_date` |
| end | end | `end_date` |
| creation / created | created | `created_at` |
| update / updated | updated | `updated_at` |
| registration | reg | `reg_date` |
| competence | comp | `comp_date` |
| processing | proc | `processed_at` |
| settlement | sttl | `sttl_date` |
| maturity | mat | `mat_date` |
| expiration | exp | `exp_date` |
| trade | trade | `trade_date` |
| value (settlement) | value | `value_date` |
| effective | eff | `eff_date` |
| anticipated | antcp | `antcp_at` |
| end of day | eod | `eod_date` |
| beginning of day | bod | `bod_date` |

### 2.6 Status and Indicators (dbt Best Practice)

Use `is_` for state/condition and `has_` for possession/existence:

| Original Word | Naming Pattern | Usage Example |
|---------------|----------------|---------------|
| active | is_ | `is_active` |
| inactive | is_ | `is_inactive` |
| canceled | is_ | `is_canceled` |
| approved | is_ | `is_approved` |
| pending | is_ | `is_pending` |
| processed | is_ | `is_processed` |
| defaulted | is_ | `is_defaulted` |
| overdue | is_ | `is_overdue` |
| settled | is_ | `is_settled` |
| matured | is_ | `is_matured` |
| redeemed | is_ | `is_redeemed` |
| resale | is_ | `is_resale` |
| coobligation | has_ | `has_coobligation` |
| collateral | has_ | `has_collateral` |
| guarantee | has_ | `has_guarantee` |
| insurance | has_ | `has_insurance` |
| grace period | has_ | `has_grace_period` |

Additional status fields:

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| status | st | `st_order` |
| situation | sit | `cd_sit` |
| type | tp | `tp_customer` |
| indicator | ind | `ind_risk` |

### 2.7 Actions and Processes

| Original Word | Abbreviation | Usage Example |
|---------------|--------------|---------------|
| anticipation | antcp | `amt_antcp` |
| financing | fin | `cd_fin` |
| receipt / receiving | recv | `recv_date` |
| billing / collection | bill | `cd_bill` |
| transfer | transf | `cd_transf` |
| write-off | woff | `woff_date` |
| reversal | rev | `amt_rev` |
| return | ret | `amt_ret` |
| acquisition | acq | `amt_acq` |
| redemption | redmp | `redmp_date` |
| amortization | amort | `amt_amort` |
| depreciation | depr | `amt_depr` |
| accrual | accr | `amt_accr` |
| provision | prov | `amt_prov` |
| impairment | impair | `amt_impair` |
| hedge | hedge | `id_hedge` |
| netting | net | `amt_net` |
| clearing | clear | `clear_date` |

### 2.8 Credit Risk Terms (Basel/Regulatory)

| Term | Abbreviation | Usage Example | Description |
|------|--------------|---------------|-------------|
| Probability of Default | pd | `pct_pd` | Likelihood of default |
| Loss Given Default | lgd | `pct_lgd` | Loss if default occurs |
| Exposure at Default | ead | `amt_ead` | Amount exposed at default |
| Expected Loss | el | `amt_el` | PD × LGD × EAD |
| Unexpected Loss | ul | `amt_ul` | Loss beyond expected |
| Loan to Value | ltv | `pct_ltv` | Loan / collateral ratio |
| Value at Risk | var | `amt_var` | Max loss at confidence |
| Conditional VaR / CVaR | cvar | `amt_cvar` | Expected shortfall |
| Risk Weighted Assets | rwa | `amt_rwa` | Capital requirement base |
| Credit Rating | rating | `cd_rating` | Creditworthiness grade |
| Score | score | `score_credit` | Numeric credit score |
| Default | dflt | `is_dflt` | Default indicator |
| Recovery | recov | `amt_recov` | Amount recovered |
| Write-off | woff | `amt_woff` | Amount written off |
| Provision | prov | `amt_prov` | Reserve for losses |
| Days Past Due | dpd | `qty_dpd` | Days overdue |
| Non-Performing | npl | `is_npl` | Non-performing flag |
| Watch List | watch | `is_watch` | Monitoring flag |
| Concentration | conc | `pct_conc` | Portfolio concentration |

### 2.9 Trading and Treasury

| Term | Abbreviation | Usage Example | Description |
|------|--------------|---------------|-------------|
| Foreign Exchange | fx | `rate_fx` | Currency exchange |
| Over the Counter | otc | `is_otc` | Non-exchange traded |
| Non-Deliverable Forward | ndf | `id_ndf` | FX forward contract |
| Interest Rate Swap | irs | `id_irs` | Interest swap contract |
| Credit Default Swap | cds | `id_cds` | Credit derivative |
| Collateralized Debt Obligation | cdo | `id_cdo` | Structured product |
| Asset Backed Security | abs | `id_abs` | Securitized asset |
| Mortgage Backed Security | mbs | `id_mbs` | Mortgage securitization |
| End of Day | eod | `amt_eod` | Day-end value |
| Beginning of Day | bod | `amt_bod` | Day-start value |
| Intraday | intrad | `amt_intrad` | Within-day value |
| Spot | spot | `rate_spot` | Immediate delivery rate |
| Forward | fwd | `rate_fwd` | Future delivery rate |
| Futures | fut | `prc_fut` | Exchange-traded forward |
| Option | opt | `prc_opt` | Option contract |
| Strike | strike | `prc_strike` | Option exercise price |
| Delta | delta | `delta_opt` | Option price sensitivity |
| Gamma | gamma | `gamma_opt` | Delta sensitivity |
| Theta | theta | `theta_opt` | Time decay |
| Vega | vega | `vega_opt` | Volatility sensitivity |
| Bid | bid | `prc_bid` | Buy price |
| Ask / Offer | ask | `prc_ask` | Sell price |
| Mid | mid | `prc_mid` | Average bid/ask |
| Last | last | `prc_last` | Last traded price |
| Volume | vol | `qty_vol` | Trading volume |
| Open Interest | oi | `qty_oi` | Open contracts |
| ISIN | isin | `cd_isin` | Security identifier |
| CUSIP | cusip | `cd_cusip` | US security ID |
| Ticker | ticker | `cd_ticker` | Trading symbol |

### 2.10 Receivables and Securitization (Brazilian Context)

| Term | Abbreviation | Usage Example | Description |
|------|--------------|---------------|-------------|
| Receivable | recv | `id_recv` | Credit right |
| Invoice Financing | inv_fin | `id_inv_fin` | Invoice-backed loan |
| Factoring | fact | `id_fact` | Receivables purchase |
| FIDC | fidc | `id_fidc` | Credit rights fund |
| Securitization | sctz | `id_sctz` | Asset-backed issuance |
| Tranche | tranche | `tp_tranche` | Risk layer (senior/sub) |
| Senior | senior | `is_senior` | Priority tranche |
| Subordinated / Mezz | sub | `is_sub` | Junior tranche |
| Equity | equity | `is_equity` | First-loss tranche |
| Collateral | collat | `amt_collat` | Backing asset |
| Coobligation | coobl | `has_coobl` | Joint obligation |
| Assignment | assign | `assign_date` | Transfer of rights |
| Cession | cess | `cess_date` | Credit transfer |
| Advance | adv | `amt_adv` | Prepayment |
| Dilution | dilut | `pct_dilut` | Payment reduction |
| Prepayment | prepay | `amt_prepay` | Early payment |
| Delinquency | delinq | `pct_delinq` | Late payment rate |
| Pool | pool | `id_pool` | Asset group |
| Waterfall | wfall | `cd_wfall` | Payment priority |
| Credit Enhancement | ce | `pct_ce` | Protection level |
| Excess Spread | xs | `pct_xs` | Yield over funding |
| CNAB Control Number | cnab_ctrl | `nr_cnab_ctrl` | Bank file control |
| CNAB Document Number | cnab_doc | `nr_cnab_doc` | Bank file document |
| Boleto | boleto | `nr_boleto` | Payment slip |
| PIX | pix | `cd_pix` | Instant payment ID |

---

## 3. Data Type Prefixes

| Prefix | Type | Example |
|--------|------|---------|
| `id_` | Unique identifier (PK/FK) | `id_customer` |
| `cd_` | Business code | `cd_product` |
| `nr_` | Sequential number/document | `nr_order` |
| `amt_` | Monetary value/amount | `amt_total` |
| `qty_` | Quantity | `qty_items` |
| `pct_` | Percentage (0-100) | `pct_discount` |
| `rate_` | Rate (decimal, e.g., 0.05) | `rate_interest` |
| `desc_` | Description/Text | `desc_product` |
| `nm_` | Name | `nm_customer` |
| `tp_` | Type/Category | `tp_operation` |
| `st_` | Status | `st_order` |
| `is_` | Boolean state/condition | `is_active` |
| `has_` | Boolean possession/existence | `has_collateral` |

**Date/Time (choose one style consistently):**

| Style | Format | Example |
|-------|--------|---------|
| Suffix (dbt recommended) | `column_date` / `column_at` | `due_date`, `created_at` |
| Prefix (abbreviated) | `dt_column` / `tm_column` | `dt_due`, `tm_created` |

---

## 4. Aggregation Prefixes

Use these prefixes for aggregated/calculated columns:

| Prefix | Aggregation | Example |
|--------|-------------|---------|
| `sum_` | Sum | `sum_amt_sales` |
| `cnt_` | Count | `cnt_orders` |
| `avg_` | Average | `avg_amt_ticket` |
| `min_` | Minimum | `min_amt_order` |
| `max_` | Maximum | `max_amt_order` |
| `pct_` | Percentage | `pct_share` |
| `ratio_` | Ratio | `ratio_ltv` |
| `cum_` | Cumulative | `cum_amt_sales` |
| `delta_` | Change/Difference | `delta_bal` |
| `rank_` | Ranking | `rank_revenue` |

---

## 5. Contextual Suffixes

| Suffix | Usage | Example |
|--------|-------|---------|
| `_orig` | Original value | `amt_orig` |
| `_calc` | Calculated value | `amt_calc` |
| `_est` | Estimated | `amt_est` |
| `_actual` | Actual/Realized | `amt_actual` |
| `_budget` | Budgeted | `amt_budget` |
| `_target` | Target | `amt_target` |
| `_exp` | Expected | `exp_date` |
| `_eff` | Effective | `eff_date` |
| `_prev` | Previous | `bal_prev` |
| `_curr` | Current | `bal_curr` |
| `_pre` | Before (context) | `amt_pre_fees` |
| `_post` | After (context) | `amt_post_fees` |
| `_gross` | Before deductions | `amt_gross` |
| `_net` | After deductions | `amt_net` |
| `_ann` | Annualized | `rate_ann` |
| `_daily` | Daily | `rate_daily` |
| `_mth` | Monthly | `amt_mth` |
| `_ytd` | Year to date | `amt_ytd` |
| `_mtd` | Month to date | `amt_mtd` |
| `_wtd` | Week to date | `amt_wtd` |

---

## 6. Currency and Unit Suffixes

Use these suffixes when the unit is not obvious from context:

| Suffix | Unit | Example |
|--------|------|---------|
| `_brl` | Brazilian Real | `amt_total_brl` |
| `_usd` | US Dollar | `amt_total_usd` |
| `_eur` | Euro | `amt_total_eur` |
| `_local` | Local currency | `amt_local` |
| `_base` | Base currency | `amt_base` |
| `_pct` | Percentage points | `spread_pct` |
| `_bps` | Basis points (0.01%) | `spread_bps` |
| `_days` | Days count | `tenor_days` |
| `_months` | Months count | `tenor_months` |
| `_years` | Years count | `dur_years` |
| `_kg` | Kilograms | `weight_kg` |
| `_units` | Unit count | `qty_units` |

---

## 7. Compound Name Rules

1. **Maximum 3-4 words** combined (prefix + entity + qualifier + suffix)
2. **Order**: `prefix_entity_qualifier_suffix`
   - E.g., `amt_order_net_brl` (net order amount in BRL)
3. **Avoid redundancy**: don't repeat table context in column name
   - Bad: `order_nr_order` → Good: `nr_order`
4. **Be specific**: use qualifiers to disambiguate
   - Bad: `amount` → Good: `amt_principal`, `amt_interest`
5. **Consistent abbreviations**: always use the same abbreviation for a term

---

## 8. Agent Conversion Rules

```
COLUMN RENAMING RULES:

1. INITIAL NORMALIZATION:
   - Convert to lowercase
   - Replace spaces and hyphens with underscore (_)
   - Remove accents and special characters
   - Remove quotes

2. APPLY TYPE PREFIX OR SUFFIX:
   - If unique identifier → prefix with "id_"
   - If business code → prefix with "cd_"
   - If number/document → prefix with "nr_"
   - If date-only → use suffix "_date" (preferred) or prefix "dt_"
   - If timestamp → use suffix "_at" (preferred) or prefix "tm_"
   - If monetary value → prefix with "amt_"
   - If quantity → prefix with "qty_"
   - If percentage → prefix with "pct_"
   - If rate (decimal) → prefix with "rate_"
   - If descriptive text → prefix with "desc_"
   - If boolean state → prefix with "is_"
   - If boolean possession → prefix with "has_"
   - If type/category → prefix with "tp_"
   - If status → prefix with "st_"
   - If name → prefix with "nm_"

3. APPLY DICTIONARY ABBREVIATIONS:
   - Replace full words with listed abbreviations
   - Use industry-standard acronyms (PD, LGD, NAV, etc.)
   - Prioritize 3-4 character abbreviations
   - Maintain readability

4. APPLY CONTEXT SUFFIXES:
   - Add currency suffix if multi-currency (_brl, _usd)
   - Add time context if needed (_ytd, _mtd, _ann)
   - Add value context (_net, _gross, _orig)

5. VALIDATE SIZE:
   - If name > 30 characters, abbreviate more aggressively
   - Remove prepositions (of, the, for, in, at)
   - Use acronyms when applicable

6. FINAL FORMAT:
   - snake_case
   - No special characters
   - No numbers at the beginning
   - Maximum 30 characters

INPUT → OUTPUT EXAMPLES:

# Dates and Timestamps
"created_at" → created_at
"updated_at" → updated_at
"Due Date" → due_date
"Settlement Date" → sttl_date
"Maturity Date" → mat_date
"Trade Date" → trade_date

# Identifiers
"Transaction Identifier" → id_txn
"invoice_financing_id" → id_inv_fin
"Customer Code" → cd_cust
"ISIN Code" → cd_isin

# Amounts
"Total Order Value" → amt_tot_ord
"Net Anticipation Amount" → amt_net_antcp
"Acquisition Price" → amt_acq
"Future Amount" → amt_future
"Mark to Market Value" → amt_mtm
"Net Asset Value" → amt_nav

# Rates and Percentages
"Document Interest Rate" → rate_int_doc
"Discount Percentage" → pct_disc
"bank_cut_percentage" → pct_cut_bnk
"LTV Ratio" → pct_ltv
"Probability of Default" → pct_pd

# Booleans
"anticipated" → is_antcp
"resale" → is_resale
"coobligation" → has_coobl
"Is Active" → is_active
"Has Collateral" → has_collat

# Names and Descriptions
"Supplier Name" → nm_suppl
"Seller Name" → nm_seller
"Product Description" → desc_prod

# Credit Risk
"Expected Loss" → amt_el
"Loss Given Default" → pct_lgd
"Exposure at Default" → amt_ead
"Days Past Due" → qty_dpd

# Trading
"Spot Rate" → rate_spot
"Bid Price" → prc_bid
"Trading Volume" → qty_vol

# Receivables/FIDC
"Receivable ID" → id_recv
"Tranche Type" → tp_tranche
"Credit Enhancement" → pct_ce
"CNAB Control Number" → nr_cnab_ctrl
```

---

## 9. Agent Usage Prompt

When renaming columns, use the following prompt:

```
Given the original column name: "[ORIGINAL_NAME]"

1. Identify the semantic type of the column (date, amount, code, boolean, etc.)
2. Apply the appropriate prefix/suffix according to the rules:
   - Booleans: is_ (state) or has_ (possession)
   - Timestamps: _at suffix
   - Dates: _date suffix
   - Amounts: amt_ prefix
   - Percentages: pct_ prefix
   - Rates: rate_ prefix
3. Replace words with dictionary abbreviations
4. Use industry-standard acronyms (PD, LGD, MTM, NAV, etc.)
5. Remove prepositions and articles
6. Ensure snake_case format without special characters
7. Add currency/unit suffix if needed for clarity
8. Limit to 30 characters

Return: abbreviated_name
```

---

## 10. Quick Reference Card

| Data Type | Prefix/Suffix | Example |
|-----------|---------------|---------|
| Primary Key | `id_` | `id_customer` |
| Foreign Key | `id_` | `id_order` |
| Business Code | `cd_` | `cd_product` |
| Document Number | `nr_` | `nr_invoice` |
| Date | `_date` | `due_date` |
| Timestamp | `_at` | `created_at` |
| Amount | `amt_` | `amt_total` |
| Quantity | `qty_` | `qty_items` |
| Percentage | `pct_` | `pct_discount` |
| Rate | `rate_` | `rate_interest` |
| Boolean (state) | `is_` | `is_active` |
| Boolean (has) | `has_` | `has_collateral` |
| Name | `nm_` | `nm_customer` |
| Description | `desc_` | `desc_product` |
| Type | `tp_` | `tp_asset` |
| Status | `st_` | `st_order` |
| Sum | `sum_` | `sum_amt_sales` |
| Count | `cnt_` | `cnt_orders` |
| Average | `avg_` | `avg_amt_ticket` |

---

This standard ensures consistency, readability, and compact names for your OLAP data warehouse, aligned with financial industry best practices.
