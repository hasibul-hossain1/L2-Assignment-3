-- users table
create table users (
  user_id serial primary key,
  name varchar(50),
  email varchar(100) unique,
  password text,
  phone varchar(20),
  role varchar(10) check (role in ('Customer', 'Admin'))
)
-- vehicles table
create table vehicles (
  vehicle_id serial primary key,
  name varchar(100),
  type varchar(10) check (type in ('car', 'bike', 'truck')),
  model int,
  registration_number varchar(50) unique,
  rental_price int,
  status varchar(50) check (status in ('available', 'rented', 'maintenance'))
)
-- bookings table
create table bookings (
  booking_id serial primary key,
  user_id int,
  vehicle_id int,
  start_date date,
  end_date date,
  status varchar(50) check (
    status in ('completed', 'confirmed', 'pending', 'cancelled')
  ),
  total_cost int,
  constraint fk_user foreign key (user_id) references users (user_id),
  constraint fk_vehicle foreign key (vehicle_id) references vehicles (vehicle_id)
)
-- insert into users
insert into
  users (name, email, phone, role)
values
  (
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  ('Bob', 'bob@example.com', '0987654321', 'Admin'),
  (
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  )
  -- insert into vehicles
insert into
  vehicles (
    name,
    type,
    model,
    registration_number,
    rental_price,
    status
  )
values
  (
    'Toyota Corolla',
    'car',
    2022,
    'ABC-123',
    50,
    'available'
  ),
  (
    'Honda Civic',
    'car',
    2021,
    'DEF-456',
    60,
    'rented'
  ),
  (
    'Yamaha R15',
    'bike',
    2023,
    'GHI-789',
    30,
    'available'
  ),
  (
    'Ford F-150',
    'truck',
    2020,
    'JKL-012',
    100,
    'maintenance'
  );

-- insert into bookings
insert into
  bookings (
    user_id,
    vehicle_id,
    start_date,
    end_date,
    status,
    total_cost
  )
values
  (
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240
  ),
  (
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120
  ),
  (3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
  (1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

-- join query
select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  bookings as b
  join users as u on b.booking_id = u.user_id
  join vehicles as v on b.vehicle_id = b.booking_id
  -- exists query
select
  *
from
  vehicles as v
where
  not exists (
    select
      *
    from
      bookings as b
    where
      v.vehicle_id = b.vehicle_id
  )
  --where query
select
  *
from
  vehicles
where
  status = 'available'
  and type = 'car'
  -- having query
select
  v.name as vehicle_name,
  count(*) as total_bookings
from
  vehicles as v
  join bookings as b on v.vehicle_id = b.vehicle_id
group by
  v.name
having
  count(*) > 2;