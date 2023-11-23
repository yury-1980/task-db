-- Найти пассажиров, у которых суммарная стоимость бронирований превышает среднюю сумму всех бронирований
SELECT t.passenger_name, b.total_amount
FROM bookings b
         join tickets t on b.book_ref = t.book_ref
WHERE b.total_amount > (SELECT AVG(total_amount) FROM bookings);