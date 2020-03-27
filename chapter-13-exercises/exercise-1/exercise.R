# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
#install.packages("dbplyr")
#install.packages("DBI")
#install.packages("RSQLite")
library("DBI")
library("dplyr")
library("RSQLite")

# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
db_connection <- dbConnect(SQLite(), dbname = "data/Chinook_Sqlite.sqlite")

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
dbListTables(db_connection)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
genres_tbl <- tbl(db_connection, "Genre")
print(genres_tbl)

# Try to use `View()` to see the contents of the table. What happened?
View(genres_tbl)

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
genres_data <- collect(genres_tbl)
View(genres_data)

# Use dplyr's `count()` function to see how many rows are in the genre table
count(genres_data)

# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
track_tbl <- tbl(db_connection, "Track")
print(track_tbl)

# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filtering for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!
popular_artists <- track_tbl %>% 
  filter(is.na(Composer) == FALSE) %>%
  group_by(Composer) %>% 
  count() %>% 
  arrange(- n) # `n` is default column name after using `count()`
print(popular_artists)

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
popular_genre <- track_tbl %>% 
  group_by(GenreId) %>% 
  count() %>% 
  left_join(genres_tbl) %>% 
  arrange(- n) %>% 
  collect()
print(popular_genre[1, "Name"])

# Bonus: Query for a list of the most popular artist for each genre in the
# library (a "representative" artist for each).
# Consider using multiple grouping operations. Note that you can only filter
# for a `max()` value if you've collected the data into memory.
popular_artists_genre <- track_tbl %>% 
  filter(is.na(Composer) == FALSE) %>%
  group_by(GenreId, Composer) %>% 
  count() %>% 
  left_join(genres_tbl) %>% 
  select(genre = Name, artist = Composer, n_songs = n) %>% 
  group_by(genre) %>% 
  filter(n_songs == max(n_songs)) %>% 
  arrange(- n_songs) %>% 
  collect()
print(popular_artists_genre[, c("genre" , "artist", "n_songs")])

# Remember to disconnect from the database once you are done with it!
dbDisconnect(db_connection)
