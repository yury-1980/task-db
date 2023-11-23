-- 1. Вывести к каждому самолету класс обслуживания и количество мест этого класса
select model, fare_conditions, count(s) as count
from aircrafts_data
         join seats s on aircrafts_data.aircraft_code = s.aircraft_code
group by model, fare_conditions;

-- 2. Найти 3 самых вместительных самолета (модель + кол-во мест)
select model, count(s) as count
from aircrafts_data
         join seats s on aircrafts_data.aircraft_code = s.aircraft_code
group by model
order by count desc
limit 3;

-- 3. Найти все рейсы, которые задерживались более 2 часов
SELECT actual_departure,
       scheduled_departure,
       extract(hours FROM age(actual_departure, scheduled_departure))   hours_difference,
       extract(minutes FROM age(actual_departure, scheduled_departure)) minutes_difference
FROM flights
WHERE age(actual_departure, scheduled_departure) > INTERVAL '2 hours';

-- 4. Найти последние 10 билетов, купленные в бизнес-классе (fare_conditions = 'Business'),
-- с указанием имени пассажира и контактных данных
SELECT t.ticket_no, fare_conditions fare, b.book_date, t.passenger_name, t.contact_data
FROM ticket_flights
         LEFT JOIN tickets t on t.ticket_no = ticket_flights.ticket_no
         LEFT JOIN bookings b on b.book_ref = t.book_ref
WHERE fare_conditions = 'Business'
ORDER BY b.book_date DESC
LIMIT 10;

-- 5. Найти все рейсы, у которых нет забронированных мест в бизнес-классе (fare_conditions = 'Business')
SELECT f.flight_no, s.seat_no, bp.seat_no
FROM flights f
         RIGHT JOIN seats s on f.aircraft_code = s.aircraft_code
         LEFT JOIN boarding_passes bp on s.seat_no = bp.seat_no
WHERE s.fare_conditions = 'Business'
  AND bp.seat_no is null;

-- 6. Получить список аэропортов (airport_name) и городов (city), в которых есть рейсы с задержкой
SELECT ad.airport_name,
       ad.city
FROM flights
         join airports_data ad
              on ad.airport_code = flights.departure_airport or ad.airport_code = flights.arrival_airport
WHERE actual_departure > scheduled_departure
   OR actual_arrival > scheduled_arrival;

-- 7. Получить список аэропортов (airport_name) и количество рейсов, вылетающих из каждого аэропорта,
-- отсортированный по убыванию количества рейсов
SELECT ad.airport_name, f.flight_no, count(flight_no) count
FROM airports_data ad
         join flights f on ad.airport_code = f.departure_airport
group by ad.airport_name, f.flight_no
ORDER BY count DESC;

-- 8. Найти все рейсы, у которых запланированное время прибытия (scheduled_arrival) было изменено и новое время прибытия
-- (actual_arrival) не совпадает с запланированным
SELECT flight_no
FROM flights
WHERE scheduled_arrival != actual_arrival;

-- 9. Вывести код, модель самолета и места не эконом класса для самолета "Аэробус A321-200" с сортировкой по местам
SELECT ad.aircraft_code, ad.model, s.seat_no, s.fare_conditions
FROM seats s
         LEFT OUTER JOIN aircrafts_data ad on ad.aircraft_code = s.aircraft_code
WHERE s.fare_conditions != 'Economy'
  AND ad.model ->> 'ru' = 'Аэробус A321-200';

-- 10. Вывести города, в которых больше 1 аэропорта (код аэропорта, аэропорт, город)
SELECT airport_code, airport_name, city
FROM airports_data
WHERE city IN (SELECT city
               FROM airports_data
               GROUP BY city
               HAVING COUNT(airport_code) > 1);

-- 11. Найти пассажиров, у которых суммарная стоимость бронирований превышает среднюю сумму всех бронирований
SELECT t.passenger_name, b.total_amount
FROM bookings b
         join tickets t on b.book_ref = t.book_ref
WHERE b.total_amount > (SELECT AVG(total_amount) FROM bookings);

-- 12. Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация
SELECT flight_no, f.scheduled_departure
FROM flights f
WHERE (f.departure_airport = 'SVX' AND f.arrival_airport IN (SELECT ad.airport_code
                                                             FROM airports_data ad
                                                             WHERE ad.city ->> 'ru' = 'Екатеринбург'
                                                                OR ad.city ->> 'ru' = 'Москва'))
  AND (f.status IN ('Scheduled', 'Delayed', 'On Time'))
ORDER BY f.scheduled_departure
LIMIT 1;

-- 13. Вывести самый дешевый и дорогой билет и стоимость (в одном результирующем ответе)
(SELECT tf.ticket_no, tf.amount
 FROM ticket_flights tf
 ORDER BY tf.amount
 LIMIT 1)
UNION ALL
(SELECT tf.ticket_no, tf.amount
 FROM ticket_flights tf
 ORDER BY tf.amount DESC
 LIMIT 1);

-- 14. Написать DDL таблицы Customers, должны быть поля id, firstName, LastName, email, phone.
-- Добавить ограничения на поля (constraints)
create table if not exists bookings.customers
(
    id         serial
        primary key,
    first_name varchar     not null,
    last_name  varchar     not null,
    email      varchar     not null
        unique,
    phone      varchar(12) not null
        unique
);

alter table bookings.customers
    owner to postgres;

-- 15. Написать DDL таблицы Orders, должен быть id, customerId, quantity.
-- Должен быть внешний ключ на таблицу customers + constraints
create table if not exists bookings.orders
(
    id          serial
        primary key,
    customer_id integer not null
        unique
        constraint orders_customers_id_fk
            references bookings.customers
            ON UPDATE CASCADE
            ON DELETE RESTRICT,
    quantity    integer not null
);

alter table bookings.orders
    owner to postgres;

-- 16. Написать 5 insert в эти таблицы
INSERT INTO bookings.customers (first_name, last_name, email, phone)
VALUES ('Иван', 'Иванов', '45@mail.ru', '375441234567'),
       ('Пётр', 'Петров', '78@mail.ru', '375291234567'),
       ('Василий', 'Васильев', '12@mail.ru', '375251234567'),
       ('Николай', 'Николаев', '46@mail.ru', '375257654321'),
       ('Николай', 'Гоголь', '65@mail.ru', '375297654321');


INSERT INTO bookings.orders (customer_id, quantity)
VALUES (1, 78),
       (2, 45),
       (3, 32),
       (4, 89),
       (5, 58);

-- 17. Удалить таблицы.
DROP TABLE orders;
DROP TABLE customers;