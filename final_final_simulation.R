library(dplyr)
rm(list = ls())
## Set seed for reproducibility
set.seed(0)

n<-500

## first name list for male

male_firstnames<-c("Ethan","Alexander","Benjamin","Nicholas","Samuel","Lucas","Henry","Dylan","Adam","Nathan"
                   ,"Ryan","Tyler","Jacob","Liam","Brandon","Jack","Zachary","Kyle","Aaron","Gabriel")

female_firstnames<-c("Emma","Olivia","Ava","Isabella","Sophia","Mia","Charlotte","Amelia","Harper","Evelyn"
                     ,"Abigail","Emily","Elizabeth","Sofia","Madison","Avery","Ella","Scarlett","Grace","Chloe")

last_names<-c("Smith","Johnson","Williams","Brown","Jones","Garcia","Miller","Davis","Rodriguez","Martinez","Hernandez"
             ,"Lopez","Gonzalez","Wilson","Anderson","Thomas","Taylor","Moore","Jackson","Martin")


# Sample genders
genders <- sample(c("Male", "Female"), n, replace = TRUE)

# Function to generate names based on gender
generate_names <- function(gender, male_names, female_names) {
  if (gender == "Male") {
    return(sample(male_names, 1))
  } else {
    return(sample(female_names, 1))
  }
}

# Generate names
names <- mapply(generate_names, genders, MoreArgs = list(male_names = male_firstnames, female_names = female_firstnames))

# Optionally combine with last names
full_names <- paste(names, sample(last_names, n, replace = TRUE))


# Generate unique sample IDs
# Using a prefix 'ID' followed by a unique number
sample_ids <- sprintf("ID%06d", 1:n)


# Generate Age
ages <- sample(20:80, n, replace = TRUE)

# Function to generate height and weight based on gender
# https://digital.nhs.uk/data-and-information/publications/statistical/health-survey-for-england/2021/part-4-trends
# NHS Digital: Health Survey for England, 2021 part 1
generate_height <- function(gender) {
  if (gender == "Male") {
    # Assuming adult male height: mean ~1.76m, sd ~ 0.06m
    return(rnorm(1, mean = 1.76, sd = 0.06))
  } else {
    # Assuming adult female height: mean ~1.62m, sd ~ 0.05m
    return(rnorm(1, mean = 1.62, sd = 0.05))
  }
}

generate_weight <- function(gender) {
  if (gender == "Male") {
    # Assuming adult male weight: mean ~ 85.4kg, sd ~ 11.8kg
    return(rnorm(1, mean = 85.4, sd = 11.8))
  } else {
    # Assuming adult female weight: mean ~72.1kg, sd ~ 10.2kg
    return(rnorm(1, mean = 72.1, sd = 10.2))
  }
}

# Generate height and weight based on gender
height <- sapply(genders, generate_height)
weight <- sapply(genders, generate_weight)

# Round height and weight to 2 decimal places
height <- round(height, 2)
weight <- round(weight, 1)

# Calculate BMI:
bmi <- weight / (height^2)
bmi <- round(bmi, 1)


# Ensure country names in 'countries' vector match the keys in 'cities' list
countries <- c("USA", "UK", "India", "Nigeria", "Brazil")  # Note: Changed 'Indian' to 'India'

# Adjust the 'cities' list if necessary to ensure the keys match the 'countries' vector
cities <- list(
  USA = c("New York", "Los Angeles", "Chicago"),
  UK = c("London", "Manchester", "Birmingham"),
  India = c("Mumbai", "Delhi", "Bangalore"),
  Nigeria = c("Lagos", "Abuja", "Port Harcourt"),
  Brazil = c("São Paulo", "Rio de Janeiro", "Brasília")
)

# Function to randomly select a city based on the assigned country
select_city <- function(country) {
  if (!country %in% names(cities)) {
    return(NA)  # Return NA if the country is not found
  }
  return(sample(cities[[country]], 1))
}

# Randomly assign a country to each individual
assigned_countries <- sample(countries, n, replace = TRUE)

# Assign cities based on the randomly chosen countries
assigned_cities <- sapply(assigned_countries, select_city)

# Define the function to determine education level based on age 
get_education_level <- function(age) {
  if (age < 22) {
    return(sample(c("Primary", "High School"), 1))
  } else if (age < 25) {
    return("Bachelor")
  } else if (age < 30) {
    return("Master")
  } else {
    return(sample(c("PhD", "Master", "Bachelor"), 1))
  }
} 

# Apply the function to each age 
education_levels <- sapply(ages, get_education_level)

# Gene expression
num_genes <- 10  # Total number of genes to simulate
num_samples <- 500  # Number of samples
gene_expression_data <- matrix(rlnorm(num_genes * num_samples, meanlog = 2, sdlog = 0.5), 
                               nrow = num_samples, 
                               ncol = num_genes)

# SNP
generate_snp_values <- sample(c(0, 1, 2), 5, replace=TRUE, prob=c(0.25, 0.5, 0.25))


# Case & control
case_control <- ifelse(bmi >= 30, "case", "control")

# Now use 'assigned_countries' and 'assigned_cities' in your final data frame
simulation <- data.frame(sample_id = sample_ids,
                         name = full_names,
                         gender = genders,
                         age = ages,
                         height = height,
                         weight = weight,  # Add weight if you want it in your data frame
                         bmi = bmi,
                         country = assigned_countries,
                         city = assigned_cities,
                         education = education_levels,
                         gene_expressioin = gene_expression_data,
                         SNP = generate_snp_values,
                         case_control = case_control)

head(simulation)
View(simulation)




print(table1_strat)
                            Stratified by case_control
                             case          control        p      test
  n                            147           353                     
  gender = Male (%)             80 (54.4)    178 ( 50.4)   0.474     
  age (mean (SD))            50.07 (18.19) 49.91 (17.70)   0.929     
  height (mean (SD))          1.66 (0.08)   1.70 (0.09)   <0.001     
  weight (mean (SD))         91.78 (10.71) 73.67 (10.67)  <0.001     
  bmi (mean (SD))            33.07 (2.54)  25.35 (2.90)   <0.001     
  country (%)                                              0.899     
     Brazil                     29 (19.7)     62 ( 17.6)             
     India                      33 (22.4)     78 ( 22.1)             
     Nigeria                    28 (19.0)     69 ( 19.5)             
     UK                         33 (22.4)     74 ( 21.0)             
     USA                        24 (16.3)     70 ( 19.8)             
  education (%)                                            0.134     
     Bachelor                   57 (38.8)    113 ( 32.0)             
     High School                 0 ( 0.0)      8 (  2.3)             
     Master                     54 (36.7)    122 ( 34.6)             
     PhD                        34 (23.1)    107 ( 30.3)             
     Primary                     2 ( 1.4)      3 (  0.8)             
  SNP (%)                                                  0.256     
     0                          34 (23.1)     66 ( 18.7)             
     1                          80 (54.4)    220 ( 62.3)             
     2                          33 (22.4)     67 ( 19.0)             
  case_control = control (%)     0 ( 0.0)    353 (100.0)  <0.001






