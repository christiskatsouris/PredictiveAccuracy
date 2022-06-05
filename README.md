# PredictiveAccuracy

## Predictive Accuracy Testing in Predictive Regression Models 

Description: This R package aims to implement predictive accuracy statistical testing for nested environments of predictive regression models. Applications of the proposed testing methodology includes the following: 

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

Consider the following predictive regression model with a set of predictors $$x_{1t-1}$$ 

$$y_t = x_{1t-1}^{\prime} \delta_1 + u_t$$ 

and 

$$y_t = x_{1t-1}^{\prime} \beta_1 + x_{2t-1}^{\prime} \beta_2 + v_t.$$

## Key References

[1] Pitarakis, Jean-Yves (2020). "A Novel Approach to Predictive Accuracy Testing in Nested Environments." arXiv preprint [arXiv:2008.08387](https://arxiv.org/abs/2008.08387).

[2] Katsouris, C. (2021). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv preprint [arXiv:2112.04887](https://arxiv.org/abs/2112.04887).

## Declerations

The author declares no conflicts of interest.

