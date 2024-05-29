# R/calculate_success_rate.R

#' Calculate Success Rate of Actions
#'
#' This function calculates the success rate of actions taken by users.
#'
#' @param user_data A tibble containing user data with action outcomes.
#' @return A tibble with action names and their success rates.
#' @export
calculate_success_rate <- function(user_data) {
  user_data %>%
    group_by(action_name) %>%
    summarise(success_rate = mean(outcome > 0)) %>%
    arrange(desc(success_rate))
}
