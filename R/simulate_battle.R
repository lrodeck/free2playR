# R/simulate_battle.R

#' Simulate Battle
#'
#' This function simulates a battle and updates user data based on the outcome.
#'
#' @param user_data A tibble containing user data.
#' @param battle A tibble representing the battle.
#' @return A tibble with updated user data.
#' @export
simulate_battle <- function(user_data, battle) {
  if (user_data$level >= battle$required_level) {
    if (runif(1) <= battle$success_rate) {
      user_data <- user_data %>%
        mutate(
          currency1 = currency1 + battle$reward_currency1,
          currency2 = currency2 + battle$reward_currency2,
          xp = xp + battle$xp_reward,
          battle_result = "win"
        )
    } else {
      user_data <- user_data %>%
        mutate(battle_result = "lose")
    }
  } else {
    user_data <- user_data %>%
      mutate(battle_result = "level_too_low")
  }

  user_data
}
