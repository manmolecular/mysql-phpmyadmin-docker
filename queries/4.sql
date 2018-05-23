-- 4. Найти остановочные пункты, которые принадлежат единственному маршруту
-- Вывод: Называние остановки

SELECT stop_point.name, count(schedule.route_id) FROM stop_point
    INNER JOIN schedule ON schedule.stop_point_id = stop_point.id 

WHERE schedule.stop_point_id != 0

GROUP BY stop_point.id
HAVING COUNT(schedule.route_id) = 1;