# R/visualize_currency.R

#' Visualize Currency Changes Over Time
#'
#' This function plots the changes in currency over time.
#'
#' @param user_data A tibble containing user data with a time component.
#' @return A ggplot object showing the currency changes over time.
#' @export
visualize_currency <- function(user_data) {
  ggplot(user_data, aes(x = time_spent)) +
    geom_line(aes(y = currency1, color = "Currency 1")) +
    geom_line(aes(y = currency2, color = "Currency 2")) +
    labs(title = "Currency Changes Over Time", x = "Time", y = "Currency Amount") +
    theme_minimal()
}
