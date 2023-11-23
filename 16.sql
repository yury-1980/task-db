-- Написать 5 insert в эти таблицы
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



