-- Найти все рейсы, у которых нет забронированных мест в бизнес-классе (fare_conditions = 'Business')
SELECT f.flight_no, s.seat_no, bp.seat_no
FROM flights f
         RIGHT JOIN seats s on f.aircraft_code = s.aircraft_code
         LEFT JOIN boarding_passes bp on s.seat_no = bp.seat_no
WHERE s.fare_conditions = 'Business'
  AND bp.seat_no is null