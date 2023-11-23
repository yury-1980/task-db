-- Найти последние 10 билетов, купленные в бизнес-классе (fare_conditions = 'Business'),
-- с указанием имени пассажира и контактных данных
SELECT t.ticket_no, fare_conditions fare, b.book_date, t.passenger_name, t.contact_data
FROM ticket_flights
         LEFT JOIN tickets t on t.ticket_no = ticket_flights.ticket_no
         LEFT JOIN bookings b on b.book_ref = t.book_ref
WHERE fare_conditions = 'Business'
ORDER BY b.book_date DESC
LIMIT 10;