# Teacher-Student Ratios and Grade Outcomes in Swedish Compulsory Schools 2016–2025
This repository contains the data and Stata code for the thesis *"Lärarkvalitet eller lärarkvantitet?"* (Teacher Quality or Teacher Quantity?). The study examines the relationship between teacher density and student achievement using a comprehensive panel dataset of Swedish schools.

## Project Overview
The study utilizes data from approximately 1,700 schools over a ten-year period to estimate the relationship between teacher density and average grade outcomes using a school-level panel dataset.

### Key Findings
* **No Robust Effect:** While simpler models show a positive correlation between student-teacher ratios and grades, this association becomes statistically insignificant once school fixed effects are introduced.
* **Selection and Heterogeneity:** The analysis reveals that school types are not directly comparable; voucher schools often have a different student composition and different incentives for grading compared to municipal schools.
* **Impact of Trends:** When accounting for school-specific trends, the coefficient for teacher density turns negative and statistically insignificant, suggesting no robust association within schools over time.
* **Socioeconomic Predominance:** Student background, particularly the share of students with highly educated parents, is the most consistent and powerful predictor of academic outcomes across all school types.

## Repository Structure
* `/data`: Contains `paneldata_finale.dta` (The processed panel dataset).
* `/scripts`: Contains `econometric_analysis.do` (Stata script for all regressions and tables).
* `/docs`: Includes the full thesis in Swedish (`Calissendorff & Engborg.pdf`).

## Technical Implementation
The analysis is conducted in **Stata** using:
* **Fixed Effects Models:** To control for time-invariant school characteristics.
* **Linear Trends:** To account for systematic changes within schools over time.
* **Clustered Standard Errors:** To ensure robust statistical inference.

## How to Replicate
1. Clone this repository.
2. Open Stata and set your working directory to the repository folder using the cd command.
3. Ensure the dataset is located at `data/paneldata_finale.dta`.
4. Run `scripts/econometric_analysis.do`.
5. The script exports Panel A (All schools), Panel B (Voucher schools), and Panel C (Municipal schools).

## Authors
* Daniel Calissendorff
* Erik Engborg

*Undergraduate Thesis in Economics, Stockholm University, 2025.*
