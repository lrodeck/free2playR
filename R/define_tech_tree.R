# R/define_tech_tree.R

#' Define Tech Tree
#'
#' This function defines a tech tree composed of multiple tech nodes.
#'
#' @param ... Tech nodes to be included in the tech tree.
#' @return A tibble representing the tech tree.
#' @export
define_tech_tree <- function(...) {
  nodes <- list(...)
  tibble(
    node_id = 1:length(nodes),
    node = nodes
  )
}
