# R/building.R

#' Simulate Building Construction
#'
#' This function simulates the construction of a building and updates user data.
#'
#' @param user_data A tibble containing user data.
#' @param building A tibble representing the building.
#' @return A tibble with updated user data.
#' @export
simulate_building_construction <- function(user_data, building) {
  if (user_data$currency1 >= building$construction_cost_currency1 && user_data$currency2 >= building$construction_cost_currency2) {
    user_data %>%
      mutate(
        currency1 = currency1 - building$construction_cost_currency1,
        currency2 = currency2 - building$construction_cost_currency2,
        building_constructed = TRUE,
        building_type = building$building_name
      )
  } else {
    user_data %>%
      mutate(building_constructed = FALSE)
  }
}
