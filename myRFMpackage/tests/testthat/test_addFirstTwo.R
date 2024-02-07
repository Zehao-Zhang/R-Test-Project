library(testthat)

context('Add first two elements of vector')

test_that('First two elements are added',{
  expect_equal(addFirstTwo(c(1,2)), 3)
})

test_that("Add first two elements including negative numbers", {
  expect_equal(addFirstTwo(c(-1, 2)), 1)
})

