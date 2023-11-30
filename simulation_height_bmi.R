rm(list = ls())
library(dplyr)

# Simulate Height and Weight Data:
set.seed(100) # For reproducibility of random data
n <- 500 # Number of individuals

# Simulate height in meters (e.g., mean = 1.7m, sd = 0.1m)
height <- rnorm(n, mean = 1.7, sd = 0.1)

# Simulate weight in kilograms (e.g., mean = 70kg, sd = 15kg)
weight <- rnorm(n, mean = 70, sd = 15)

# Round height and weight to 2 decimal places
height <- round(height, 2)
weight <- round(weight, 2)

# Calculate BMI:
bmi <- weight / (height^2)
bmi <- round(bmi, 2)

# Create a Data Frame:
simulation <- data.frame(Sample_id = 1:n, Height = height, Weight = weight, BMI = bmi)
head(simulation)
