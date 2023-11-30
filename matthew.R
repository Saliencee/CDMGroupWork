library(dplyr)
library(tidyr)
library(random)
library(norm)
library(stringr)

# Function to generate a random name and gender, considering the country
generate_coherent_name_and_gender <- function(country) {
  names_by_country <- list(
    USA = list(c("James", "John", "Robert", "Michael", "William"), c("Mary", "Patricia", "Jennifer", "Linda", "Elizabeth"), c("Smith", "Johnson", "Williams")),
    UK = list(c("Oliver", "George", "Harry", "Jack", "Jacob"), c("Olivia", "Amelia", "Isla", "Ava", "Emily"), c("Smith", "Jones", "Taylor")),
    India = list(c("Aarav", "Vihaan", "Vivaan", "Ansh", "Arjun"), c("Aadhya", "Diya", "Saanvi", "Ananya", "Aarohi"), c("Patel", "Singh", "Kumar")),
    China = list(c("Wei", "Ming", "Feng", "Jun", "Lei"), c("Ling", "Fang", "Mei", "Yan", "Ying"), c("Wang", "Li", "Zhang")),
    Nigeria = list(c("Ade", "Chike", "Ifeanyi", "Obi", "Uzoma"), c("Amina", "Chinwe", "Folake", "Nneka", "Zainab"), c("Adebayo", "Musa", "Okonkwo")),
    Brazil = list(c("João", "Gabriel", "Mateus", "Lucas", "Pedro"), c("Ana", "Maria", "Clara", "Beatriz", "Alice"), c("Silva", "Santos", "Oliveira"))
  )
  
  names <- names_by_country[[country]]
  if (is.null(names)) {
    names <- list(c("John", "David"), c("Anna", "Emily"), c("Smith", "Brown"))
  }
  
  gender <- sample(c("Male", "Female"), 1)
  first_name <- sample(names[[if (gender == "Male") 1 else 2]], 1)
  last_name <- sample(names[[3]], 1)
  return(paste(first_name, last_name, sep=" "), gender)
}

# Function to generate a sample ID
generate_sample_id <- function(index) {
  return(paste0("S", str_pad(as.character(index), 6, pad = "0")))
}

# Function to generate a random age
generate_age <- function() {
  return(sample(18:80, 1))
}

# Function to generate a coherent BMI and height
generate_coherent_bmi_and_height <- function(age) {
  height <- pmax(pmin(rnorm(1, 170 - ifelse(age < 20, 50, 0), 10), 200), 150)
  bmi <- round(pmax(pmin(rnorm(1, 25 - ifelse(age < 20, 5, 0), 5), 40), 15), 1)
  return(list(bmi, height))
}

# Function to generate a random country and city
generate_location <- function() {
  countries_cities <- list(
    USA = c("New York", "Los Angeles", "Chicago"),
    UK = c("London", "Manchester", "Birmingham"),
    India = c("Mumbai", "Delhi", "Bangalore"),
    China = c("Beijing", "Shanghai", "Guangzhou"),
    Nigeria = c("Lagos", "Abuja", "Port Harcourt"),
    Brazil = c("São Paulo", "Rio de Janeiro", "Brasília")
  )
  
  country <- sample(names(countries_cities), 1)
  city <- sample(countries_cities[[country]], 1)
  return(list(country, city))
}

# Function to generate a random education level
generate_education <- function(age, country) {
  education_levels <- list(
    USA = c("High School", "Bachelor's", "Master's", "PhD"),
    UK = c("A-Levels", "Bachelor's", "Master's", "PhD"),
    India = c("Higher Secondary", "Bachelor's", "Master's", "PhD"),
    China = c("Senior High School", "Bachelor's", "Master's", "PhD"),
    Nigeria = c("SSCE", "Bachelor's", "Master's", "PhD"),
    Brazil = c("Ensino Médio", "Bacharelado", "Mestrado", "Doutorado")
  )
  
  levels <- education_levels[[country]]
  if (is.null(levels)) {
    levels <- c("High School", "Bachelor's", "Master's", "PhD")
  }
  
  if (age < 22) {
    levels <- levels[1]
  } else if (age < 25) {
    levels <- levels[1:2]
  } else if (age < 30) {
    levels <- levels[1:3]
  }
  
  return(sample(levels, 1))
}

generate_gene_expressions <- function() {
  return(round(runif(10, min=-3, max=3), 2))
}

generate_snp_values <- function() {
  return(sample(c(0, 1, 2), 5, replace=TRUE, prob=c(0.2, 0.5, 0.3)))
}

determine_case_control_coherent <- function(snp_values, gene_expressions) {
  avg_exp_snp1 <- mean(gene_expressions[1:2])
  avg_exp_snp2 <- mean(gene_expressions[3:4])
  
  if (snp_values[1] == 0 && avg_exp_snp1 < 40) {
    return("Case")
  } else if (snp_values[2] == 0 && avg_exp_snp2 < 40) {
    return("Case")
  } else if (snp_values[1] == 2 && avg_exp_snp1 > 60) {
    return("Control")
  } else if (snp_values[2] == 2 && avg_exp_snp2 > 60) {
    return("Control")
  } else {
    return(sample(c("Case", "Control"), 1))
  }
}

# Generate the dataset
data <- list()
for (i in 1:500) {
  location <- generate_location()
  name_gender <- generate_coherent_name_and_gender(location[[1]])
  sample_id <- generate_sample_id(i)
  age <- generate_age()
  bmi_height <- generate_coherent_bmi_and_height(age)
  education <- generate_education(age, location[[1]])
  gene_expressions <- generate_gene_expressions()
  snp_values <- generate_snp_values()
  case_control <- determine_case_control_coherent(snp_values, gene_expressions)
  
  data_row <- c(name_gender, sample_id, age, bmi_height, location, education, case_control, gene_expressions, snp_values)
  data[[i]] <- data_row
}

# Define column names
columns <- c("Name", "Gender", "Sample ID", "Age", "BMI", "Height", "Country", "City", "Education", "Case/Control")
gene_expression_columns <- paste0("Expression", 1:10)
snp_columns <- paste0("SNP", 1:5)
columns <- c(columns, gene_expression_columns, snp_columns)

# Create DataFrame
df <- do.call(rbind, data) %>% as.data.frame()
names(df) <- columns

# Save to CSV
csv_file_path <- "/Users/matthieutohme/Desktop/Clinical Data Management/CDM_Week8/dataset.csv"
write.csv(df, csv_file_path, row.names = FALSE)

print(paste("Dataset successfully saved to", csv_file_path))
