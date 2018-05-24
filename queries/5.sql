-- 5. Для каждого остановочного пункта найти соседние с ним. Если это первый или 
-- последний пункт, то для предыдущего или следующего пункта вывести строку 
-- "отсутствует".
-- Вывод: Предыдущий остановочный пункт, Текущий остановочный пункт, Следующий 
-- остановочный пункт

-- Base
SELECT 
    stop_point.id AS cur,
    IFNULL (
    (
    SELECT stop_point.name FROM stop_point
    WHERE stop_point.id = (
        SELECT MAX(stop_point.id) 
        FROM stop_point 
        WHERE stop_point.id < cur
        LIMIT 1
        )
    ), 
    'Отсутствует'), 

    (
        SELECT stop_point.name FROM stop_point
        WHERE stop_point.id = cur
        LIMIT 1
    ),

    IFNULL (
    (
        SELECT stop_point.name FROM stop_point
        WHERE stop_point.id = (
            SELECT MIN(stop_point.id) 
            FROM stop_point 
            WHERE stop_point.id > cur
            LIMIT 1
            )
    ), 
    'Отсутствует')
from stop_point 