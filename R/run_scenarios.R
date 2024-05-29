# R/run_scenarios.R

#' Run Scenarios
#'
#' This function runs multiple scenarios of simulations.
#'
#' @param user A tibble containing initial user data.
#' @param building A tibble representing the building.
#' @param tech_tree A tibble representing the tech tree.
#' @param scenarios A list of scenario parameters.
#' @return A list containing the results of each scenario.
#' @export
run_scenarios <- function(user, building, tech_tree, scenarios) {
  scenario_results <- lapply(scenarios, function(scenario) {
    scenario_tech_tree <- tech_tree %>%
      mutate(
        node = map(node, ~ .x %>%
                     mutate(
                       cost_currency1 = cost_currency1 * scenario$price_multiplier,
                       cost_currency2 = cost_currency2 * scenario$price_multiplier,
                       time_required = time_required * scenario$time_multiplier
                     )
        )
      )
    scenario_building <- building %>%
      mutate(
        construction_cost_currency1 = construction_cost_currency1 * scenario$price_multiplier,
        construction_cost_currency2 = construction_cost_currency2 * scenario$price_multiplier,
        tech_tree = list(scenario_tech_tree)
      )

    user_data <- user %>%
      simulate_building_construction(scenario_building)

    if (user_data$building_constructed) {
      user_data <- simulate_tech_progression(user_data, scenario_tech_tree)
    }

    user_data %>%
      mutate(scenario_name = scenario$name)
  })

  bind_rows(scenario_results)
}
