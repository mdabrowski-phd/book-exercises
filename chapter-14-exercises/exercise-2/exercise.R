# Exercise 2: working with data APIs

# load relevant libraries
#install.packages("httr")
#install.packages("jsonlite")
library("httr")
library("jsonlite")
library("dplyr")

# Be sure and check the README.md for complete instructions!

# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("../api_keys.R")
print(nyt_api_key)

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Black Hawk Down"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
endpoint <- "reviews/search.json"

resource_uri <- paste0(base_uri, endpoint)
query_params <- list("api-key" = nyt_api_key, query = movie_name)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(resource_uri, query = query_params)

response_text <- content(response, type = "text")
response_data <-fromJSON(response_text)

# What kind of data structure did this produce? A data frame? A list?
is.data.frame(response_data)
is.list(response_data)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(response_data)
str(response_data)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(response_data$results)
View(reviews)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
first_review <- reviews[1, ]
headline <- first_review$headline
summary <- first_review$summary_short
link <- first_review$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
review <- list(headline=headline, summary=summary, link=link)
print(review)
