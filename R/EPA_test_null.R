###########################################
# R Script Details:
###########################################

# Script name: EPA_test_null.R
# Program aim: This R program estimates forecasting sequences for cross-sectional HAR models.  

# written by: 

# Christis G. Katsouris
# Department of Economics
# University of Southampton
# Southampton, United Kingdom

# This program reproduces the empirical application presented in the paper: 
# Katsouris, C. (2021b). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv:2112.04887. 

############################################################################
### REQUIRED PACKAGES
############################################################################

library(zoo)
library(dplyr)
library(lubridate)

library(xts)
library(highfrequency)
library(Matrix)

library(glmnet)
library(prioritylasso)

source( "aggRV.R" )
source( "aggY.R" )

source( "HARDataCreation.R" )
source( "dataset_creation.R" )
source( "RQs_sqrt_demeaned_function.R" )

##############################################################################
### Step 1: Input Dataset
##############################################################################

dataset <- read.csv( "dataset.csv", header = TRUE )
time    <- as.matrix( dataset$Date )

RV  <- read.csv( "RV.csv",  header = TRUE )
RV  <- as.matrix(RV)

###############################################################################
### Function 1: fast_LASSO_HAR_MODEL (Priority Lasso Shrinkage Norm)
###############################################################################

fast_LASSO_HAR_MODEL <- function(  x = X.corrected , y = Y1, which.firm =  which.firm  )
{# BEGIN OF FUNCTION
  
  x <- x
  y <- y
  k <- which.firm
  
  # At this step, we re-arrange the design matrix so that it has always the 3 lagged RVs of the particular firm at the first 3 columns
  x.firm   <- x[ , ( (3*k-2):(3*k) ) ]
  x.others <- x[  , -( (3*k-2):(3*k) ) ]
  x.new    <- cbind( x.firm , x.others  ) 
  
  # cv <- cv.glmnet( x = x , y = y, alpha=1,nfolds=10 )
  # l  <- cv$lambda.min
  # alpha <- 1
  
  blocks  <- list( bp1 = 1:3, bp2 = 4:81 )
  fits <- prioritylasso( X = x.new , Y = y, family = "gaussian", type.measure = "mse", blocks = blocks, standardize = FALSE, block1.penalization = FALSE )
  
  res <- as.matrix( as.vector( fits$coefficients ) )
  return( res )
  
}# END OF FUNCTION

