# R/initialize_inventory.R

#' Initialize Inventory
#'
#' This function initializes an inventory for a user.
#'
#' @param items A named list of items with their initial quantities.
#' @return A tibble representing the inventory.
#' @export
initialize_inventory <- function(items = list()) {
  tibble(
    item_name = names(items),
    quantity = unlist(items)
  )
}
