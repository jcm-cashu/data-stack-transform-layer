{{ config(materialized='table', alias='int_cashu_app__cadastro_scr_modalidades') }}

with data as (
    select *
    from values
        ('Adiantamentos a Depositantes', '0101', 'Adiantamentos a Depositantes', 'Advances to Depositors', 'Advances to Depositors'),

        ('Empréstimos', '0202', 'Crédito Pessoal - com Consignação em Folha de Pagamento', 'Loans', 'Personal Loan - Payroll-Deducted (Consigned)'),
        ('Empréstimos', '0203', 'Crédito Pessoal - sem Consignação em Folha de Pagamento', 'Loans', 'Personal Loan - Non-Consigned (No Payroll Deduction)'),
        ('Empréstimos', '0204', 'Crédito Rotativo Vinculado a Cartão de Crédito', 'Loans', 'Revolving Credit Linked to Credit Card'),
        ('Empréstimos', '0207', 'Vendor', 'Loans', 'Vendor'),
        ('Empréstimos', '0208', 'Compror', 'Loans', 'Compror'),
        ('Empréstimos', '0209', 'ARO - Adiantamento de Receitas Orçamentárias', 'Loans', 'ARO - Advance of Budget Revenues'),
        ('Empréstimos', '0210', 'Cartão de Crédito – Compra, Fatura Parcelada ou Saque Financiado pela Instituição Emitente do Cartão', 'Loans', 'Credit Card – Purchase, Installment Invoice or Cash Advance Financed by the Card Issuer'),
        ('Empréstimos', '0211', 'Home Equity', 'Loans', 'Home Equity'),
        ('Empréstimos', '0212', 'Microcrédito', 'Loans', 'Microcredit'),
        ('Empréstimos', '0213', 'Cheque Especial', 'Loans', 'Overdraft (Cheque Especial)'),
        ('Empréstimos', '0214', 'Conta Garantida', 'Loans', 'Guaranteed Account (Conta Garantida)'),
        ('Empréstimos', '0215', 'Capital de Giro com Prazo de Vencimento Até 365 Dias', 'Loans', 'Working Capital with Maturity up to 365 Days'),
        ('Empréstimos', '0216', 'Capital de Giro com Prazo Vencimento Superior 365 Dias', 'Loans', 'Working Capital with Maturity over 365 Days'),
        ('Empréstimos', '0217', 'Capital de Giro com Teto Rotativo', 'Loans', 'Working Capital with Revolving Limit'),
        ('Empréstimos', '0218', 'Cartão de Crédito - Não Migrado', 'Loans', 'Credit Card - Not Migrated'),
        ('Empréstimos', '0250', 'Recebíveis Adquiridos', 'Loans', 'Purchased Receivables'),
        ('Empréstimos', '0290', 'Financiamento de Projeto', 'Loans', 'Project Finance'),
        ('Empréstimos', '0299', 'Outros Empréstimos', 'Loans', 'Other Loans'),

        ('Direitos Creditórios Descontados', '0301', 'Desconto de Duplicatas', 'Discounted Receivables', 'Invoice Receivables Discounting (Duplicatas)'),
        ('Direitos Creditórios Descontados', '0302', 'Desconto de Cheques', 'Discounted Receivables', 'Check Discounting'),
        ('Direitos Creditórios Descontados', '0303', 'Antecipação de Fatura de Cartão de Crédito', 'Discounted Receivables', 'Credit Card Invoice Receivables Advance'),
        ('Direitos Creditórios Descontados', '0398', 'Outros Direitos Creditórios Descontados', 'Discounted Receivables', 'Other Discounted Receivables'),
        ('Direitos Creditórios Descontados', '0399', 'Outros Títulos Descontados', 'Discounted Receivables', 'Other Discounted Instruments'),

        ('Financiamentos', '0401', 'Aquisição de Bens – Veículos Automotores', 'Financing', 'Asset Acquisition – Motor Vehicles'),
        ('Financiamentos', '0402', 'Aquisição de Bens – Outros Bens', 'Financing', 'Asset Acquisition – Other Assets'),
        ('Financiamentos', '0403', 'Microcrédito', 'Financing', 'Microcredit'),
        ('Financiamentos', '0404', 'Vendor', 'Financing', 'Vendor'),
        ('Financiamentos', '0405', 'Compror', 'Financing', 'Compror'),
        ('Financiamentos', '0406', 'Cartão de Crédito – Compra ou Fatura Parcelada pela Instituição Financeira Emitente do Cartão', 'Financing', 'Credit Card – Purchase or Installment Invoice Financed by the Card Issuer Financial Institution'),
        ('Financiamentos', '0440', 'Financiamentos Agroindustriais', 'Financing', 'Agroindustrial Financing'),
        ('Financiamentos', '0450', 'Recebíveis Adquiridos', 'Financing', 'Purchased Receivables'),
        ('Financiamentos', '0490', 'Financiamento de Projeto', 'Financing', 'Project Finance'),
        ('Financiamentos', '0499', 'Outros Financiamentos', 'Financing', 'Other Financing'),

        ('Financiamentos à Exportação', '0501', 'Financiamento à Exportação', 'Export Financing', 'Export Financing'),
        ('Financiamentos à Exportação', '0502', 'Adiantamento sobre Contratos de Câmbio', 'Export Financing', 'Advance on Foreign Exchange Contracts'),
        ('Financiamentos à Exportação', '0503', 'Adiantamento sobre Cambiais Entregues', 'Export Financing', 'Advance on Delivered Bills of Exchange'),
        ('Financiamentos à Exportação', '0504', 'Créditos Decorrentes de Contratos de Exportação–Export Note', 'Export Financing', 'Credits Arising from Export Contracts – Export Note'),
        ('Financiamentos à Exportação', '0590', 'Financiamento de Projeto', 'Export Financing', 'Project Finance'),
        ('Financiamentos à Exportação', '0599', 'Outros Financiamentos à Exportação', 'Export Financing', 'Other Export Financing'),

        ('Financiamentos à Importação', '0601', 'Financiamento à Importação', 'Import Financing', 'Import Financing'),
        ('Financiamentos à Importação', '0690', 'Financiamento de Projeto', 'Import Financing', 'Project Finance'),

        ('Financiamentos com Interveniência', '0701', 'Aquisição de Bens com Interveniência – Veículos Automotores', 'Financing with Intermediation', 'Asset Acquisition with Intermediation – Motor Vehicles'),
        ('Financiamentos com Interveniência', '0702', 'Aquisição de Bens com Interveniência – Outros Bens', 'Financing with Intermediation', 'Asset Acquisition with Intermediation – Other Assets'),
        ('Financiamentos com Interveniência', '0790', 'Financiamento de Projeto', 'Financing with Intermediation', 'Project Finance'),
        ('Financiamentos com Interveniência', '0799', 'Outros Financiamentos com Interveniência', 'Financing with Intermediation', 'Other Financing with Intermediation'),

        ('Financiamentos Rurais', '0801', 'Custeio', 'Rural Financing', 'Operating Costs (Custeio)'),
        ('Financiamentos Rurais', '0802', 'Investimento', 'Rural Financing', 'Investment'),
        ('Financiamentos Rurais', '0803', 'Comercialização', 'Rural Financing', 'Commercialization'),
        ('Financiamentos Rurais', '0804', 'Industrialização', 'Rural Financing', 'Industrialization'),

        ('Financiamentos Imobiliários', '0901', 'Financiamento Habitacional – SFH', 'Real Estate Financing', 'Housing Finance – SFH'),
        ('Financiamentos Imobiliários', '0902', 'Financiamento Habitacional – Exceto SFH', 'Real Estate Financing', 'Housing Finance – Non-SFH'),
        ('Financiamentos Imobiliários', '0903', 'Financiamento Imobiliário – Empreendimentos, Exceto Habitacional', 'Real Estate Financing', 'Real Estate Development Financing – Non-Residential'),
        ('Financiamentos Imobiliários', '0990', 'Financiamento de Projeto', 'Real Estate Financing', 'Project Finance'),

        ('Financiamentos de Infraestrutura e Desenvolvimento', '1101', 'Financiamento de Infraestrutura e Desenvolvimento', 'Infrastructure & Development Financing', 'Infrastructure & Development Financing'),
        ('Financiamentos de Infraestrutura e Desenvolvimento', '1190', 'Financiamento de Projeto', 'Infrastructure & Development Financing', 'Project Finance'),

        ('Operações de Arrendamento', '1201', 'Arrendamento Financeiro Exceto Veículos Automotores e Imóveis', 'Leasing Operations', 'Financial Leasing Except Motor Vehicles and Real Estate'),
        ('Operações de Arrendamento', '1202', 'Arrendamento Financeiro Imobiliário', 'Leasing Operations', 'Real Estate Financial Leasing'),
        ('Operações de Arrendamento', '1203', 'Subarrendamento', 'Leasing Operations', 'Subleasing'),
        ('Operações de Arrendamento', '1205', 'Arrendamento Operacional', 'Leasing Operations', 'Operating Lease'),
        ('Operações de Arrendamento', '1206', 'Arrendamento Financeiro de Veículos Automotores', 'Leasing Operations', 'Motor Vehicle Financial Leasing'),
        ('Operações de Arrendamento', '1290', 'Financiamento de Projeto', 'Leasing Operations', 'Project Finance'),

        ('Outros Créditos', '1301', 'Avais e Fianças Honrados', 'Other Credits', 'Honored Endorsements and Guarantees'),
        ('Outros Créditos', '1302', 'Devedores por Compra de Valores e Bens', 'Other Credits', 'Debtors from Purchase of Securities and Goods'),
        ('Outros Créditos', '1303', 'Títulos e Créditos a Receber', 'Other Credits', 'Securities and Credits Receivable'),
        ('Outros Créditos', '1304', 'Cartão de Crédito – Compra à Vista e Parcelado Lojista', 'Other Credits', 'Credit Card – Immediate Purchase and Merchant Installments'),
        ('Outros Créditos', '1350', 'Recebíveis Adquiridos', 'Other Credits', 'Purchased Receivables'),
        ('Outros Créditos', '1390', 'Financiamento de Projeto', 'Other Credits', 'Project Finance'),
        ('Outros Créditos', '1399', 'Outros com Característica de Crédito', 'Other Credits', 'Others with Credit Characteristics'),

        ('Relações Interfinanceiras', '1401', 'Repasses Interfinanceiros', 'Interfinancial Relations', 'Interfinancial Transfers'),
        ('Relações Interfinanceiras', '1402', 'Recebíveis de Arranjo de Pagamento', 'Interfinancial Relations', 'Payment Scheme Receivables'),
        ('Relações Interfinanceiras', '1403', 'Outros Valores a Receber Relativos a Transações de Pagamento', 'Interfinancial Relations', 'Other Receivables Related to Payment Transactions'),

        ('Coobrigações', '1501', 'Beneficiários de Garantias Prestadas para Operações com PJ Financeira', 'Co-obligations', 'Beneficiaries of Guarantees Provided for Transactions with Financial Legal Entities'),
        ('Coobrigações', '1502', 'Beneficiários de Garantias Prestadas para Operações com Outras Pessoas', 'Co-obligations', 'Beneficiaries of Guarantees Provided for Transactions with Other Persons'),
        ('Coobrigações', '1503', 'Beneficiários de Garantias Prestadas para Fundos Constitucionais', 'Co-obligations', 'Beneficiaries of Guarantees Provided for Constitutional Funds'),
        ('Coobrigações', '1504', 'Beneficiários de Garantias Prestadas para Participação em Processo Licitatório', 'Co-obligations', 'Beneficiaries of Guarantees Provided for Participation in Bidding Processes'),
        ('Coobrigações', '1505', 'Carta de Crédito de Importação', 'Co-obligations', 'Import Letter of Credit'),
        ('Coobrigações', '1511', 'Coobrigação Assumida em Cessão com Coobrigação para Pessoa Integrante do SFN', 'Co-obligations', 'Co-obligation Assumed in Assignment with Co-obligation to an SFN Member'),
        ('Coobrigações', '1512', 'Coobrigação Assumida Em Cessão com Coobrigação para Pessoa Não Integrante Do Sfn, Inclusive Securitizadora e Fundos de Investimento', 'Co-obligations', 'Co-obligation Assumed in Assignment with Co-obligation to a Non-SFN Entity, Including Securitizers and Investment Funds'),
        ('Coobrigações', '1513', 'Beneficiários de Outras Coobrigações', 'Co-obligations', 'Beneficiaries of Other Co-obligations'),
        ('Coobrigações', '1590', 'Financiamento de Projeto', 'Co-obligations', 'Project Finance'),
        ('Coobrigações', '1599', 'Beneficiários de Outras Garantias Prestadas', 'Co-obligations', 'Beneficiaries of Other Guarantees Provided'),

        ('Títulos de Crédito Fora da Carteira Classificada', '1801', 'CPR - Cédula de Produto Rural', 'Credit Instruments Outside Classified Portfolio', 'CPR - Rural Product Note'),
        ('Títulos de Crédito Fora da Carteira Classificada', '1802', 'EN - Nota de Exportação', 'Credit Instruments Outside Classified Portfolio', 'EN - Export Note'),
        ('Títulos de Crédito Fora da Carteira Classificada', '1803', 'Debêntures', 'Credit Instruments Outside Classified Portfolio', 'Debentures'),
        ('Títulos de Crédito Fora da Carteira Classificada', '1804', 'Notas Comerciais', 'Credit Instruments Outside Classified Portfolio', 'Commercial Notes'),
        ('Títulos de Crédito Fora da Carteira Classificada', '1899', 'Outros', 'Credit Instruments Outside Classified Portfolio', 'Others'),

        ('Limite', '1901', 'Limite Global', 'Limit', 'Global Limit'),
        ('Limite', '1902', 'Cheque Especial', 'Limit', 'Overdraft (Cheque Especial)'),
        ('Limite', '1903', 'Conta Garantida', 'Limit', 'Guaranteed Account (Conta Garantida)'),
        ('Limite', '1904', 'Cartão de Crédito', 'Limit', 'Credit Card Limit'),
        ('Limite', '1905', 'Capital de Giro', 'Limit', 'Working Capital Limit'),
        ('Limite', '1906', 'Crédito Pessoal', 'Limit', 'Personal Credit Limit'),
        ('Limite', '1907', 'Vendor', 'Limit', 'Vendor'),
        ('Limite', '1908', 'Compror', 'Limit', 'Compror'),
        ('Limite', '1909', 'Descontos', 'Limit', 'Discounts Limit'),
        ('Limite', '1910', 'Aquisição de Bens', 'Limit', 'Asset Acquisition Limit'),
        ('Limite', '1999', 'Outros', 'Limit', 'Others'),

        ('Retenção de Risco', '2001', 'Retenção de Risco Assumida por Aquisição de Cotas de Fundos', 'Risk Retention', 'Risk Retention Assumed via Acquisition of Fund Quotas'),
        ('Retenção de Risco', '2002', 'Retenção de Risco Assumida por Aquisição de Instrumentos com Lastros Em Operações de Crédito', 'Risk Retention', 'Risk Retention Assumed via Acquisition of Instruments Backed by Credit Operations')
    as t(
        tp_scr_modality_group_pt,
        cd_scr_modality,
        desc_scr_modality_pt,
        tp_scr_modality_group_en,
        desc_scr_modality_en
    )
)

select
    tp_scr_modality_group_pt,
    tp_scr_modality_group_en,
    cd_scr_modality,
    desc_scr_modality_pt,
    desc_scr_modality_en
from data

