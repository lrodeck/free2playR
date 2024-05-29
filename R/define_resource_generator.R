# R/define_resource_generator.R

#' Define Resource Generator
#'
#' This function defines a resource generator.
#'
#' @param generator_name The name of the generator.
#' @param resource_rate1 Rate of resource 1 generation.
#' @param resource_rate2 Rate of resource 2 generation.
#' @return A tibble representing the resource generator.
#' @export
define_resource_generator <- function(generator_name, resource_rate1 = 0, resource_rate2 = 0) {
  tibble(
    generator_name = generator_name,
    resource_rate1 = resource_rate1,
    resource_rate2 = resource_rate2
  )
}
