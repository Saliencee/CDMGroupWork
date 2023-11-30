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
    return random.randint(18, 80)

# Function to generate a coherent BMI and height
def generate_coherent_bmi_and_height(age):
    # Adjusted height and BMI generation logic based on age
    height = np.clip(int(stats.norm.rvs(loc=170, scale=10)), 150, 200)
    bmi = round(np.clip(stats.norm.rvs(loc=25, scale=5), 15, 40), 1)
    return bmi, height

# Function to generate a random country and city
def generate_location():
    countries_cities = {
        "USA": ["New York", "Los Angeles", "Chicago", "Houston", "Miami"],
        "UK": ["London", "Manchester", "Birmingham", "Edinburgh", "Liverpool"],
        "Canada": ["Toronto", "Vancouver", "Montreal", "Calgary", "Ottawa"],
        "Australia": ["Sydney", "Melbourne", "Brisbane", "Perth", "Adelaide"],
        "India": ["Mumbai", "Delhi", "Bangalore", "Hyderabad", "Chennai"],
        "Germany": ["Berlin", "Munich", "Frankfurt", "Hamburg", "Cologne"],
        "France": ["Paris", "Lyon", "Marseille", "Toulouse", "Nice"],
        "Japan": ["Tokyo", "Osaka", "Yokohama", "Nagoya", "Sapporo"],
        "Brazil": ["Sao Paulo", "Rio de Janeiro", "Brasilia", "Salvador", "Fortaleza"],
        "South Africa": ["Johannesburg", "Cape Town", "Durban", "Pretoria", "Port Elizabeth"]
    }
    country = random.choice(list(countries_cities.keys()))
    city = random.choice(countries_cities[country])
    return country, city

# Function to generate a random education level
def generate_education(age):
    # Education level now depends on age
    if age < 22:
        return random.choice(["Primary", "High School"])
    elif age < 25:
        return random.choice(["Bachelor"])
    elif age < 30:
        return random.choice(["Master"])
    else:
        return random.choice(["PhD", "Master", "Bachelor"])

def generate_gene_expression():
    # Revised gene expression generation logic
    return np.clip(np.random.normal(0, 1, 10), -3, 3)

def generate_snp_values():
    # Revised SNP values generation logic
    return np.random.choice([0, 1, 2], 5, p=[0.2, 0.5, 0.3])

def determine_case_control_coherent(snp_values, gene_expressions):
    # Calculate average expression for the genes associated with each SNP
    avg_exp_snp1 = np.mean(gene_expressions[0:2])  # Gene expressions 1 and 2 for SNP 1
    avg_exp_snp2 = np.mean(gene_expressions[2:4])  # Gene expressions 3 and 4 for SNP 2

    # Define logic for case/control based on SNP values and gene expressions
    if snp_values[0] == 0 and avg_exp_snp1 < 50:
        return "Case"
    elif snp_values[1] == 0 and avg_exp_snp2 < 50:
        return "Case"
    else:
        return "Control"


# Generate the dataset
data = []
for i in range(500):
    name, gender = generate_coherent_name_and_gender()
    sample_id = generate_sample_id(i)
    age = generate_age()
    bmi, height = generate_coherent_bmi_and_height(age)
    country, city = generate_location()
    education = generate_education(age)
    snp_values = generate_snp_values()
    gene_expression = generate_gene_expression()
    
    case_control = determine_case_control_coherent(snp_values, gene_expression)
    data.append([name, sample_id, age, gender, bmi, height, country, city, education, gene_expression, snp_values, case_control])

columns = ["Name", "Sample ID", "Age", "Gender", "BMI", "Height", "Country", "City", "Education", "Gene Expression", "SNP Values", "Case/Control"]
df = pd.DataFrame(data, columns=columns)

print(df.head())

# Displaying the first few rows of the DataFrame
print(df.head())

PATH = ''
csv_file_path = '/Users/matthieutohme/Desktop/Clinical Data Management/CDM_Week8/dataset.csv'

df.to_csv(csv_file_path, index=False)

print(f"Dataset successfully saved to {csv_file_path}")


