# 2. Привести помесячный расчёт количеств водителей, отметившихся в путевом 
# листе (потребуется добавить дополнительный атрибут "Дата подписи" в связь 
# "Отмечается". Подзапросы использовать нельзя.
# Вывод: Год, Месяц, Количество ознакомившихся с путевым листом.

SELECT YEAR(bus_driver.sign_date), MONTH(bus_driver.sign_date), 
count(bus_driver.id) FROM bus_driver

WHERE bus_driver.sign_date != 0

GROUP BY bus_driver.sign_date