# R/define_action.R

#' Define Action
#'
#' This function defines an action with its costs, rewards, and requirements.
#'
#' @param action_name The name of the action.
#' @param cost_currency1 Cost in currency 1.
#' @param cost_currency2 Cost in currency 2.
#' @param perceived_value Perceived value of the action.
#' @param public_order_change Change in public order.
#' @param happiness_change Change in happiness.
#' @param xp_reward XP reward for completing the action.
#' @param level_requirement Level requirement to perform the action.
#' @return A tibble representing the action.
#' @export
define_action <- function(action_name, cost_currency1 = 0, cost_currency2 = 0, perceived_value = 1.0, public_order_change = 0, happiness_change = 0, xp_reward = 0, level_requirement = 1) {
  tibble(
    action_name = action_name,
    cost_currency1 = cost_currency1,
    cost_currency2 = cost_currency2,
    perceived_value = perceived_value,
    public_order_change = public_order_change,
    happiness_change = happiness_change,
    xp_reward = xp_reward,
    level_requirement = level_requirement
  )
}
