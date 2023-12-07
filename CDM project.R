# Generate Gene espression value
set.seed(42)

# Function to generate a random 10-number string
generate_random_string <- function() {
  paste(sample(-3:3, 2, replace = TRUE), collapse = "")
}
print(head(generate_random_string()))
# Generate 500 random assortments of 10-number strings
Gene_expression <- replicate(500, generate_random_string())

# Print the first few generated strings
cat("Gene expression:\n")
print(head(random_datasets))
dim(random_datasets)
summary(random_datasets)

# Generate SNP value
set.seed(20)


# Generate 500 random numbers from 0, 1, or 2
random_numbers <- sample(0:2, 500, replace = TRUE)

# Print the first few generated numbers
cat("SNP:\n")
print(head(random_numbers))

#Gene expression 2.0
# Set a seed for reproducibility
set.seed(42)

# Generate 500 random percentage values between 0 and 1 with 2 decimal places
random_percentages <- round(runif(500, min = 0, max = 1), 2)

# Print the first few generated percentage values
cat("Generated Percentage Values:\n")
print(head(random_percentages))
Expression1 <- replicate(500, random_percentages)
print(head(Expression1))

# Set a seed for reproducibility
set.seed(42)

# Define the number of variables
num_variables <- 500

# Generate a matrix of random percentage values between 0 and 1 with 2 decimal places
random_percentages_matrix <- matrix(round(runif(num_variables * 500, min = 0, max = 1), 2), ncol = num_variables)

# Combine the matrix into a data frame
my_dataset <- as.data.frame(random_percentages_matrix)

# Rename the single column
colnames(my_dataset) <- "Gene_expression1"

# Print the first few rows of the dataset
cat("Generated Dataset:\n")
print(head(my_dataset))

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
