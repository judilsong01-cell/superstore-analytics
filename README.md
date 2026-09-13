# Retail Profitability Analysis in R | Superstore

Reproducible analysis of **9,994 orders** from an office supplies and furniture retailer
(Sample Superstore dataset) to find where profit is made — and where it is being destroyed.

**Stack:** R 4.5.2 · base R only · no external dependencies

---

## Headline finding

> **Discounts of 30% and above always lose money.**
> Up to 20% the margin stays positive. At 30% it turns to −10%.
> At 80% the business loses 1.80 USD for every 1 USD sold.

![Margin by discount level](06_GRAFICOS/margin_by_discount.png)

| Discount | Sales (USD) | Profit (USD) | Margin | Orders |
|---:|---:|---:|---:|---:|
| 0% | 1,087,908 | +320,988 | **+29.5%** | 4,798 |
| 10% | 54,369 | +9,029 | +16.6% | 94 |
| 15% | 27,559 | +1,419 | +5.1% | 52 |
| 20% | 764,594 | +90,337 | +11.8% | 3,657 |
| 30% | 103,227 | −10,369 | **−10.0%** | 227 |
| 40% | 116,418 | −23,057 | −19.8% | 206 |
| 50% | 58,919 | −20,506 | −34.8% | 66 |
| 70% | 40,620 | −40,075 | −98.7% | 418 |
| 80% | 16,964 | −30,539 | **−180.0%** | 300 |

In practical terms: the 1,393 orders discounted at 30% or more cost roughly **135,000 USD** in
profit. Capping discounts at 20% would recover most of that.

## Other findings

**Three sub-categories lose money:**

| Sub-category | Sales | Profit | Margin |
|---|---:|---:|---:|
| Tables | 206,966 | **−17,725** | −8.6% |
| Bookcases | 114,880 | −3,473 | −3.0% |
| Supplies | 46,674 | −1,189 | −2.5% |

![Profit by sub-category](06_GRAFICOS/profit_by_sub_category.png)

**The best margins are not the biggest products.** Labels (44.4%), Paper (43.4%) and Envelopes
(42.3%) lead on profitability but carry little volume. Copiers combine a strong margin (37.2%)
with meaningful volume (149,528 USD).

**By category:** Technology 17.4% · Office Supplies 17.0% · Furniture just **2.5%**.
Furniture sells almost as much as Technology (742k vs 836k USD) and returns seven times less
profit — this is where Tables and Bookcases sit.

**By region:** West 14.9% · East 13.5% · South 11.9% · Central **7.9%**.

**Monthly** sales and profit are in `07_TABELAS/performance_monthly.csv`.

![Monthly sales and profit](06_GRAFICOS/monthly_sales_profit.png)

## Method

1. **Import** — CSV read with Latin-1 encoding (the file contains accented characters in names).
2. **Inspect** — dimensions, missing values and exact duplicates measured before cleaning.
3. **Clean** — snake_case column names; textual missing markers converted to real NA.
4. **Transform** — dates parsed and **validated**: the pipeline fails if any date cannot be parsed
   or if any shipment predates its order. Derives `order_year`, `order_month`, `prazo_envio`
   (shipping lead time) and `profit_margin`.
5. **Validate** — quality record written to `07_TABELAS/validacao_limpeza.csv`.
6. **Analyse, plot and export.**

**Data quality:** 9,994 rows to 9,994 rows · 0 missing values · 0 exact duplicates · 0 rows removed.

## Reproduce

```bash
Rscript 04_SCRIPTS_R/09_executar_pipeline.R
```

Run from the project root. No packages to install.

## Structure

```
01_DADOS_BRUTOS/    raw data, immutable
03_DADOS_LIMPOS/    cleaned data, pipeline output
04_SCRIPTS_R/       9 stages, one per file
05_NOTEBOOKS/       R Markdown notebook for Kaggle
06_GRAFICOS/        PNG charts
07_TABELAS/         result tables as CSV
09_DOCUMENTACAO/    data dictionary and dependencies
```

## Limitations

The data is observational. The association between deep discounts and losses is clear, but the
discounts may be applied precisely to products that were already unprofitable or to dead stock —
this analysis does not establish the direction of the relationship. Before imposing a discount
cap, it would be necessary to understand the commercial rule that produced the existing discounts.

## Data

Sample Superstore — a demonstration dataset shipped with Tableau and widely republished on Kaggle.
Fictional data. The original CSV sits unchanged in `01_DADOS_BRUTOS`.

## Licence

Code released under the MIT Licence (see `LICENSE`). The dataset keeps the terms of its original source.
