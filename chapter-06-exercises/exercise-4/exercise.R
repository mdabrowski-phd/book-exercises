# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function(str1, str2) {
  longer <- max(nchar(str1), nchar(str2)) - min(nchar(str1), nchar(str2)) >= 
    min(nchar(str1), nchar(str2))
  longer
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_as_long("aaa", "bb")
is_twice_as_long("aaaa", "bb")
is_twice_as_long("aaaaa", "bb")
is_twice_as_long("aa", "bbbbb")

# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(str1, str2) {
  if(nchar(str1) > nchar(str2)) {
    print(paste("Your first string is longer by ", 
                nchar(str1) - nchar(str2), " characters"))
  } else if(nchar(str1) < nchar(str2)) {
    print(paste("Your second string is longer by ", 
                nchar(str2) - nchar(str1), " characters"))
  } else {
    print("Your strings are the same length!")
  }
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions!
describe_difference("Asia", "Michal")
describe_difference("Joanna", "Michal")
describe_difference("Piotr", "Ewa")
