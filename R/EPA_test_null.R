###########################################################################################################
# R Script Details:
###########################################################################################################

# Script name: EPA_test_null.R
# Program aim: This R program estimates forecasting sequences for cross-sectional HAR models.  

# written by: 

# Christis G. Katsouris (August 2020)
# Department of Economics
# University of Southampton
# Southampton, United Kingdom

# This program reproduces the empirical application presented in the paper: 
# Katsouris, C. (2021b). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv:2112.04887. 

###########################################################################################################
### REQUIRED PACKAGES
###########################################################################################################

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

#############################################################################################################
### Step 1: Input Dataset
#############################################################################################################

dataset <- read.csv( "dataset.csv", header = TRUE )
time    <- as.matrix( dataset$Date )

RV  <- read.csv( "RV.csv",  header = TRUE )
RV  <- as.matrix(RV)

##############################################################################################################
### Function 1: fast_LASSO_HAR_MODEL (Priority Lasso Shrinkage Norm)
##############################################################################################################

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

##############################################################################################################
### Function 2: FAST_HARestimate
##############################################################################################################

FAST_HARestimate = function( RM = RM , periods = periods, h = h, which.firm =  which.firm )
{# BEGIN OF FUNCTION
  
  RM <- RM
  periods <- periods
  h <- h
  which.firm <- which.firm
  
  mData <- HARDataCreation( RM = RM , periods = periods, h = h  )
  
  X     <- mData$Design_matrix
  Y     <- mData$ymatrix
  
  X.corrected <- X[-nrow(X),] 
  Y.corrected <- Y[-nrow(Y),]
  Y1 <- Y.corrected[,which.firm]
  
  HAR_Lasso  <- fast_LASSO_HAR_MODEL( x = X.corrected , y = Y1, which.firm =  which.firm )
  return(list("coefficients" = HAR_Lasso , "mData" = mData))
  
}# END OF FUNCTION

##############################################################################################################
### Function 3: OOS_HAR_Forecasts
##############################################################################################################

OOS_HAR_Forecasts <- function( RM = RV, periods = periods, window.size = window.size, h = 1, which.firm = which.firm )
{# begin of HARForecast
  
  RM          <- RV
  periods     <- periods
  window.size <- window.size
  which.firm  <- which.firm
  h <- 1
    
  ######Initialization section ######
  T      <- length(RM[,2])
  Lags   <- length(periods)
  
  ######Initialization end #######
  lFit = list()
  
  ######Forecasting #######
  nRoll <- ( T - window.size )
  mForecast           <- matrix( 0 , nrow = nRoll, ncol = 1 ) 
  beta.priority.lasso <- matrix( 0 , nrow = nRoll, ncol = 82)
  
  for (j in 1:nRoll)
  {# begin for-loop for nAhead = 1
    
    model.Fit                <- FAST_HARestimate( RM = RM[j:(T-nRoll+j),  ], periods = periods, h = h, which.firm =  which.firm )
    beta.priority.lasso[j, ] <- model.Fit$coefficients
    Design_matrix_Data       <- model.Fit$mData$Design_matrix
    vCoef          <- model.Fit$coefficients
    mForecast[j,1] <- vCoef[1] + sum( vCoef[-1]*Design_matrix_Data[ nrow(Design_matrix_Data), ] )
    
  }# end for-loop for nAhead = 1 
  
  # the actual RV of the rolling window
  actual.RV   <- RM[(T-nRoll+1):T, which.firm ]
  forecast.RV <-  mForecast  
  
  forecast.error.matrix <- cbind( actual.RV , forecast.RV )
  forecast.error <- ( actual.RV - forecast.RV )
  
  forecast.error.matrix.new <- cbind( forecast.error.matrix, forecast.error  )  
  return( list( "forecast_error_HAR" = forecast.error.matrix.new, "betas_HAR_priortity_lasso" =  beta.priority.lasso ) )
  
}# end of HARForecast  

###########################################################################################################
