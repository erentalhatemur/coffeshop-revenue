# Coffee Shop Revenue Analysis with Regression

This project analyzes and predicts coffee shop daily revenue using regression analysis in R. It includes data preprocessing, model building, assumption checks, multicollinearity analysis, and visualizations.

## Features
- **Data Preprocessing:** Splitting data into training and test sets.
- **Regression Modeling:** Building a linear regression model to predict daily revenue.
- **Assumption Checks:** Normality, homoscedasticity, outliers, leverage, and influential observation analyses.
- **Multicollinearity Analysis:** Using VIF and condition index to detect collinearity issues.
- **Visualization:** Residual plots, leverage plots, and correlation matrices.

## Files
- `coffee_shop_revenue.csv`: The dataset containing coffee shop revenue information.
- `coffeshoprevenue.R`: R script implementing regression analysis and assumption checks.

## Requirements
To run the analysis, you need the following R packages:
```r
install.packages(c("faraway", "olsrr", "MASS", "ggplot2", "lmtest", "corrplot", "carData", "fpp2"))
```

## Usage
Run the `coffeshoprevenue.R` script in RStudio or an R environment to perform the analysis. The script will:
1. Load the dataset.
2. Split the data into training and testing sets.
3. Build and evaluate a regression model.
4. Perform assumption and collinearity checks.
5. Generate relevant plots and statistical summaries.

## License
This project is open-source and available under the MIT License.
