---
title: European Energy Price Analytics
description: A local prototype that connects day-ahead electricity-price collection, local storage, dbt transformations and Power BI reporting.
status: supporting
thumbnail: ./images/energy-price-workflow.png
thumbnailDark: ./images/energy-price-workflow-dark.png
thumbnailAlt: "A workflow diagram for the local energy-price prototype: EPEX Spot data collection, local storage, dbt transformations and Power BI reporting."
technologies:
  - Python
  - BeautifulSoup
  - PySpark
  - DuckDB
  - Delta Tables
  - dbt
  - Power BI
showOnHome: true
sortOrder: 2
repositoryUrl: https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project
notebookUrl: https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project/blob/main/Fabric%20End%20to%20End.ipynb
reportUrl: https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project/blob/main/eur_enegry_prices.pbix
---

## Summary

This project explores European day-ahead electricity prices and connects source-data collection, local storage, SQL transformations and a Power BI report in one workflow.

## Implemented scope

- Collect day-ahead price data using Python requests and BeautifulSoup.
- Store and process data locally using PySpark and Delta Tables, with DuckDB and dbt used in the analytical workflow.
- Build dbt staging and mart models for price summaries, price ranges and a basic price-based suggestion view.
- Produce a Power BI report to explore prices across markets and time.

## Scope note

This is a **local prototype**. The originally intended Microsoft Fabric cloud execution was deferred because the required access or capacity was unavailable. Fabric architecture and pipeline steps described as plans were not deployed cloud resources.

Some model logic and data-quality decisions need further review before the analytical results should be treated as validated. Those improvements remain planned work; this page does not claim that the current recommendation logic is production-ready.

## Review the evidence

- [Open the source repository](https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project)
- [Read the notebook on GitHub](https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project/blob/main/Fabric%20End%20to%20End.ipynb)
- [View the Power BI report file](https://github.com/gagadanalyst/Microsofot-Fabric-End-to-End-Project/blob/main/eur_enegry_prices.pbix)
