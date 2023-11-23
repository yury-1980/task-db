-- Написать DDL таблицы Customers, должны быть поля id, firstName, LastName, email, phone.
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

