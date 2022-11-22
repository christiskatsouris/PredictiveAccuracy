###########################################
R Script Details:
###########################################

Script name: EPA_test_null.R

Program aim: This R program estimates of the Risk Matrix before symmetrization.  

written by: 

Christis G. Katsouris
Department of Economics
University of Southampton
Southampton, United Kingdom

This program reproduces the empirical application presented in the paper: 
Katsouris, C. (2021b). "Forecast Evaluation in Large Cross-Sections of Realized Volatility". arXiv:2112.04887. 

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
