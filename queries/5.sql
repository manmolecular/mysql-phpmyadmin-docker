-- 5. Для каждого остановочного пункта найти соседние с ним. Если это первый или 
-- последний пункт, то для предыдущего или следующего пункта вывести строку 
-- "отсутствует".
-- Вывод: Предыдущий остановочный пункт, Текущий остановочный пункт, Следующий 
-- остановочный пункт

SET @curr_id = 3;
SET @undefined_val = 'Отсутствует';

-- Base
SELECT 
    IFNULL (
    (
    SELECT stop_point.name FROM stop_point
    WHERE stop_point.id = (
        SELECT MAX(stop_point.id) 
        FROM stop_point 
        WHERE stop_point.id < @curr_id)
    ), 
    @undefined_val), 

    IFNULL (
    (
        SELECT stop_point.name FROM stop_point
        WHERE stop_point.id = @curr_id
    ), 
    @undefined_val),

    IFNULL (
    (
        SELECT stop_point.name FROM stop_point
        WHERE stop_point.id = (
            SELECT MIN(stop_point.id) 
            FROM stop_point 
            WHERE stop_point.id > @curr_id)
    ), 
    @undefined_val)