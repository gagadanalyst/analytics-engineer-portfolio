---
title: "Lead Conversion: EDA and Interpretable Baseline"
description: An exploratory analysis of a public lead-conversion dataset, using feature preparation and a shallow decision tree to inspect conversion patterns.
status: supporting
thumbnail: ./images/lead-scoring-baseline.png
thumbnailDark: ./images/lead-scoring-baseline-dark.png
thumbnailAlt: "A diagram summarizing the public lead-conversion exercise from exploratory analysis and feature preparation to an interpretable decision-tree baseline."
technologies:
  - Python
  - pandas
  - Sweetviz
  - scikit-learn
  - Decision trees
showOnHome: true
sortOrder: 3
repositoryUrl: https://github.com/gagadanalyst/Lead-Scoring-machine-learning
notebookUrl: https://github.com/gagadanalyst/Lead-Scoring-machine-learning/blob/main/Lead%20Scoring.ipynb
---

## Summary

This notebook explores a public education-lead dataset and builds a small, interpretable decision-tree baseline. It is a learning exercise focused on exploratory analysis, feature preparation and understanding model behaviour.

## What it demonstrates

- Use automated exploratory analysis to investigate a dataset with many columns.
- Prepare categorical and numeric features for a simple classifier.
- Compare conversion patterns with a shallow decision tree and inspect the resulting tree.
- Explain why lead scoring can help prioritise effort, while not guaranteeing a higher conversion rate by itself.

## Scope and limitations

The current preprocessing and holdout evaluation need further review, including how uncommon categories are handled, how encoded features are aligned, and how a ranking model should be evaluated. The reported accuracy is a single baseline result, not evidence of production readiness.

This exercise is separate from the professional lead-scoring system delivered at Admirals. Business outcomes from that professional work are not attributed to this public-dataset notebook.

## Review the evidence

- [Open the source repository](https://github.com/gagadanalyst/Lead-Scoring-machine-learning)
- [Read the notebook on GitHub](https://github.com/gagadanalyst/Lead-Scoring-machine-learning/blob/main/Lead%20Scoring.ipynb)
