# R/apply_resource_generation.R

#' Apply Resource Generation
#'
#' This function applies resource generation to user data.
#'
#' @param user_data A tibble containing user data.
#' @param generator A tibble representing the resource generator.
#' @param time_period The time period over which resources are generated.
#' @return A tibble with updated user data.
#' @export
apply_resource_generation <- function(user_data, generator, time_period) {
  user_data %>%
    mutate(
      currency1 = currency1 + generator$resource_rate1 * time_period,
      currency2 = currency2 + generator$resource_rate2 * time_period
    )
}
