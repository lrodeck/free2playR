# R/simulate_tech_progression.R

#' Simulate Tech Progression
#'
#' This function simulates the progression through a tech tree and updates user data.
#'
#' @param user_data A tibble containing user data.
#' @param tech_tree A tibble representing the tech tree.
#' @return A tibble with updated user data.
#' @export
simulate_tech_progression <- function(user_data, tech_tree) {
  tech_progress <- user_data$tech_progress[[1]]

  for (i in seq_len(nrow(tech_tree))) {
    node <- tech_tree$node[[i]]
    prerequisites <- unlist(node$prerequisites)

    # Check if all prerequisites are met and handle missing values
    prerequisites_met <- all(sapply(prerequisites, function(prereq) {
      if (is.na(tech_progress[prereq])) {
        FALSE
      } else {
        tech_progress[prereq] > 0
      }
    }))

    if (prerequisites_met &&
        user_data$currency1 >= node$cost_currency1 &&
        user_data$currency2 >= node$cost_currency2 &&
        user_data$level >= node$level_requirement) {

      tech_progress[node$node_name] <- tech_progress[node$node_name] + node$value
      user_data <- user_data %>%
        mutate(
          currency1 = currency1 - node$cost_currency1,
          currency2 = currency2 - node$cost_currency2,
          time_spent = time_spent + node$time_required,  # Update time_spent
          xp = xp + node$xp_reward
        )

      user_data <- update_user_level(user_data)
    }
  }

  user_data <- user_data %>% mutate(tech_progress = list(tech_progress))
  user_data
}

#' Update User Level
#'
#' This function updates the user's level based on their XP.
#'
#' @param user_data A tibble containing user data.
#' @return A tibble with updated user level.
#' @export
update_user_level <- function(user_data) {
  xp_thresholds <- c(0, 100, 300, 600, 1000)  # Example XP thresholds for levels
  new_level <- sum(user_data$xp >= xp_thresholds)
  user_data %>%
    mutate(level = new_level)
}
