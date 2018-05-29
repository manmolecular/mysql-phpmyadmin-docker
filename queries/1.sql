-- 1. Требуется найти водителей, для которых выполнены все следующие условия
-- а) Поставили подпись в путевом листе более года назад
-- б) Прикреплены к автобусу с номером Томского региона
-- в) Работают с кассиром-кондуктором на одном автобусе, причём 
-- кассир-кондуктор из другого Транспортного депо.

SELECT DISTINCT bus_driver.name FROM bus_driver
    INNER JOIN bus ON bus.driver_id = bus_driver.id
    INNER JOIN bus_checker ON bus_checker.id = bus.checker_id

WHERE bus_driver.sign_date <= (curdate() - interval 1 year)

HAVING  SUM(bus.num_region = 70) > 0 AND
        SUM(bus_driver.trans_depo_id != bus_checker.trans_depo_id) > 0;