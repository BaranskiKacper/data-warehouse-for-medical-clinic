from random import randrange
from datetime import timedelta
from datetime import datetime
import random

MORNING_CHANCE = 25
MONDAY_CHANCE = 20
AUTUMN_CHANCE = 60
REMOTE_CHANCE = 70

used_dates = []
used_regs = []
used_docs = []
used_durations = []


def random_visit_date(reg_date, doc_spec, reg_id, doc_id):
    opening_hour = reg_date.replace(hour=6, minute=0, second=0, microsecond=0)
    closing_hour = reg_date.replace(hour=18, minute=0, second=0, microsecond=0)
    int_delta = 365 * 24 * 60 * 60  # we will wait no longer than one year

    # if we decide to visit a family doctor, we will wait no longer than one day
    if doc_spec == 'FAMILY DOCTOR':
        int_delta = 24 * 60 * 60

    is_running = True
    while is_running:
        is_invalid_date = False
        random_second = randrange(int_delta)
        visit_date = reg_date + timedelta(seconds=random_second)

        # Więcej wizyt w godzinach porannych
        daytime_coef = random.randint(1, 100)
        if daytime_coef <= MORNING_CHANCE:
            tmp_date = visit_date
            visit_date = visit_date.replace(hour=random.randint(6, 7),
                                            minute=random.randint(0, 59), second=random.randint(0, 59))
            if visit_date <= reg_date:
                visit_date = tmp_date

        # Więcej wizyt w poniedziałki
        if doc_spec != 'FAMILY DOCTOR':
            weekday_coef = random.randint(1, 100)
            if weekday_coef <= MONDAY_CHANCE:
                visit_date = onDay(visit_date, 0)

        # Więcej wizyt w sezonie jesienno-zimowym
        if doc_spec != 'FAMILY DOCTOR':
            season_coef = random.randint(1, 100)
            if season_coef <= AUTUMN_CHANCE:
                visit_date = visit_date.replace(month=random.randint(9, 12), day=random.randint(1, 30))

        visit_duration = random.randint(5, 30)
        if datetime.time(opening_hour) <= datetime.time(visit_date) <= datetime.time(closing_hour):
            i = 0
            for date in used_dates:
                if (visit_date <= date <= visit_date + timedelta(minutes=visit_duration)
                    or date <= visit_date <= date + timedelta(minutes=used_durations[i])) \
                        and (reg_id == used_regs[i] or doc_id == used_docs[i]):
                    is_invalid_date = True
                    break
                i += 1
            if not is_invalid_date:
                is_running = False

    used_dates.append(visit_date)
    used_regs.append(reg_id)
    used_docs.append(doc_id)
    used_durations.append(visit_duration)

    return visit_date, visit_duration


def random_date(start, end):
    opening_hour = start.replace(hour=6, minute=0, second=0, microsecond=0)
    closing_hour = start.replace(hour=18, minute=0, second=0, microsecond=0)
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    while True:
        random_second = randrange(int_delta)
        reg_date = start + timedelta(seconds=random_second)
        if datetime.time(opening_hour) <= datetime.time(reg_date) <= datetime.time(closing_hour):
            break
    return reg_date


def save_data(data, path):
    text_file = open("sql/" + path, "w")
    text_file.write(data)
    text_file.close()


def onDay(date, day):
    days = (day - date.weekday() + 7) % 7
    return date + timedelta(days=days)
