# Ex 1
# Install (if necessary) and load the following packages. ####
library(data.table)
library(lubridate)
library(ggplot2)
library(Hmisc)

#' RFMfunction
#'
# Description
#' This function calculates the RFM score
#' @details
#' \code{data} contains the transaction data. Must contain columns 'Customer', 'TransData', and 'PurchAmount'
#'
#'
#'
#' @param arg1 data
#' @param arg2 a number
#' @param arg3 a number
#' @param arg4 a number
#'
#' @return the final result of \code{arg1},\code{arg2},\code{arg3},\code{arg4}
#'
#' @examples
#' RFMfunction(data, 20, 20, 60)
#'
#' @export





RFMfunction <- function(data, weight_recency=1, weight_frequency=1, weight_monetary=1){

  # adjusting values to ensure that the weights add up to one
  weight_recency2 <- weight_recency/sum(weight_recency, weight_frequency, weight_monetary)
  weight_frequency2 <- weight_frequency/sum(weight_recency, weight_frequency, weight_monetary)
  weight_monetary2 <- weight_monetary/sum(weight_recency, weight_frequency, weight_monetary)

  print("weights are calculated")

  # RFM measures
  max.Date <- max(data[,TransDate])

  temp <- data[,list(
    recency = as.numeric(max.Date - max(TransDate)),
    frequency = .N,
    monetary = mean(PurchAmount)),
    by=Customer
  ]

  print("RFM Measure done")

  # RFM scores
  temp <- temp[,list(Customer,
                     recency = as.numeric(cut2(-recency, g=3)),
                     frequency = as.numeric(cut2(frequency, g=3)),
                     monetary = as.numeric(cut2(monetary, g=3)))]

  # Overall RFM score
  temp[,finalscore:=weight_recency2*recency+weight_frequency2*frequency+weight_monetary2*monetary]

  print("Overall RFM Measure done")

  # RFM group
  temp[,group:=round(finalscore)]

  # Return final table
  return(temp)
}



