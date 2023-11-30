
# Set a seed for reproducibility
set.seed(42)

# Generate 500 random numbers between -3 and 3
random_numbers <- runif(500, min = -3, max = 3)

# Print the first few generated numbers
cat("Generated Random Numbers:\n")
print(head(random_numbers))
Expression1 <- random_numbers
Expression2 <- random_numbers
dataset <- data.frame(
  Expression1 = random_numbers,
  Expression2 = random_numbers,
  Expression3 = random_numbers,
  Expression4 = random_numbers,
  Expression5 = random_numbers,
  Expression6 = random_numbers,
  Expression7 = random_numbers,
  Expression8 = random_numbers,
  Expression9 = random_numbers,
  Expression10 = random_numbers,
  SNP1 = SNP1,
  SNP2 = SNP2,
  SNP3 = SNP3,
  SNP4 = SNP4,
  SNP5 = SNP5
)
print(dataset)
