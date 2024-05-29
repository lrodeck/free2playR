# R/define_quest.R

#' Define Quest
#'
#' This function defines a quest with its requirements and rewards.
#'
#' @param quest_name The name of the quest.
#' @param requirement The requirement to complete the quest.
#' @param reward_currency1 Reward in currency 1.
#' @param reward_currency2 Reward in currency 2.
#' @param reward_xp Reward in XP.
#' @return A tibble representing the quest.
#' @export
define_quest <- function(quest_name, requirement, reward_currency1 = 0, reward_currency2 = 0, reward_xp = 0) {
  tibble(
    quest_name = quest_name,
    requirement = requirement,
    reward_currency1 = reward_currency1,
    reward_currency2 = reward_currency2,
    reward_xp = reward_xp
  )
}
