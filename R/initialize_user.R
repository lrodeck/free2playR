# R/initialize_user.R

#' Initialize a User
#'
#' This function initializes a user with default or specified attributes.
#'
#' @param user_id User ID.
#' @param initial_currency1 Initial amount of currency 1.
#' @param initial_currency2 Initial amount of currency 2.
#' @param initial_public_order Initial public order value.
#' @param initial_happiness Initial happiness value.
#' @param initial_xp Initial XP.
#' @param initial_level Initial level.
#' @param tech_nodes A character vector of tech node names.
#'
#' @return A tibble representing the user data.
#' @export
initialize_user <- function(user_id = 1, initial_currency1 = 100, initial_currency2 = 50, initial_public_order = 50, initial_happiness = 50, initial_xp = 0, initial_level = 1, tech_nodes = character(0)) {
  tech_progress <- setNames(rep(0, length(tech_nodes)), tech_nodes)

  user_data <- tibble(
    user_id = user_id,
    currency1 = initial_currency1,
    currency2 = initial_currency2,
    public_order = initial_public_order,
    happiness = initial_happiness,
    xp = initial_xp,
    level = initial_level,
    start_time = Sys.time(),
    building_constructed = FALSE,
    building_type = NA,
    tech_progress = list(tech_progress),
    time_spent = 0  # Initialize time_spent
  )

  user_data
}

