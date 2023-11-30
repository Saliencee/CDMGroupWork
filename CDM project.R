# Generate Gene espression value
set.seed(42)

# Function to generate a random 10-number string
generate_random_string <- function() {
  paste(sample(0:9, 10, replace = TRUE), collapse = "")
}

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



