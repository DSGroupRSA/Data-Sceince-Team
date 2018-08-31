import random as random 
import datetime
from faker import Faker
import pandas as pd


fake  =  Faker()
provinces = ['Western Cape', 'Northen Cape', 'Eastern Cape', 'Gauteng', 'Limpopo', 'North West', 'Kwazulu Natal', 
             'Free State', 'Mpumalanga']
com_channel = ['WhatsApp', 'call', 'email']
table_columns = ['name','surname','cell_no','telephone_no','email','comm_channel', 'address','region','gender','reg_date','created_by_id']
sex = ['Male','Female', 'Gay', 'Lesbian', 'Trans-Woman', 'Trans-Man']


clients = pd.DataFrame(columns=table_columns)


for i in range(1,2):
    name = str(fake.first_name())
    surname = str(fake.last_name())
    gender = random.choice(sex)
    cell_no = fake.msisdn()
    telephone_no = str(fake.phone_number())
    email = str(fake.email())
    comm_channel = random.choice(com_channel)
    address = {"street_no":random.choice([x for x in range(200,700)]), "street_name":str(fake.street_name()),
                         "suburb":str(fake.city()), "postal_code":int(fake.postalcode())}
    region = random.choice(provinces)
    reg_date = str(fake.date_time())  #datetime.datetime.now()
    created_bd_id = str(fake.user_name())
    
    row = [name,surname,cell_no,telephone_no,email,comm_channel,str(address),region,gender,reg_date,created_bd_id]
    clients.loc[i] = row

clients.to_csv('clients2.csv', sep=';', encoding='utf-8', index=False)