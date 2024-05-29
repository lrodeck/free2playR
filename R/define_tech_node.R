# R/define_tech_node.R

#' Define Tech Node
#'
#' This function defines a tech node with its costs, rewards, and requirements.
#'
#' @param node_name The name of the tech node.
#' @param cost_currency1 Cost in currency 1.
#' @param cost_currency2 Cost in currency 2.
#' @param time_required Time required to complete the node.
#' @param value Value provided by the node.
#' @param xp_reward XP reward for completing the node.
#' @param prerequisites Prerequisite nodes.
#' @param level_requirement Level requirement to unlock the node.
#' @return A tibble representing the tech node.
#' @export
define_tech_node <- function(node_name, cost_currency1, cost_currency2, time_required, value, xp_reward = 0, prerequisites = NULL, level_requirement = 1) {
  tibble(
    node_name = node_name,
    cost_currency1 = cost_currency1,
    cost_currency2 = cost_currency2,
    time_required = time_required,
    value = value,
    xp_reward = xp_reward,
    prerequisites = list(prerequisites),
    level_requirement = level_requirement
  )
}
