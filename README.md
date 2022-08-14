# PredictiveAccuracy

## Predictive Accuracy Testing in Predictive Regression Models 

### Description

This R package aims to implement the predictive accuracy testing methodology for nested environments of predictive regression models proposed by [Pitarakis, J-Y. (2020)](https://arxiv.org/abs/2008.08387). Moreover, we consider applications of the proposed testing methodology which includes useful features for robust estimation and inference such as the implementation of the tests to the modeling environment studied by  [Katsouris, C. (2021b)](https://arxiv.org/abs/2112.04887) who consider an application of forecast evaluation in large cross-sections of realized volatility measures using lasso shrinkage estimators.   

### Methodology

Consider the following predictive regression model with a set of predictors $x_{1t-1}$ such that

$$y_t = \delta_1^{\prime} x_{1t-1} + u_t$$ 

and another predictive regression model with two vectors of predictors, $x_{1t-1}$ and $x_{2t-1}$ such that 

$$y_t = \beta_1^{\prime}x_{1t-1} + \beta_2^{\prime} x_{2t-1} + v_t.$$

## Installation (under development)

The R package ‘PredictiveAccuracy’ will be able to be installed from Github.

## Usage 

```R

# After development the package will be able to be installed using
install.packages("PredictiveAccuracy")
library("PredictiveAccuracy")

```

## Examples

Lets load the Dataset in R:

```R

# Data Example 1: Exchange Rate Dataset from Pitarakis JY (2020)



```

## Key References

$\textbf{[1]}$ Pitarakis, Jean-Yves (2020). "A Novel Approach to Predictive Accuracy Testing in Nested Environments." arXiv preprint [arXiv:2008.08387](https://arxiv.org/abs/2008.08387).

$\textbf{[2]}$ Katsouris, C. (2021). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv preprint [arXiv:2112.04887](https://arxiv.org/abs/2112.04887).

## Code of Coduct

Please note that the ‘PredictiveAccuracy’ project will be released with a Contributor Code of Coduct (under construction). By contributing to this project, you agree to abide by its terms.

## Declerations

The author declares no conflicts of interest.

# Historical Background

> Standing on the shoulders of giants.
> 
> $\textit{''If I have been able to see further, it was only because I stood on the shoulders of giants."}$
> $- \text{Isaac Newton, 1676}$ 

$\textbf{Hirotugu Akaike}$ (November 5, 1927 – August 4, 2009) was a Japanese statistician. In the early 1970s, he formulated the Akaike information criterion (AIC). AIC is now widely used for model selection, which is commonly the most difficult aspect of statistical inference; additionally, AIC is the basis of a paradigm for the foundations of statistics. Akaike also made major contributions to the study of time series. As well, he had a large role in the general development of statistics in Japan. The Akaike information criterion (AIC) is an estimator of the relative quality of statistical models for a given set of data. Given a collection of models for the data, AIC estimates the quality of each model, relative to each of the other models. Thus, AIC provides a means for model selection. In particular, AIC was first formally described in a research paper by [Akaike (1974)](https://ieeexplore.ieee.org/abstract/document/1100705) which as of August 2022 it has been cited 58,568 times. (Source: [Wikipedia](https://en.wikipedia.org/wiki/Hirotugu_Akaike)).

$\textbf{Richard Von Mises}$ (19 April 1883 – 14 July 1953) was an Austrian scientist and mathematician who worked on solid mechanics, fluid mechanics, aerodynamics, aeronautics, statistics and probability theory. He held the position of Gordon McKay Professor of Aerodynamics and Applied Mathematics at Harvard University. Von Mises introduced a stress tensor which was used in the study of the strength of materials. His studies of wing theory for aircraft led him to investigate turbulence. Much of his work involved numerical methods and this led him to develop new techniques in numerical analysis. Von Mises most famous, and at the same time most controversial, work was in probability theory. He made considerable progress in the area of frequency analysis which was started by Venn. In particular, he combined the idea of a Venn limit and a random sequence of events. (Source: [Wikipedia](https://en.wikipedia.org/wiki/Richard_von_Mises)). 
