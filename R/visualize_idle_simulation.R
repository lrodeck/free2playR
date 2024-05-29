# R/visualize_idle_simulation.R

#' Visualize Idle Mechanic Simulation
#'
#' This function visualizes the results of the idle mechanic simulation.
#'
#' @param time_series The time series data from the simulation.
#' @return A ggplot object showing the simulation results.
#' @export
visualize_idle_simulation <- function(time_series) {
  ggplot(time_series, aes(x = time)) +
    geom_line(aes(y = money, color = "Current Money")) +
    geom_line(aes(y = total_money, color = "Total Money Generated")) +
    geom_line(aes(y = boost_currency * 100, color = "Boost Currency (scaled)")) +  # Scaling boost currency for better visualization
    facet_wrap(~ scenario, scales = "free_y") +
    labs(title = "Idle Farming Simulation", x = "Time (seconds)", y = "Amount", color = "Legend") +
    theme_minimal()
}
