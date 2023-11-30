import scipy.stats as stats
import pandas as pd
import random
import numpy as np

# Function to generate a random name
def generate_coherent_name_and_gender():
    male_first_names = ["James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles"]
    female_first_names = ["Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen"]
    last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez",
                  "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin"]
    
    gender = random.choice(["Male", "Female"])
    first_name = random.choice(male_first_names if gender == "Male" else female_first_names)
    last_name = random.choice(last_names)
    
    return first_name + " " + last_name, gender

# Function to generate a sample ID
def generate_sample_id(index):
    return f"S{str(index).zfill(6)}"

# Function to generate a random age
def generate_age():
    return random.randint(0, 100)

# Function to generate a coherent BMI and height
def generate_coherent_bmi_and_height():
    height = max(min(int(stats.norm.rvs(loc=170, scale=10)), 200), 150)  # Height within 150cm to 200cm
    bmi = round(max(min(stats.norm.rvs(loc=25, scale=5), 40), 15), 1)   # BMI within 15 to 40
    return bmi, height

# Function to generate a random country and city
def generate_location():
    countries_cities = {
        "USA": ["New York", "Los Angeles", "Chicago"],
        "UK": ["London", "Manchester", "Birmingham"],
        # Other countries and cities
    }
    country = random.choice(list(countries_cities.keys()))
    city = random.choice(countries_cities[country])
    return country, city

# Function to generate a random education level
def generate_education():
    return random.choice(["Primary", "High School", "Bachelor", "Master", "PhD"])

# Function to generate 10 gene expression values
def generate_gene_expression():
    return np.random.rand(10)

# Function to generate 5 SNP values (0, 1, 2)
def generate_snp_values():
    return np.random.choice([0, 1, 2], 5)

def determine_case_control_coherent(age, bmi, height, country):
    if age > 50 and bmi > 25 and height < 170 and country in ["USA", "UK", "Germany"]:
        return "Case"
    else:
        return "Control"

# Generate the dataset
data = []
for i in range(500):
    name, gender = generate_coherent_name_and_gender()
    sample_id = generate_sample_id(i)
    age = generate_age()
    bmi, height = generate_coherent_bmi_and_height()
    country, city = generate_location()
    education = generate_education()
    gene_expression = generate_gene_expression()
    snp_values = generate_snp_values()
    case_control = determine_case_control_coherent(age, bmi, height, country)

    data.append([name, sample_id, age, gender, bmi, height, country, city, education, gene_expression, snp_values, case_control])

# Creating the DataFrame
columns = ["Name", "Sample ID", "Age", "Gender", "BMI", "Height", "Country", "City", "Education", "Gene Expression", "SNP Values", "Case/Control"]
df = pd.DataFrame(data, columns=columns)

# Displaying the first few rows of the DataFrame
print(df.head())

PATH = ''
csv_file_path = '/Users/matthieutohme/Desktop/Clinical Data Management/CDM_Week8/dataset.csv'

df.to_csv(csv_file_path, index=False)

print(f"Dataset successfully saved to {csv_file_path}")
