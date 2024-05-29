# Required libraries
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("ggplot2")) install.packages("ggplot2")

library(tidyverse)
library(ggplot2)

# Parameters
initial_money_per_sec <- 1          # Initial money generation rate per second
initial_goal <- 1000                # Initial monetary goal for market reset
initial_reset_boost <- 0.05         # Initial permanent production boost per reset (e.g., 0.05 for 5%)
initial_boost_currency_per_reset <- 10  # Initial boost currency earned per market reset
simulation_time <- 50000            # Total time to run the simulation (in seconds)

# Variable Parameters
reset_boost_growth_rate <- 0.01       # Growth rate of reset boost per reset
boost_currency_growth_rate <- 1       # Growth rate of boost currency per reset

# Parameterized Balancing Functions
balancing_functions <- list(
  exponential = function(x, a = 2) a^x,
  linear = function(x, b = 1000) x * b,
  logistic = function(x, L = 1000, k = 0.01, x0 = 50) L / (1 + exp(-k * (x - x0)))
)

# Custom Balancing Function (example)
custom_balancing_function <- function(x, base = 100, growth_rate = 1.05) {
  base * (growth_rate ^ x)
}

# Add the custom function to the list
balancing_functions$custom <- custom_balancing_function

# Simulation function
simulate_farm <- function(balancing_func, goal_increase_func, simulation_time, initial_money_per_sec, initial_goal, initial_reset_boost, initial_boost_currency_per_reset, reset_boost_growth_rate, boost_currency_growth_rate, func_params = list()) {
  time <- 0
  money <- 0
  current_goal <- initial_goal
  money_per_sec <- initial_money_per_sec
  reset_boost <- initial_reset_boost
  boost_currency_per_reset <- initial_boost_currency_per_reset
  boost_currency <- 0
  total_money <- 0
  reset_count <- 0

  # Data storage for plotting
  time_series <- data.frame(time = numeric(), money = numeric(), total_money = numeric(), boost_currency = numeric(), scenario = character())

  # Simulation loop
  while (time < simulation_time) {
    time <- time + 1
    money <- money + money_per_sec
    total_money <- total_money + money_per_sec

    # Check if goal is reached for market reset
    if (money >= current_goal) {
      reset_count <- reset_count + 1
      boost_currency <- boost_currency + boost_currency_per_reset
      reset_boost <- reset_boost * (1 + reset_boost_growth_rate)
      boost_currency_per_reset <- boost_currency_per_reset * (1 + boost_currency_growth_rate)
      money_per_sec <- money_per_sec * (1 + reset_boost)
      money <- 0
      current_goal <- do.call(goal_increase_func, c(list(reset_count), func_params))
    }

    # Store data for plotting
    time_series <- rbind(time_series, data.frame(time = time, money = money, total_money = total_money, boost_currency = boost_currency, scenario = paste(names(func_params), func_params, sep = "=", collapse = ", ")))
  }

  list(
    time_series = time_series,
    final_stats = list(
      total_resets = reset_count,
      final_money_per_sec = money_per_sec,
      total_boost_currency = boost_currency
    )
  )
}

# Scenarios for each balancing function
scenarios <- list(
  exponential = list(list(a = 1.5), list(a = 2), list(a = 3)),
  linear = list(list(b = 500), list(b = 1000), list(b = 2000)),
  logistic = list(list(L = 1000, k = 0.01, x0 = 50), list(L = 2000, k = 0.01, x0 = 50), list(L = 1000, k = 0.02, x0 = 50)),
  custom = list(list(base = 100, growth_rate = 1.05), list(base = 200, growth_rate = 1.05), list(base = 100, growth_rate = 1.1))
)

# Running simulations for each scenario
results <- list()
for (balancing_name in names(balancing_functions)) {
  for (params in scenarios[[balancing_name]]) {
    result <- simulate_farm(
      balancing_func = balancing_functions[[balancing_name]],
      goal_increase_func = balancing_functions[[balancing_name]],
      simulation_time = simulation_time,
      initial_money_per_sec = initial_money_per_sec,
      initial_goal = initial_goal,
      initial_reset_boost = initial_reset_boost,
      initial_boost_currency_per_reset = initial_boost_currency_per_reset,
      reset_boost_growth_rate = reset_boost_growth_rate,
      boost_currency_growth_rate = boost_currency_growth_rate,
      func_params = params
    )
    result$time_series$balancing <- balancing_name
    results <- c(results, list(result))
  }
}

# Combine results for plotting
combined_time_series <- bind_rows(lapply(results, function(result) result$time_series))

# Plotting the results
ggplot(combined_time_series, aes(x = time)) +
  geom_line(aes(y = money, color = "Current Money")) +
  geom_line(aes(y = total_money, color = "Total Money Generated")) +
  geom_line(aes(y = boost_currency * 100, color = "Boost Currency (scaled)")) +  # Scaling boost currency for better visualization
  facet_wrap(~ balancing + scenario, scales = "free_y") +
  labs(title = "Idle Farming Simulation", x = "Time (seconds)", y = "Amount", color = "Legend") +
  theme_minimal()

# Printing final stats
final_stats <- bind_rows(lapply(results, function(result) {
  stats <- result$final_stats
  data.frame(
    balancing = result$time_series$balancing[1],
    scenario = result$time_series$scenario[1],
    total_resets = stats$total_resets,
    final_money_per_sec = stats$final_money_per_sec,
    total_boost_currency = stats$total_boost_currency
  )
}))

print(final_stats)

# Interpretation of Results
interpretation <- final_stats %>%
  mutate(
    interpretation = case_when(
      balancing == "exponential" ~ "Exponential balancing shows rapid growth in goals and resources. Higher values of 'a' make progress faster but require more resources.",
      balancing == "linear" ~ "Linear balancing provides steady and predictable growth. Higher values of 'b' increase the goal increment linearly.",
      balancing == "logistic" ~ "Logistic balancing starts slow, accelerates, and then slows down as it reaches a maximum value. Parameters 'L', 'k', and 'x0' shape the curve.",
      balancing == "custom" ~ "Custom balancing allows for flexible growth rates. Higher base values and growth rates lead to faster progression but can also increase the difficulty."
    )
  )

print(interpretation)

# Generate summary paragraphs for each scenario
summary_paragraphs <- interpretation %>%
  group_by(balancing, scenario) %>%
  summarize(
    paragraph = paste0(
      "In the ", balancing, " scenario with parameters ", scenario,
      ", the game exhibited ", total_resets, " total resets, achieving a final money generation rate of ", round(final_money_per_sec, 2),
      " money per second and accumulating ", total_boost_currency, " boost currency. ",
      interpretation[1]
    )
  )

# Print the summary paragraphs
print(summary_paragraphs)
