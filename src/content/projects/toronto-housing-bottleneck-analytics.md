---
title: Toronto Housing Bottleneck Analytics
description: An end-to-end Analytics Engineering project using City of Toronto building-permit data to examine active-permit aging, observed lifecycle durations and source-data quality.
status: flagship
thumbnail: ./images/toronto-pipeline.png
thumbnailDark: ./images/toronto-pipeline-dark.png
thumbnailAlt: "A four-stage architecture diagram showing Toronto Open Data, observed SCD Type 2 history, DuckDB and dbt models, and published documentation and dashboard outputs."
technologies:
  - Python
  - dlt
  - SCD Type 2
  - DuckDB
  - dbt
  - GitHub Actions
  - Streamlit
showOnHome: true
sortOrder: 1
repositoryUrl: https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics
dbtDocsUrl: https://gagadanalyst.github.io/toronto-housing-bottleneck-analytics/
dashboardUrl: https://toronto-housing-bottleneck.streamlit.app/
---

## The problem

City of Toronto permit extracts provide useful attributes and outcomes, but they do not arrive as a ready-made longitudinal status history. This project builds a reproducible ingestion and analytics workflow so source changes, data-quality issues and reporting populations can be inspected.

## Approach

The workflow ingests Active and Cleared permit datasets, preserves observed revisions with SCD Type 2 history, models analytical tables with dbt, and publishes documentation and a dashboard for review.

## Engineering decisions

- Keep source values and metadata visible alongside typed analytical fields.
- Use an explicit logical grain and flag conflicts rather than silently choosing arbitrary duplicate rows.
- Treat SCD Type 2 validity windows as bounded by ingestion observations; they do not establish exact real-world status-transition timestamps.
- Document eligibility rules and avoid reporting negative elapsed durations as valid duration measures.
- Keep analysis descriptive. Permit attributes are not presented as proven causes of delay.

## Review the evidence

- [Inspect the implementation and automated checks](https://github.com/gagadanalyst/toronto-housing-bottleneck-analytics)
- [Browse the dbt documentation](https://gagadanalyst.github.io/toronto-housing-bottleneck-analytics/)
- [Explore the live dashboard](https://toronto-housing-bottleneck.streamlit.app/)

## Limitations

The source extracts show what was observed at ingestion times. They do not establish exact change times between extracts or explain the causes behind any individual permit's duration. Counts and findings may change as published source data is refreshed.
