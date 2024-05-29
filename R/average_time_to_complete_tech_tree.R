# R/average_time_to_complete_tech_tree.R

#' Calculate Average Time to Complete Tech Tree
#'
#' This function calculates the average time taken by users to complete the tech tree.
#'
#' @param user_data A tibble containing user data with a time component.
#' @return The average time to complete the tech tree.
#' @export
average_time_to_complete_tech_tree <- function(user_data) {
  user_data %>%
    filter(tech_tree_completed == TRUE) %>%
    summarise(avg_time = mean(time_spent)) %>%
    pull(avg_time)
}
