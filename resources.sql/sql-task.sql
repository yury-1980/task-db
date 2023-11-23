-- Вывести к каждому самолету класс обслуживания и количество мест этого класса
select model, fare_conditions, count(s) as count
from aircrafts_data
         join seats s on aircrafts_data.aircraft_code = s.aircraft_code
group by model, fare_conditions;

