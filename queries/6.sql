-- 6. Найти все маршруты для которых или есть более 10 остановочных пунктов 
-- или есть водители, не отмечавшиеся в путевых листах за последние полгода 
-- Допустимый уровень подзапросов - нулевой. Функции if(), ifnull() 
-- использовать нельзя.
-- Вывод: Номер маршрута, Количество остановочных пунктов

SELECT route.num, COUNT(schedule.stop_point_id) FROM route
    INNER JOIN schedule ON schedule.route_id = route.id 
    INNER JOIN bus ON bus.route_id = route.id
    INNER JOIN bus_driver ON bus_driver.id = bus.driver_id

WHERE schedule.route_id IS NOT NULL
GROUP BY route.num
HAVING COUNT(schedule.stop_point_id) > 10
    OR SUM(bus_driver.sign_date <= (curdate() - interval 6 month)) > 0