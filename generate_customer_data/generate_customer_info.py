import pandas as pd
import random
import numpy as np

# Create Series of first names of length 2,500

    # Open text file:

with open('/home/srodier/repos/jugos_rodier/generate_customer_data/first_name_list') as file:
    file_content=file.read()

    # Extract first names:
first_names_list = file_content.split(sep=',')

    # Create pandas Series:
first_name = pd.Series(random.choices(first_names_list, k=2500))



# Create Series of last names of length 2,500

    # Open text file:

with open('/home/srodier/repos/jugos_rodier/generate_customer_data/last_name_list') as file:
    file_content=file.read()

    # Extract first names:
last_names_list = file_content.split(sep=',')

    # Create pandas Series:
last_name = pd.Series(random.choices(last_names_list, k=2500))



# Create Series of street names of length 2,500

    # Open text file:

with open('/home/srodier/repos/jugos_rodier/generate_customer_data/street_name_list') as file:
    file_content=file.read()

    # Extract street names:
street_names_list = file_content.split(sep=',')


# Create Series of street addresses of length 2,500
complete_add = []

for i in range(2500):
    house_num = str(random.choice(range(1,10000)))
    street = random.choice(street_names_list)
    complete_add.append(house_num+street)


address = pd.Series(complete_add)


# Create Series of street address 2 of length 2,500

    
sec_address=['apt', 'bldg', 'unit']

sec_address_list = random.choices(sec_address, k=2500)

    # Add unit numbers to the list where most of the numbers are below 50.  
        #Make some values Null since more people live in homes than apartment buildings: 
 
for i in range(len(sec_address_list)):
    a = random.choice(range(0,100))
    if a < 71:
        sec_address_list[i] = np.nan
    else:
        sec_address_list[i]+=' '
        building_number = str(random.randint(1,50))
        sec_address_list[i] += building_number
       


    # Convert to Series: 
        
sec_address= pd.Series(sec_address_list)


# Create Series of zip codes:

zip_list1=['93305', '93306', '93307', '93308', '93309']
zip_list2=['93301', '93304']

zipcode_list = []


for i in range(0,2500):
    a = random.randint(0,100)
    if a < 71:
        zipcode_list.append(random.choice(zip_list2))
    else:
        zipcode_list.append(random.choice(zip_list1))


    # Convert to Series: 

zipcode = pd.Series(zipcode_list)


# Create DataFrame:
                            
customer_info = pd.concat([first_name, last_name, address, sec_address, zipcode], axis=1)
customer_info.columns = ['first_name', 
            'last_name',
            'address',
            'sec_address',
            'zipcode']

# Add city and state since all customers are from the same city: 

customer_info['city']= 'Bakersfield'
customer_info['state'] = 'CA'
customer_info['Country'] = 'USA'

# write to csv

customer_info.to_csv("~/repos/jugos_rodier/csvs/customer_info.csv",index_label='customer_id')
