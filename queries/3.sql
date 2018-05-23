-- 3. Найти маршрут у которых больше всего остановок. Если таких маршрутов 
-- несколько, то вывести один, любой.*+Подзапросы использовать нельзя.+*
-- Вывод: Номер маршрута

SELECT route.num, count(schedule.stop_point_id) FROM route
    INNER JOIN schedule ON schedule.route_id = route.id

WHERE schedule.route_id != 0

GROUP BY route.num
ORDER BY count(schedule.stop_point_id) DESC
LIMIT 1;