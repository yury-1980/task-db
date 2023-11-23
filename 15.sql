-- Написать DDL таблицы Orders, должен быть id, customerId, quantity.
-- Должен быть внешний ключ на таблицу customers + constraints
create table if not exists bookings.orders
(
    id          serial
        primary key,
    customer_id integer not null
        unique
        constraint orders_customers_id_fk
            references bookings.customers,
    quantity    integer not null
);

alter table bookings.orders
    owner to postgres;