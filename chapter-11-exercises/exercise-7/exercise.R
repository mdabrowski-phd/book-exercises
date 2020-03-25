# Exercise 7: using dplyr on external data

# Load the `dplyr` library
library("dplyr")

# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
NBA_data <- read.csv("data/nba_teams_2016.csv", stringsAsFactors = FALSE)

# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
View(NBA_data)
dim(NBA_data)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
NBA_data <- mutate(NBA_data, TOV_to_STL = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
NBA_data <- arrange(NBA_data, TOV_to_STL)
lowest_ratio_team <- NBA_data %>% filter(OV_to_STL == min(TOV_to_STL)) %>% 
  select(Team, TOV_to_STL)
lowest_ratio_team

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
NBA_data <- NBA_data %>% mutate(assists_per_game = AST / G) %>% 
  arrange(desc(assists_per_game))

# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offense <- filter(NBA_data, PTS > 8700)

# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defense <- filter(NBA_data, BLK > 470)

# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense_stats <-select(NBA_data, Team, ORB, FG., AST)

# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defense_stats <- select(NBA_data, Team, DRB, STL, BLK)

# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team1, team2) {
  better_team <- filter(NBA_data, Team == team1 | Team == team2) %>%
    filter(FG. == max(FG.)) %>%
    select(Team, FG., PTS)
  better_team
}

# Call the function on two teams to compare them (remember the `*` if needed)
better.shooter <- better_shooters("Golden State Warriors*", "Cleveland Cavaliers*")
better.shooter
