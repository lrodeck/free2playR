# R/analyze_idle_simulation.R

#' Analyze Idle Mechanic Simulation
#'
#' This function analyzes the results of the idle mechanic simulation.
#'
#' @param results The results from the simulation.
#' @return A data frame with the final statistics and interpretations.
#' @export
analyze_idle_simulation <- function(results) {
  final_stats <- bind_rows(lapply(results, function(result) {
    stats <- result$final_stats
    data.frame(
      scenario = result$time_series$scenario[1],
      total_resets = stats$total_resets,
      final_money_per_sec = stats$final_money_per_sec,
      total_boost_currency = stats$total_boost_currency
    )
  }))

  final_stats %>%
    mutate(
      interpretation = case_when(
        grepl("exponential", scenario) ~ "Exponential balancing shows rapid growth in goals and resources. Higher values of 'a' make progress faster but require more resources.",
        grepl("linear", scenario) ~ "Linear balancing provides steady and predictable growth. Higher values of 'b' increase the goal increment linearly.",
        grepl("logistic", scenario) ~ "Logistic balancing starts slow, accelerates, and then slows down as it reaches a maximum value. Parameters 'L', 'k', and 'x0' shape the curve.",
        grepl("custom", scenario) ~ "Custom balancing allows for flexible growth rates. Higher base values and growth rates lead to faster progression but can also increase the difficulty."
      )
    )
}
