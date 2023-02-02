import pandas as pd
from random_pesel import RandomPESEL
from utils import *

names = pd.read_csv('names.csv')['NAME'].tolist()
surnames = pd.read_csv('surnames.csv')['SURNAME'].tolist()
specializations = pd.read_csv('specialization.csv')['SPECIALIZATION'].tolist()

generated_doctors_specs = {}
generated_regs_dates = {}
clinics_id = []
pesel_numbers = []


def generate_people(id_init, id_end):
    id = id_init
    people = ""
    pesel = RandomPESEL()
    while id < id_end:
        psl = pesel.generate()
        if psl not in pesel_numbers:
            person = str(id) + "|"
            person += str(names[random.randint(0, len(names) - 1)]) + "|"
            person += str(surnames[random.randint(0, len(surnames) - 1)]) + "|"
            person += str(psl) + "\n"
            people += person
            pesel_numbers.append(psl)
            id += 1
    return people


def generate_doctors(id_init, id_end):
    doctors = ""
    for id in range(id_init, id_end):
        doctor = str(id) + "|"
        spec = specializations[random.randint(0, len(specializations) - 1)]
        doctor += str(spec) + "|"
        doctor += str(random.choice(clinics_id)) + "\n"
        doctors += doctor
        generated_doctors_specs[id] = spec
    return doctors


def generate_patients(id_init, id_end):
    patients = ""
    for id in range(id_init, id_end):
        patient = str(id) + "|"
        patient += str(random.randint(0, id_init)) + "\n"
        patients += patient
    return patients


def generate_ward_clerks(id_init, id_end):
    ward_clerks = ""
    for id in range(id_init, id_end):
        ward_clerk = str(id) + "|"
        ward_clerk += str(random.randint(0, 30)) + "\n"
        ward_clerks += ward_clerk
    return ward_clerks


def generate_regs(regs_init_id, regs_end_id, patients_init_id, patients_end_id, clerks_init_id, clerks_end_id, d1, d2):
    regs = ""
    for id in range(regs_init_id, regs_end_id):
        reg = str(id) + "|"
        date = random_date(d1, d2)
        reg += str(date) + "|"
        reg += str(random.randint(patients_init_id, patients_end_id)) + "|"
        reg += str(random.randint(clerks_init_id, clerks_end_id)) + "|"
        reg += str(random.randint(3, 20)) + "\n"
        regs += reg
        generated_regs_dates[id] = date
    return regs


def generate_visits(visit_init_id, visit_end_id, reg_init_id, reg_end_id, doctors_init_id, doctors_end_id):
    visits = ""
    type_of_visit = ['STATIONARY', 'REMOTE']
    for id in range(visit_init_id, visit_end_id):
        visit = str(id) + "|"
        reg_id = random.randint(reg_init_id, reg_end_id - 1)
        visit += str(reg_id) + "|"
        doc_id = random.randint(doctors_init_id, doctors_end_id - 1)
        visit += str(doc_id) + "|"
        visit += str(random.randint(1, 10)) + "|"
        visit_date, visit_duration = random_visit_date(
            generated_regs_dates[reg_id], generated_doctors_specs[doc_id], reg_id, doc_id)

        visit_type = type_of_visit[random.randint(0, 1)]
        if visit_date.weekday() == 4:  # Friday
            visit_coef = random.randint(1, 100)
            if visit_coef <= REMOTE_CHANCE:
                visit_type = 'REMOTE'
        visit += str(visit_type) + "|"

        visit += str(visit_date) + "|"
        visit += str(visit_duration) + "|"
        visit += str(random.randrange(50, 501, 25)) + "\n"
        visits += visit
    return visits


def generate_clinics(clinics_no):
    localizations = pd.read_csv('locations.csv', encoding="ISO-8859-1")
    max_clinics_no = localizations['MIASTO'].size
    if clinics_no > max_clinics_no:
        clinics_no = max_clinics_no

    id_list = list(range(0, max_clinics_no-1))

    miasta = []
    kody = []
    ulice = []
    numery = []

    for id in range(clinics_no):
        clinics_id.append(id)
        id_rand = random.choice(id_list)
        miasta.append(localizations['MIASTO'][id_rand])
        kody.append(localizations['KOD_POCZTOWY'][id_rand])
        ulice.append(localizations['ULICA'][id_rand])
        numery.append(str(localizations['NR_BUDYNKU'][id_rand]))
        id_list.remove(id_rand)

    dict = {'ID': clinics_id, 'MIASTO': miasta, 'KOD_POCZTOWY': kody, 'ULICA': ulice, 'NR_BUDYNKU': numery}
    df = pd.DataFrame(dict)
    df.to_csv('clinics.csv')
    read_file = pd.read_csv('clinics.csv')
    return read_file


def clear_storages():
    generated_regs_dates.clear()
    used_dates.clear()
    used_regs.clear()
    used_docs.clear()
    used_durations.clear()
