---
title: Toronto Housing Bottleneck Analytics
description: An end-to-end Analytics Engineering project using City of Toronto building-permit data, with one shared dbt project for DuckDB and Snowflake and a deployed Streamlit dashboard.
status: flagship
thumbnail: ./images/toronto-pipeline.png
thumbnailAlt: "Four-stage architecture showing Toronto Open Data ingestion, observed SCD Type 2 history, DuckDB and Snowflake as warehouse targets for a shared dbt analytics layer, and published dbt documentation and Streamlit dashboard outputs."
technologies:
  - Python
  - dlt
  - Parquet
  - SCD Type 2
  - DuckDB
  - Snowflake
  - dbt
  - GitHub Actions
  - Streamlit
showOnHome: true
sortOrder: 1
repositoryUrl: https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics
dbtDocsUrl: https://gagadanalyst.github.io/toronto-housing-bottleneck-analytics/
dashboardUrl: https://toronto-housing-bottleneck.streamlit.app/
---

## Project objective

City of Toronto Active and Cleared building-permit extracts provide useful attributes and recorded outcomes, but they do not provide a complete longitudinal status history. This project builds a reproducible ingestion and analytics workflow to preserve changes observed across successive extracts, make source-data quality visible, and publish descriptive analysis of active-permit aging and recorded lifecycle durations.

## Architecture and implementation

### Ingestion and observed history

- Ingests the City of Toronto Active Permits and Cleared Permits datasets through a configuration-driven Python and dlt pipeline using the CKAN API.
- Applies source-aware typing, validation, retry and pagination-restart safeguards, and retains validated full-source Parquet snapshots.
- Loads the same validated snapshot bundle into DuckDB and the optional Snowflake path, avoiding separate extraction and transformation pipelines for the two backends.
- Maintains SCD Type 2 history for meaningful source changes using the logical revision key `permit_num`, `revision_num`, and `permit_type`, with tracked-row hashing that avoids false versions from CKAN's volatile `_id`.

SCD Type 2 validity windows are bounded by ingestion observations. They record when a change was observed between extracts; they do not establish the exact real-world time a permit status or attribute changed. Snowflake history was initialized from a fresh validated baseline and extends forward from that baseline; the earlier DuckDB history was not migrated into Snowflake.

### Shared dbt analytics layer

- Uses one shared dbt project to build against both DuckDB and Snowflake, with warehouse-specific SQL isolated where necessary.
- Builds staging models, revision-level fact models, date and permit-type dimensions, and analytical marts for active-permit aging and cleared-permit lifecycle durations.
- Defines model contracts and applies dbt model tests, unit tests, source-freshness and data-quality checks, plus strict static analysis.
- Makes logical grain, duplicate/conflict handling, eligibility rules, exclusions, and negative lifecycle intervals explicit rather than silently changing the analytical population.

### Published data product

- Publishes generated dbt documentation through GitHub Pages.
- Deploys a Streamlit dashboard with Overview, Active Permits, Permits marked Closed, and Data & definitions sections.
- Supports explicit DuckDB or Snowflake backend selection. The public dashboard is configured for the published DuckDB warehouse; the optional Snowflake connection uses read-only serving access.

## Validation evidence

- **SCD Type 2 baseline and replay:** a successful validation confirmed that replaying an unchanged snapshot added no versions and that a controlled `STATUS` change created the expected new version. [Workflow run](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40491637116) · [Implementation PR #76](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/pull/76).
- **DuckDB/Snowflake parity:** on a fixed comparison baseline with `as_of_date=2026-10-27`, compared dimensions, facts, and marts had zero row-value mismatches, and dashboard summary metrics matched. Staging was compared by schema, grain/count, and semantic types rather than row by row. [Parity workflow run](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40482009588).
- **Automated refresh chain:** CI, DuckDB publication, canonical Snowflake RAW refresh, and Snowflake serving build succeeded in sequence on October 27, 2026. [CI](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40622105661) · [CD](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40622186735) · [RAW refresh](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40622867433) · [Serving build](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40623059248).
- **DuckDB fallback:** with the Snowflake workflow gate disabled, CI and DuckDB publication succeeded while the Snowflake refresh jobs skipped as intended; the public dashboard was verified against DuckDB on October 28, 2026. [CI](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40630130221) · [CD](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/actions/runs/40630228426).

## Review the implementation

- [Source repository and README](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics)
- [Published dbt documentation](https://gagadanalyst.github.io/toronto-housing-bottleneck-analytics/)
- [Live Streamlit dashboard](https://toronto-housing-bottleneck.streamlit.app/)
- [Snowflake setup and operations guide](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/blob/main/infra/snowflake/README.md)
- [Published DuckDB warehouse and snapshot release](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics/releases/tag/warehouse-latest)

## Interpretation and limitations

The analysis is descriptive, not causal. It examines observed active-permit ages and dates recorded for permits marked `Closed`; it does not explain why a permit took a particular amount of time. Active ages are right-censored because final issue or completion dates are not yet known for active records. The `Closed` cohort is selected by recorded status and is not a complete or unbiased sample of all applications. Durations are measured in calendar days; negative intervals remain diagnostic and are excluded from published duration statistics. Counts and findings can change as the source datasets are refreshed.
