# R/define_event.R

#' Define Event
#'
#' This function defines an event with its effects.
#'
#' @param event_name The name of the event.
#' @param currency1_change Change in currency 1.
#' @param currency2_change Change in currency 2.
#' @param public_order_change Change in public order.
#' @param happiness_change Change in happiness.
#' @param xp_change Change in XP.
#' @return A tibble representing the event.
#' @export
define_event <- function(event_name, currency1_change = 0, currency2_change = 0, public_order_change = 0, happiness_change = 0, xp_change = 0) {
  tibble(
    event_name = event_name,
    currency1_change = currency1_change,
    currency2_change = currency2_change,
    public_order_change = public_order_change,
    happiness_change = happiness_change,
    xp_change = xp_change
  )
}
