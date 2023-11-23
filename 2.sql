-- Найти 3 самых вместительных самолета (модель + кол-во мест)
select model, count(s) as count
from aircrafts_data
         join seats s on aircrafts_data.aircraft_code = s.aircraft_code
group by model
order by count desc
limit 3