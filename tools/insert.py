#!/usr/bin/env python3
import json
import pymysql
import pymysql.cursors

bus_park_values = [
    ('Автобусный парк №1 им. Ленина', 100), 
    ('Автобусный парк №2 им. Сталина', 50), 
    ('Автобусный парк №3 им. Горького', 10)]

waybill_values = [
    (235, '2018-01-01 12:00:00'),
    (120, '2017-01-01 12:00:00')]

route_values = [2, 3, 4, 12, 23, 31, 60]

repair_shop_values = [
    ('Автомастерская №1 им. Ленина', 100), 
    ('Автомастерская №2 им. Сталина', 50), 
    ('Автомастерская №3 им. Горького', 10)]

stop_point_values = ['пл. Ленина', 'Кинотеатр Горького', 'Главпочтамт',
    'Новособорная', 'ТГУ', 'Библиотека']

schedule_values = [
    ('09:35:00', 1, 1),
    ('09:40:00', 1, 2),
    ('09:42:00', 1, 3),
    ('09:48:00', 2, 1),
    ('10:15:00', 2, 2),
    ('13:00:00', 3, 3)]

trans_depo_values = [
    ('Сидоров Аким Владимирович', 'Ул. Сталеваров, 12', 
        'Автобусное Депо №1 им. Ленина', 1, 1, 1),
    ('Захаров Макар Игоревич', 'Ул. Машиностроителей, 34а', 
        'Автобусное Депо №2 им. Сталина', 2, 2, 2)]

bus_drivers_values = [
    ('Соловьёв Ювеналий Геннадьевич', '2017-01-01', 1, 1),
    ('Соколов Никита Егорович', '2015-01-01', 2, 2),
    ('Иванов Евгений Евгеньиевич', '2018-04-20', 1, 1)]

bus_checkers_values = [
    ('Лебедева Ольга Николаевна ', 1),
    ('Фомина Клара Алексеевна ', 2)]

buses_values = [
    (762, 70, 1, 2, 1, 1),
    (145, 94, 2, 1, 2, 2)]

def main():
    connection = pymysql.connect(
        host='127.0.0.1',
        user='root',
        port=3306,
        password='rootpass',
        db='depo',
        autocommit=True,
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor,
        unix_socket=False)

    with connection.cursor() as cursor:
        try:
            for park in bus_park_values:
                cursor.execute(
                    "INSERT IGNORE INTO bus_park (place, max_count) \
                    VALUES (%s, %s)", 
                    (park[0], park[1]))
            for waybill in waybill_values:
                cursor.execute(
                    "INSERT IGNORE INTO waybill (num, issue_date) \
                    VALUES (%s, %s)", 
                    (waybill[0], waybill[1]))
            for route in route_values:
                cursor.execute(
                    "INSERT IGNORE INTO route (num) VALUES (%s)", 
                    (route))
            for repair in repair_shop_values:
                cursor.execute(
                    "INSERT IGNORE INTO repair_shop (place, max_count) \
                    VALUES (%s, %s)", 
                    (repair[0], repair[1]))
            for stop_point in stop_point_values:
                cursor.execute(
                    "INSERT IGNORE INTO stop_point (name) VALUES (%s) \
                    ON DUPLICATE KEY UPDATE name=name", 
                    (stop_point))
            for schedule in schedule_values:
                cursor.execute(
                    "INSERT IGNORE INTO schedule (schedule_time, \
                    route_id, stop_point_id) VALUES (%s, %s, %s)", 
                    (schedule[0], schedule[1], schedule[2]))
            for trans_depo in trans_depo_values:
                cursor.execute(
                    "INSERT IGNORE INTO trans_depo \
                    (director, place, name, waybill_id, bus_park_id, \
                    repair_shop_id) VALUES (%s, %s, %s, %s, %s, %s)", 
                    (trans_depo[0], trans_depo[1], trans_depo[2],
                        trans_depo[3], trans_depo[4], trans_depo[5]))
            for driver in bus_drivers_values:
                cursor.execute(
                    "INSERT IGNORE INTO bus_driver (name, sign_date, \
                    trans_depo_id, waybill_id) VALUES (%s, %s, %s, %s)", 
                    (driver[0], driver[1], driver[2], driver[3]))
            for checker in bus_checkers_values:
                cursor.execute(
                    "INSERT IGNORE INTO bus_checker (name, trans_depo_id) \
                    VALUES (%s, %s)", 
                    (checker[0], checker[1]))
            for bus in buses_values:
                cursor.execute(
                    "INSERT IGNORE INTO bus (num, num_region, driver_id, checker_id, \
                    bus_park_id, route_id) VALUES (%s, %s, %s, %s, %s, %s)",
                    (bus[0], bus[1], bus[2], bus[3], bus[4], bus[5]))
        except pymysql.MySQLError as e:
            print('Error: ' + str(e))

if __name__ == "__main__":
    main()