# PredictiveAccuracy

## Predictive Accuracy Testing in Predictive Regression Models 

Description: This R package aims to implement the predictive accuracy testing methodology for nested environments of predictive regression models proposed by [Pitarakis JY (2020)](https://arxiv.org/abs/2008.08387). Furthermore, we consider further applications of the proposed testing methodology which includes: 

- Predictive Accuracy Testing in Cross-Sectional Regressions using Lasso-type regularization.
- Predictive Accuracy and Parameter Instability Testing in Predictive Regressions.  

## Installation (under development)

The R package ‘PredictiveAccuracy’ will be able to be installed from Github.

## Usage 

```R

# After development the package will be able to be installed using
install.packages("PredictiveAccuracy")
library("PredictiveAccuracy")

```
## Methodology

Consider the following predictive regression model with a set of predictors $x_{1t-1}$ such that

$$y_t = x_{1t-1}^{\prime} \delta_1 + u_t$$ 

and another predictive regression model with two vectors of predictors, $x_{1t-1}$ and $x_{2t-1}$ such that 

$$y_t = x_{1t-1}^{\prime} \beta_1 + x_{2t-1}^{\prime} \beta_2 + v_t.$$

## Examples

Lets load the Dataset in R:

```R

# Data Example 1: Exchange Rate Dataset from Pitarakis JY (2020)


# Data Example 2: Tenet Dataset from Hardle et al. (2016)

```

## Key References

[1] Pitarakis, Jean-Yves (2020). "A Novel Approach to Predictive Accuracy Testing in Nested Environments." arXiv preprint [arXiv:2008.08387](https://arxiv.org/abs/2008.08387).

[2] Katsouris, C. (2021). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv preprint [arXiv:2112.04887](https://arxiv.org/abs/2112.04887).

## Code of Coduct

Please note that the ‘PredictiveAccuracy’ project will be released with a Contributor Code of Coduct (under construction). By contributing to this project, you agree to abide by its terms.

## Declerations

The author declares no conflicts of interest.

