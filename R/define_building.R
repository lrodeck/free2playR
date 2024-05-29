# R/define_building.R

#' Define Building
#'
#' This function defines a building with its construction costs and associated tech tree.
#'
#' @param building_name The name of the building.
#' @param construction_cost_currency1 Construction cost in currency 1.
#' @param construction_cost_currency2 Construction cost in currency 2.
#' @param tech_tree The tech tree associated with the building.
#' @return A tibble representing the building.
#' @export
define_building <- function(building_name, construction_cost_currency1, construction_cost_currency2, tech_tree) {
  tibble(
    building_name = building_name,
    construction_cost_currency1 = construction_cost_currency1,
    construction_cost_currency2 = construction_cost_currency2,
    tech_tree = list(tech_tree)
  )
}
