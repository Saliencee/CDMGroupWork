library(dplyr)

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
generate_height <- function(gender) {
  if (gender == "Male") {
    # Assuming adult male height: mean ~1.75m, sd ~ 0.06m
    return(rnorm(1, mean = 1.75, sd = 0.06))
  } else {
    # Assuming adult female height: mean ~1.62m, sd ~ 0.05m
    return(rnorm(1, mean = 1.63, sd = 0.05))
  }
}

generate_weight <- function(gender) {
  if (gender == "Male") {
    # Assuming adult male weight: mean ~ 80kg, sd ~ 10kg
    return(rnorm(1, mean = 80, sd = 10))
  } else {
    # Assuming adult female weight: mean ~ 60kg, sd ~ 10kg
    return(rnorm(1, mean = 60, sd = 10))
  }
}

# Generate height and weight based on gender
height <- sapply(genders, generate_height)
weight <- sapply(genders, generate_weight)

# Round height and weight to 2 decimal places
height <- round(height, 2)
weight <- round(weight, 2)

# Calculate BMI:
bmi <- weight / (height^2)
bmi <- round(bmi, 2)

# Create a Data Frame:
simulation <- data.frame(sample_id = sample_ids,
                         name = full_names,
                         gender = genders,
                         age = ages,
                         height = height,
                         bmi = bmi)
head(simulation)
View(simulation)
