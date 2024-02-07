#' get_max_PurchAmount
#'
#  Description
#' Function that returns the highest PurchAmount for a given date.
#'
#  Detail arguments like a data description
#' @details
#' \code{data} contains the transaction data. The data set must contain a
#'             column labeled "Customer" that allows unique customer identification
#'             and a column labeled "TransDate", indicating the purchase date.
#'             The column "PurchAmount" specifies the total spending per purchase.
#'
#  Arguments that are passed as input to the function
#' @param x a data object with columns TransDate, Customer, PurchAmount, Cost
#' @param date a specification for the time of interest. Must be of format "dd.mm.yyy"
#'
#  Returned values with a description of what the function returns
#' @return The Customer with the highest profit for a given date \code{date} of data \code{x}
#'
#  Examples with a set of example R code on how to use the function
#' @examples
#' data(transactions)
#' myFun(transactions, date="01.10.2020")
#'
#  Import packages that are required for using your package
#' @import data.table
#  Careful: some packages have functions with overlapping names. If this is the case,
#           only import specific functions from a package. Here, lubridate and data.table
#           share the function quarter(). To avoid conflicts, only load functions you need
#           from lubridate with @importFrom package function1 function2
#' @importFrom lubridate dmy
#'
#  Include export to make sure roxygen2 knows to create the NAMESPACE file, to make
#  the package accessible to other users
#' @export

# function
get_max_PurchAmount <- function(x, date){
  x <- data.table(x)
  date <- dmy(date)
  result <- max(x[dmy(TransDate)==date, PurchAmount])
  return(result)
}
