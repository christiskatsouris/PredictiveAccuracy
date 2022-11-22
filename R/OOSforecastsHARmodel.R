###########################################################################################################
# R Script Details:
###########################################################################################################

# Script name: EPA_test_null.R
# Program aim: This R program creates out-of-sample forecast sequences based on the HAR model.
# written by: 

# Christis G. Katsouris (August 2020)
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
library(caret)
library(elasticnet)
library(lattice)
library(ggplot2)
library(lars)

source( "aggRV.R" )
source( "aggY.R" )
source( "HARDataCreation.R" )
source( "dataset_creation.R" )
source( "RQs_sqrt_demeaned_function.R" )
source( "HAR_estimate.R" )

###############################################################################  
## Function: OOS FORECASTS
###############################################################################

dataset <- read.csv( "dataset.csv", header = TRUE )
time    <- as.matrix( dataset$Date )

RV  <- read.csv( "RV.csv",  header = TRUE )
RV  <- as.matrix(RV)
RV  <- dataset_creation( dataset = RV,  time = time )

OOS_FORECASTS_HAR <- function( RM = RV, nRoll=nRoll, windowType = "rolling" )
{# BEGIN OF FUNCTION
  
  RV    <- RM
  nRoll <- nRoll
  windowType <- windowType
  
  ######Initialization section ######
  periods <- c(1,5,22)
  h <- 1
  iT            = length(RV[,2])
  
  #iLags         = length(periods)
  #iLagsPlusOne  = iLags+1
  #iLagsMax      = max(periods)
  
  #vObservations = RM[(iLagsMax+1):(iT-nRoll)]
  #vForecastComp = RM[(iT-nRoll+1):iT] 
  ######Initialization end #######
  
  lFit = list()
  ######Forecasting: One-Period-Ahead #######
  forecast.matrix.windows <- matrix(0 , nrow = nRoll , ncol = 27 ) 
  
  for (j in 1:nRoll)
  {# begin for-loop for one-period ahead forecasting 
    
    HARData <- HARDataCreation( RM = RV[j:(iT-nRoll+j),  ], periods = periods, h = h )
    X       <- HARData$Design_matrix
    Y       <- HARData$ymatrix
    
    X.corrected <- X[-nrow(X),] 
    Y.corrected <- Y[-nrow(Y),]

    forecasts <- HAR_estimate(  x = X.corrected, y = Y.corrected  )
    forecast.matrix.windows[j, ] <- forecasts
    
  }# end for-loop for one-period ahead forecasting
    
  # the actual RV of the rolling window
  # actual.RV   <- RV[(iT-nRoll+1):iT,  ]
  # actual.RV  <- HARDataCreation( RM = RV[(iT-nRoll+1):iT,  ], periods = periods, h = h )
  # actual.RV  <- actual.RV$ymatrix
  
  actual.RV  <- HARDataCreation( RM = RV, periods = periods, h = h )
  y.RV       <- actual.RV$ymatrix
  
  iT    <- nrow(y.RV)
  y.RV  <-  y.RV[(iT-nRoll+1):iT,  ]
  
  forecast.RV <-  forecast.matrix.windows  
  MSE <- ( y.RV - forecast.RV )^2
  
 return(MSE)  
}# END OF FUNCTION
###############################################################################

MSE <- OOS_FORECASTS_HAR( RM = RV, nRoll=1000, windowType = "rolling" )
mean.MSE.windows <- matrix( 0, nrow = 1000, ncol =1 )

for (i in 1:1000)
{
  mean.MSE.windows[i,1] <- mean( MSE[i , ] )
}

write.csv( MSE, "MSE_RW_HAR_corrected.csv"  )


###############################################################################
