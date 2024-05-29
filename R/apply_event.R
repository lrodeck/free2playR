# R/apply_event.R

#' Apply Event
#'
#' This function applies an event to the user data.
#'
#' @param user_data A tibble containing user data.
#' @param event A tibble representing the event.
#' @return A tibble with updated user data.
#' @export
apply_event <- function(user_data, event) {
  user_data %>%
    mutate(
      currency1 = currency1 + event$currency1_change,
      currency2 = currency2 + event$currency2_change,
      public_order = public_order + event$public_order_change,
      happiness = happiness + event$happiness_change,
      xp = xp + event$xp_change
    )
}
