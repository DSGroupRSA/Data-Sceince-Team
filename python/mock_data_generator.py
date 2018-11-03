import random as random 
import datetime
from faker import Faker
import pandas as pd


fake  =  Faker()
provinces = ['Western Cape', 'Northen Cape', 'Eastern Cape', 'Gauteng', 'Limpopo', 'North West', 'Kwazulu Natal', 
             'Free State', 'Mpumalanga']
com_channel = ['WhatsApp', 'call', 'email']
table_columns = ["firstname", "lastname", "gender", "email", "contact", "comm_channel","address", "postal_code", "city", "province", "reg_date"]
sex = ['Male','Female', "Other"]


clients = pd.DataFrame(columns=table_columns)


for i in range(1,2):
    firstname = str(fake.first_name())
    lastname = str(fake.last_name())
    gender = random.choice(sex)
    email = str(fake.email())
    contact = fake.msisdn()
    comm_channel = random.choice(com_channel)
    address = str(random.choice([x for x in range(200,700)]))+" "+str(fake.street_name())+" "+str(fake.city())
    postal_code = int(fake.postalcode())
    city = str(fake.city())
    province = random.choice(provinces)
    reg_date = str(fake.date_time())  
    
    row = [firstname, lastname, gender, email, contact, comm_channel, address, postal_code, city, province, reg_date]
    clients.loc[i] = row

#clients.to_csv('../data/customers.csv', sep=';', encoding='utf-8', index=False)
print (address)


