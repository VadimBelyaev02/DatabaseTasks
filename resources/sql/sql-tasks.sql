/*
 --Вывести к каждому самолету класс обслуживания и количество мест этого класса
 */
select a.model, a.aircraft_code, s.fare_conditions, count(s.seat_no)
from bookings.aircrafts a
         inner join bookings.seats s on a.aircraft_code = s.aircraft_code
group by a.model, a.aircraft_code, s.fare_conditions
order by a.model, s.fare_conditions;

/*
--Найти 3 самых вместительных самолета (модель + кол-во мест)
 */
select model, count(seat_no)
from bookings.aircrafts_data
         join bookings.seats on bookings.aircrafts_data.aircraft_code = seats.aircraft_code
group by aircrafts_data.aircraft_code, fare_conditions
order by count(seat_no) desc limit 3

/*
--Вывести код,модель самолета и места не эконом класса для самолета 'Аэробус A321-200'
с сортировкой по местам
 */
select aircrafts_data.aircraft_code, model, seat_no
from bookings.aircrafts_data
         join bookings.seats on bookings.aircrafts_data.aircraft_code = seats.aircraft_code
where fare_conditions = 'Аэробус A321-200'
  and seats.fare_conditions != 'Economy'
order by seat_no;

/*
-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация */
select city, airport_code, airport_name
from bookings.airports_data a1
where (select count(city) from bookings.airports_data a2 where a1.city = a2.city) > 1
group by airport_code, airport_name, city 5)
select flight_no
from flights_v
where departure_city = 'Екатеринбург'
  and arrival_city = 'Москва'
  and status in ('Scheduled', 'On time', 'Delayed')
order by scheduled_departure limit 1

/*
--Вывести самый дешевый и дорогой билет и стоимость ( в одном результирующем ответе)
*/
select ticket_no, amount
from bookings.ticket_flights
where amount in (select max(amount)
                 from bookings.ticket_flights
                 union
                 select min(amount)
                 from bookings.ticket_flights)

/*
-- Написать DDL таблицы Customers , должны быть поля id , firstName, LastName, email , phone.
Добавить ограничения на поля ( constraints) .
 */
create table customers
(
    id         uuid primary key,
    first_name varchar(30) not null,
    last_name  varchar(30) not null,
    email      varchar(30) not null,
    phone      varchar(30) not null
)

/*
	– Написать DDL таблицы Orders , должен быть id, customerId,	quantity.
	Должен быть внешний ключ на таблицу customers + ограничения
 */
create table orders
(
    id          uuid primary key,
    customer_id uuid references customers (id),
    quantity    int not null unique
)

/*
-- Написать 1 insert в эти таблицы
 */
insert into customers(id, first_name, last_name, email, phone)
values ('b6a8c2a3-1f4b-4e2a-8e07-8c99a02e2091', 'Name', 'Surname', 'randomemail@gmail.com', '+6663629')
insert into orders(id, customer_id, quantity)
values ('f6a8c2a3-1f4b-4e2a-8e07-8c99a02e2091', 'b6a8c2a3-1f4b-4e2a-8e07-8c99a02e2091', 5)

/*
-- удалить таблицы
 */
drop table orders
drop table customers