from datetime import datetime

t0 = datetime.strptime('1/1/2000 10:00 AM', '%m/%d/%Y %I:%M %p')
t1 = datetime.strptime('1/1/2010 10:00 AM', '%m/%d/%Y %I:%M %p')
t2 = datetime.strptime('1/1/2021 10:00 AM', '%m/%d/%Y %I:%M %p')

# T1 params
doctors_no1 = 400
patients_no1 = 10000
ward_clerk_no1 = 40
regs_no1 = 10000
visits_no1 = 50000
clinics_no = 100
people_no1 = doctors_no1 + patients_no1 + ward_clerk_no1

# T2 params
doctors_no2 = 100
patients_no2 = 10000
ward_clerk_no2 = 10
regs_no2 = 10000
visits_no2 = 50000
people_no2 = doctors_no1 + patients_no1 + ward_clerk_no1
