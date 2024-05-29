# R/simulation.R

#' Simulate Action
#'
#' This function simulates an action and updates user data.
#'
#' @param user_data A tibble containing user data.
#' @param action A tibble representing the action.
#' @return A tibble with updated user data.
#' @export
simulate_action <- function(user_data, action) {
  if (user_data$currency1 >= action$cost_currency1 && user_data$currency2 >= action$cost_currency2 && user_data$level >= action$level_requirement) {
    user_data <- user_data %>%
      mutate(
        currency1 = currency1 - action$cost_currency1,
        currency2 = currency2 - action$cost_currency2,
        public_order = public_order + action$public_order_change,
        happiness = happiness + action$happiness_change,
        xp = xp + action$xp_reward,
        outcome = action$perceived_value
      )

    user_data <- update_user_level(user_data)
  } else {
    user_data <- user_data %>%
      mutate(outcome = 0)  # No action taken if insufficient currency or level
  }

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



#' Simulate Tech Progression
#'
#' This function simulates the progression through a tech tree and updates user data.
#'
#' @param user_data A tibble containing user data.
#' @param tech_tree A tibble representing the tech tree.
#' @return A tibble with updated user data.
#' @export
simulate_tech_progression <- function(user_data, tech_tree) {
  tech_tree %>%
    rowwise() %>%
    mutate(
      user_data = list(
        if (all(user_data$tech_progress[node$prerequisites] > 0) &&
            user_data$currency1 >= node$cost_currency1 &&
            user_data$currency2 >= node$cost_currency2 &&
            user_data$level >= node$level_requirement) {
          user_data %>%
            mutate(
              currency1 = currency1 - node$cost_currency1,
              currency2 = currency2 - node$cost_currency2,
              tech_progress = ifelse(is.na(tech_progress[node$node_name]), node$value, tech_progress[node$node_name] + node$value),
              time_spent = ifelse(is.na(time_spent), node$time_required, time_spent + node$time_required),
              xp = xp + node$xp_reward
            ) %>%
            update_user_level()
        } else {
          user_data
        }
      )
    ) %>%
    unnest(user_data)
}
