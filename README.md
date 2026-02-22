# Teacher-Student Ratios and Grade Outcomes in Swedish Compulsory Schools 2016–2025

## Project Overview
This repository contains the data and Stata code for the thesis *"Lärarkvalitet eller lärarkvantitet?"* (Teacher Quality or Teacher Quantity?). The study utilizes data from approximately 1,700 schools over a ten-year period to estimate the relationship between teacher density and average grade outcomes using a school-level panel dataset.

### Key Findings
* **No Robust Effect:** While simpler models show a positive correlation between student-teacher ratios and grades, this association becomes statistically insignificant once school fixed effects are introduced.
* **Selection and Heterogeneity:** The analysis reveals that school types are not directly comparable; voucher schools often have a different student composition and different incentives for grading compared to municipal schools.
* **Impact of Trends:** When accounting for school-specific trends, the coefficient for teacher density turns negative and statistically insignificant, suggesting no robust association within schools over time.
* **Socioeconomic Predominance:** Student background, particularly the share of students with highly educated parents, is the most consistent and powerful predictor of academic outcomes across all school types.

## Repository Structure
- `/data`: Contains `paneldata_finale.dta` and `paneldata_finale.csv` (input data files).
- `/scripts`: Contains:
  - `econometric_analysis.do` (Stata script for all regressions and tables).
  - `econometric_analysis.ipynb` (Python replication notebook).
- `/docs`: Includes the full thesis in Swedish (`Calissendorff & Engborg.pdf`).

## Technical Implementation
The analysis is conducted using:
* **Fixed Effects Models:** To control for time-invariant school characteristics.
* **Linear Trends:** To account for systematic changes within schools over time.
* **Clustered Standard Errors:** To ensure robust statistical inference.

## How to Replicate

### Stata (original analysis)
1. Open Stata and set the working directory to the repository root.
2. Ensure the dataset is located at `data/paneldata_finale.dta`.
3. Run `scripts/econometric_analysis.do`.

### Python (replication)
1. Open `scripts/econometric_analysis.ipynb` in VS Code or Jupyter.
2. Ensure the dataset is located at `data/paneldata_finale.csv` (or in the same folder as the notebook).
3. Run cell in the notebook.

## Authors
* Daniel Calissendorff
* Erik Engborg

*Undergraduate Thesis in Economics, Stockholm University, 2025.*
