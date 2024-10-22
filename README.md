# EGX30 Under the Lens: A Statistical Perspective

## Project Overview
This project provides an in-depth statistical analysis of the EGX30 index fund, which represents the top 30 companies listed on the Egyptian Stock Exchange (EGX). The analysis offers actionable insights for investors, with a focus on understanding the historical behavior of the EGX30 index to guide future investment decisions.

## Key Features
- **Data Collection**: 
  - The dataset consists of 800 data points from the EGX30 index fund, covering the period from 2021 to 2024.
  - Data was sourced from the official Egyptian Stock Exchange (EGX) website.
  
- **Statistical Tools Used**:
  - MATLAB, with the Statistics and Machine Learning Toolbox, was utilized for data analysis.

- **Metrics Analyzed**:
  1. **Mean**: The central tendency of EGX30 index returns.
  2. **Variance**: The dispersion of returns, reflecting variability.
  3. **Standard Deviation**: The risk associated with the EGX30 index.
  4. **Probability Density Function (PDF)**: Describes the likelihood of different index values.
  5. **Cumulative Distribution Function (CDF)**: Shows the probability of the index value falling below a specific threshold.
  
- **Future Predictions**:
  - Forecast of the EGX30 index behavior for the next three years using statistical models.

## Code Implementation
The project includes the following key MATLAB implementations:

1. **Data Preprocessing**:
   - Dates were converted from strings to datetime format.
   - Gaps in data were filled using linear interpolation.
   
2. **Statistical Calculations**:
   - Mean, Variance, and Standard Deviation were calculated for historical EGX30 data.
   
   ```matlab
   meanValue = mean(valuesInterp);
   variance = var(valuesInterp);
   standardDeviation = std(valuesInterp);
   ```

3. **PDF and CDF**:
   - Probability Density Function (PDF) and Cumulative Distribution Function (CDF) were manually calculated and plotted.

   ```matlab
   [counts, edges] = histcounts(valuesInterp, 'Normalization', 'pdf');
   y = cdf(x, 10%);
   ```

4. **Time Series Forecasting**:
   - The future values of the EGX30 index were forecasted using linear regression.

   ```matlab
   mdl = fitlm(X, y);
   [futureValues, futureCI] = predict(mdl, futureX);
   ```

## Visualizations
- **Time Series Plot**: Displays historical data alongside forecasted values.
- **PDF and CDF Plots**: Visual representations of the probability distribution and cumulative probabilities.


## Results
- The project provides key insights into the historical and future performance of the EGX30 index, including predictions for the next three years. The visualizations offer clear representations of statistical measures and forecasted trends.
