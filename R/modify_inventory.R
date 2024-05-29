# R/modify_inventory.R

#' Modify Inventory
#'
#' This function modifies the inventory by adding or removing items.
#'
#' @param inventory A tibble representing the inventory.
#' @param item_name The name of the item to modify.
#' @param quantity_change The change in quantity of the item.
#' @return A tibble with updated inventory.
#' @export
modify_inventory <- function(inventory, item_name, quantity_change) {
  if (item_name %in% inventory$item_name) {
    inventory <- inventory %>%
      mutate(
        quantity = ifelse(item_name == item_name, quantity + quantity_change, quantity)
      )
  } else {
    inventory <- inventory %>%
      add_row(item_name = item_name, quantity = quantity_change)
  }

  inventory
}
