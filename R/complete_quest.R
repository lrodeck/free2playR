# R/complete_quest.R

#' Complete Quest
#'
#' This function completes a quest if the requirement is met.
#'
#' @param user_data A tibble containing user data.
#' @param quest A tibble representing the quest.
#' @return A tibble with updated user data and quest completion status.
#' @export
complete_quest <- function(user_data, quest) {
  if (user_data$xp >= quest$requirement) {
    user_data %>%
      mutate(
        currency1 = currency1 + quest$reward_currency1,
        currency2 = currency2 + quest$reward_currency2,
        xp = xp + quest$reward_xp,
        quest_completed = TRUE
      )
  } else {
    user_data %>%
      mutate(quest_completed = FALSE)
  }
}
