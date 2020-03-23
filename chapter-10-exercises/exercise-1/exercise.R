# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
points_seahawks <- c(21, 28, 27, 27)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
points_others <- c(20, 26, 33, 10)

# Combine your two vectors into a dataframe called `games`
games <- data.frame(points_seahawks, points_others, stringsAsFactors = FALSE)

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
games$difference <- games$points_seahawks - games$points_others

# Create a new column "won" which is TRUE if the Seahawks won the game
games$won <- games$difference > 0

# Create a vector of the opponent names corresponding to the games played
opponents <- c("Cincinnati Bengals", "Pittsburgh Steelers", "
New Orleans Saints", "Arizona Cardinals")

# Assign your dataframe rownames of their opponents
rownames(games) <- opponents

# View your data frame to see how it has changed!
View(games)
