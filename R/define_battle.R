# R/define_battle.R

#' Define Battle
#'
#' This function defines a battle scenario.
#'
#' @param battle_name The name of the battle.
#' @param required_level Minimum player level required to participate.
#' @param success_rate Probability of winning the battle.
#' @param reward_currency1 Reward in currency 1 for winning.
#' @param reward_currency2 Reward in currency 2 for winning.
#' @param xp_reward XP reward for winning.
#' @return A tibble representing the battle.
#' @export
define_battle <- function(battle_name, required_level, success_rate, reward_currency1 = 0, reward_currency2 = 0, xp_reward = 0) {
  tibble(
    battle_name = battle_name,
    required_level = required_level,
    success_rate = success_rate,
    reward_currency1 = reward_currency1,
    reward_currency2 = reward_currency2,
    xp_reward = xp_reward
  )
}
