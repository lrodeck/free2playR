# Feature Description: Crop Management
# In the "Crop Management" feature, players will:
#
# 1. Plant Crops: Players can plant different types of crops.
# 2. Grow Crops: Crops require time and resources to grow.
# 3. Harvest Crops: Once crops are fully grown, players can harvest them to earn resources (gold and experience points).
# 4. Upgrade Equipment: Players can upgrade their farming equipment to increase efficiency.
# 5. Manage Resources: Players will need to manage resources (gold and water) to plant and grow crops.
# 6. Complete Quests: Players can complete farming quests for additional rewards.

# Load the package
library(free2playR)

# Initialize the user ----
user <- initialize_user(
  user_id = 1,
  initial_currency1 = 1000,  # Gold
  initial_currency2 = 500,   # Water
  initial_public_order = 50,
  initial_happiness = 50,
  initial_xp = 0,
  initial_level = 1
)
print(user)


#  Define Tech Tree (Upgrades for Equipment) ----
## Define tech nodes for upgrading equipment ----
upgrade_hoe1 <- define_tech_node(
  node_name = "UpgradeHoe1",
  cost_currency1 = 100,
  cost_currency2 = 50,
  time_required = 2,
  value = 1,
  xp_reward = 50
)

upgrade_hoe2 <- define_tech_node(
  node_name = "UpgradeHoe2",
  cost_currency1 = 200,
  cost_currency2 = 100,
  time_required = 3,
  value = 2,
  xp_reward = 100,
  prerequisites = "UpgradeHoe1",
  level_requirement = 2
)

upgrade_watering_can1 <- define_tech_node(
  node_name = "UpgradeWateringCan1",
  cost_currency1 = 150,
  cost_currency2 = 75,
  time_required = 2,
  value = 1,
  xp_reward = 60
)

upgrade_watering_can2 <- define_tech_node(
  node_name = "UpgradeWateringCan2",
  cost_currency1 = 300,
  cost_currency2 = 150,
  time_required = 3,
  value = 2,
  xp_reward = 120,
  prerequisites = "UpgradeWateringCan1",
  level_requirement = 2
)

## Define the tech tree ----
tech_tree <- define_tech_tree(upgrade_hoe1, upgrade_hoe2, upgrade_watering_can1, upgrade_watering_can2)
print(tech_tree)

# Define Actions (Planting, Growing, and Harvesting Crops) ----
## Define actions for planting, growing, and harvesting crops ---
plant_wheat <- define_action(
  action_name = "PlantWheat",
  cost_currency1 = 50,  # Cost in gold
  cost_currency2 = 20,  # Cost in water
  perceived_value = 5,
  public_order_change = 1,
  happiness_change = 1,
  xp_reward = 30,
  level_requirement = 1
)

grow_wheat <- define_action(
  action_name = "GrowWheat",
  cost_currency1 = 10,
  cost_currency2 = 10,
  perceived_value = 10,
  public_order_change = 1,
  happiness_change = 2,
  xp_reward = 50,
  level_requirement = 1
)

harvest_wheat <- define_action(
  action_name = "HarvestWheat",
  cost_currency1 = 0,
  cost_currency2 = 0,
  perceived_value = 20,
  public_order_change = 2,
  happiness_change = 3,
  xp_reward = 100,
  level_requirement = 1
)

print(plant_wheat)
print(grow_wheat)
print(harvest_wheat)

# Define Quests (Completing Farming Tasks) ----
quest_plant_wheat <- define_quest(
  quest_name = "QuestPlantWheat",
  requirement = 30,  # XP requirement to complete the quest
  reward_currency1 = 50,  # Gold reward
  reward_currency2 = 30,   # Water reward
  reward_xp = 50
)

quest_harvest_wheat <- define_quest(
  quest_name = "QuestHarvestWheat",
  requirement = 100,
  reward_currency1 = 100,
  reward_currency2 = 50,
  reward_xp = 100
)

print(quest_plant_wheat)
print(quest_harvest_wheat)


# Simulate Actions and Quests ----

## Simulate planting wheat ---
user <- simulate_action(user, plant_wheat)
print(user)

## Simulate growing wheat ---
user <- simulate_action(user, grow_wheat)
print(user)

## Simulate harvesting wheat ---
user <- simulate_action(user, harvest_wheat)
print(user)

## Simulate upgrading the equipment ---
user <- simulate_tech_progression(user, tech_tree)
print(user)

## Simulate completing the quest to plant wheat ---
user <- complete_quest(user, quest_plant_wheat)
print(user)

## Simulate completing the quest to harvest wheat ---
user <- complete_quest(user, quest_harvest_wheat)
print(user)
