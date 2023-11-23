-- Вывести города, в которых больше 1 аэропорта (код аэропорта, аэропорт, город)
SELECT airport_code, airport_name, city
FROM airports_data
WHERE city IN (
    SELECT city
    FROM airports_data
    GROUP BY city
    HAVING COUNT(airport_code) > 1
);
