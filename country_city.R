# Sample data of cities and countries
cities <- c("New York", "London", "Paris", "Tokyo", "Sydney", "Cape Town", "Madrid","Lisbon" )
countries <- c("USA", "UK", "France", "Japan", "Australia", "South Africa", "Spain", "Portugal")

# Combine into a data frame
city_country_data <- data.frame(City = cities, Country = countries)

# Set a seed for reproducibility
set.seed(42)

# Shuffle the rows of the data frame to randomly assign cities and countries
shuffled_data <- city_country_data[sample(nrow(city_country_data)), 500 ]

# Print the shuffled data
print(shuffled_data)
