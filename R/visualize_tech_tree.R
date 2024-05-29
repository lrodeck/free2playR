# R/visualize_tech_tree.R

#' Visualize Tech Tree Progression
#'
#' This function plots the progression through the tech tree.
#'
#' @param user_data A tibble containing user data with tech tree progression.
#' @param tech_tree The tech tree structure.
#' @return A ggplot object showing the tech tree progression.
#' @export
visualize_tech_tree <- function(user_data, tech_tree) {
  tech_progress <- user_data %>%
    select(starts_with("tech_progress_")) %>%
    pivot_longer(everything(), names_to = "tech_node", values_to = "progress")

  ggplot(tech_progress, aes(x = tech_node, y = progress)) +
    geom_bar(stat = "identity") +
    labs(title = "Tech Tree Progression", x = "Tech Node", y = "Progress") +
    theme_minimal()
}
