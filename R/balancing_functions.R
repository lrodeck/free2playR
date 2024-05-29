# R/balancing_functions.R

#' Balancing Functions
#'
#' A collection of balancing functions for the idle mechanic simulation.
#'
#' @param x The input value.
#' @param ... Additional parameters for the balancing function.
#' @return The output value after applying the balancing function.
#' @export
balancing_functions <- list(
  exponential = function(x, a = 2) a^x,
  linear = function(x, b = 1000) x * b,
  logistic = function(x, L = 1000, k = 0.01, x0 = 50) L / (1 + exp(-k * (x - x0))),
  custom = function(x, base = 100, growth_rate = 1.05) base * (growth_rate ^ x)
)
