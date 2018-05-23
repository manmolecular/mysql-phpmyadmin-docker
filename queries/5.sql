-- 5. Для каждого остановочного пункта найти соседние с ним. Если это первый или 
-- последний пункт, то для предыдущего или следующего пункта вывести строку 
-- "отсутствует".
-- Вывод: Предыдущий остановочный пункт, Текущий остановочный пункт, Следующий 
-- остановочный пункт

SELECT IFNULL( (SELECT field1 FROM table WHERE id = 123 LIMIT 1) ,'not found');

SET @curr_id = 3;

SELECT stop_point.id, stop_point.name FROM stop_point
where stop_point.id = @curr_id
      OR stop_point.id = (
        SELECT MAX(stop_point.id) FROM stop_point 
        WHERE stop_point.id < @curr_id)
      OR stop_point.id = (
        SELECT MIN(stop_point.id) FROM stop_point 
        WHERE stop_point.id > @curr_id)