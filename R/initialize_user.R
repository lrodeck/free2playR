# R/user.R

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
#' @param ... Additional attributes.
#'
#' @return A tibble representing the user data.
#' @export
initialize_user <- function(user_id = 1, initial_currency1 = 100, initial_currency2 = 50, initial_public_order = 50, initial_happiness = 50, initial_xp = 0, initial_level = 1, ...) {
  additional_attributes <- list(...)
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
    building_type = NA
  )

  additional_tibble <- tibble(!!!additional_attributes)
  user_data <- bind_cols(user_data, additional_tibble)

  user_data
}
