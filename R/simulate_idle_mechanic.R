# R/simulate_idle_mechanic.R

#' Simulate Idle Mechanic
#'
#' This function simulates an idle mechanic with given balancing functions and parameters.
#'
#' @param balancing_func The balancing function to use.
#' @param goal_increase_func The function to increase the goal after each reset.
#' @param simulation_time The total simulation time in seconds.
#' @param initial_money_per_sec The initial money generation rate per second.
#' @param initial_goal The initial monetary goal for market reset.
#' @param initial_reset_boost The initial permanent production boost per reset.
#' @param initial_boost_currency_per_reset The initial boost currency earned per market reset.
#' @param reset_boost_growth_rate The growth rate of reset boost per reset.
#' @param boost_currency_growth_rate The growth rate of boost currency per reset.
#' @param func_params A list of parameters for the balancing function.
#' @return A list containing time series data and final statistics.
#' @export
simulate_idle_mechanic <- function(balancing_func, goal_increase_func, simulation_time, initial_money_per_sec, initial_goal, initial_reset_boost, initial_boost_currency_per_reset, reset_boost_growth_rate, boost_currency_growth_rate, func_params = list()) {
  time <- 0
  money <- 0
  current_goal <- initial_goal
  money_per_sec <- initial_money_per_sec
  reset_boost <- initial_reset_boost
  boost_currency_per_reset <- initial_boost_currency_per_reset
  boost_currency <- 0
  total_money <- 0
  reset_count <- 0

  # Data storage for plotting
  time_series <- data.frame(time = numeric(), money = numeric(), total_money = numeric(), boost_currency = numeric(), scenario = character())

  # Simulation loop
  while (time < simulation_time) {
    time <- time + 1
    money <- money + money_per_sec
    total_money <- total_money + money_per_sec

    # Check if goal is reached for market reset
    if (money >= current_goal) {
      reset_count <- reset_count + 1
      boost_currency <- boost_currency + boost_currency_per_reset
      reset_boost <- reset_boost * (1 + reset_boost_growth_rate)
      boost_currency_per_reset <- boost_currency_per_reset * (1 + boost_currency_growth_rate)
      money_per_sec <- money_per_sec * (1 + reset_boost)
      money <- 0
      current_goal <- do.call(goal_increase_func, c(list(reset_count), func_params))
    }

    # Store data for plotting
    time_series <- rbind(time_series, data.frame(time = time, money = money, total_money = total_money, boost_currency = boost_currency, scenario = paste(names(func_params), func_params, sep = "=", collapse = ", ")))
  }

  list(
    time_series = time_series,
    final_stats = list(
      total_resets = reset_count,
      final_money_per_sec = money_per_sec,
      total_boost_currency = boost_currency
    )
  )
}
