-- Вывести код, модель самолета и места не эконом класса для самолета "Аэробус A321-200" с сортировкой по местам
SELECT ad.aircraft_code, ad.model, s.seat_no, s.fare_conditions
FROM seats s
         LEFT OUTER JOIN aircrafts_data ad on ad.aircraft_code = s.aircraft_code
WHERE s.fare_conditions != 'Economy'
  AND ad.model ->> 'ru' = 'Аэробус A321-200';