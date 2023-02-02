from generators import *
from params import *


def snapshot1():
    doctors_init_id = 0
    doctors_end_id = doctors_no1
    patients_init_id = doctors_no1
    patients_end_id = doctors_end_id + patients_no1
    clerks_init_id = patients_end_id
    clerks_end_id = people_no1

    generate_clinics(clinics_no).to_excel('clinics.xlsx', index=False, header=True,
                                          columns=['ID', 'MIASTO', 'KOD_POCZTOWY', 'ULICA', 'NR_BUDYNKU'])
    save_data(generate_people(0, people_no1), "people1.bulk")
    save_data(generate_doctors(doctors_init_id, doctors_end_id), "doctors1.bulk")
    save_data(generate_patients(patients_init_id, patients_end_id), "patients1.bulk")
    save_data(generate_ward_clerks(clerks_init_id, clerks_end_id), "ward_clerks1.bulk")
    save_data(generate_regs(0, regs_no1, patients_init_id, patients_end_id, clerks_init_id, clerks_end_id, t0, t1),
              "regs1.bulk")
    save_data(generate_visits(0, visits_no1, 0, regs_no1, doctors_init_id, doctors_end_id), "visits1.bulk")


def snapshot2():
    doctors_init_id = people_no1
    doctors_end_id = people_no1 + doctors_no2
    patients_init_id = people_no1 + doctors_no2
    patients_end_id = patients_init_id + patients_no2
    clerks_init_id = patients_end_id
    clerks_end_id = clerks_init_id + ward_clerk_no2

    save_data(generate_people(people_no1, people_no1 + people_no2), "people2.bulk")
    save_data(generate_doctors(doctors_init_id, doctors_end_id), "doctors2.bulk")
    save_data(generate_patients(patients_init_id, patients_end_id), "patients2.bulk")
    save_data(generate_ward_clerks(clerks_init_id, clerks_end_id), "ward_clerks2.bulk")
    save_data(generate_regs(regs_no1, regs_no1 + regs_no2, patients_init_id, patients_end_id,
                            clerks_init_id, clerks_end_id, t1, t2), "regs2.bulk")
    save_data(generate_visits(visits_no1, visits_no1 + visits_no2, regs_no1, regs_no1 + regs_no2,
                              doctors_init_id, doctors_end_id), "visits2.bulk")