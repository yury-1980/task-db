-- Вывести самый дешевый и дорогой билет и стоимость (в одном результирующем ответе)
(SELECT tf.ticket_no, tf.amount
 FROM ticket_flights tf
 ORDER BY tf.amount
 LIMIT 1)
UNION ALL
(SELECT tf.ticket_no, tf.amount
 FROM ticket_flights tf
 ORDER BY tf.amount DESC
 LIMIT 1);
