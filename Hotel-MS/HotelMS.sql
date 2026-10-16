create database royal_stay;
use royal_stay;

--tables 
create table users(
user_id int primary key identity(1,1),
staff_id int null,
foreign key (staff_id) references staff(staff_id),
username varchar (50) unique not null,
first_name varchar (50),
last_name varchar (50),
role varchar (50) ,
department varchar (50),
email varchar(100),
phone_number varchar(20),
password varchar(255),
status varchar (30),
profile_picture varchar(255));

create table staff(
staff_id int primary key identity(1,1),
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
phone_number varchar(20),
email varchar(100),
address varchar (250),
department varchar (50),
position varchar (50),
hire_date date,
id_type varchar (80),
id_number varchar(80),
employee_status varchar(80),
salary decimal(12,2) 
);

create table services(
service_id int primary key identity(1,1),
service_name varchar(50),
description varchar(250),
price decimal(12,2),
status varchar(100)
);

create table room(
room_id int primary key identity(1,1),
room_number int unique,
room_type varchar(100),
floor varchar(20),
capacity int,
price_per_night decimal(12,2),
status varchar (50),
bed_type varchar(50),
has_ac 
has_tv
has_wifi
notes varchar(250)
);

create table reservations(
reservation_id int primary key identity(1,1),
guest_id int,
foreign key (guest_id) references guest(guest_id),
room_selection varchar(50),
room_id int,
foreign key (room_id) references room (room_id),
floor_number int,
Check_in_date date,
check_out_date date,
Number_of_guests int,
number_of_nights int,
room_price decimal(12,2),
total_amount decimal(12,2),
reservation_status varchar(20),
notes varchar(150)
);

create table login(
username varchar(20),
password varchar (20)
);

create table housekeeping(
taskid int primary key identity(1,1),
room_id int,
foreign key (room_id) references room(room_id),
cleaning_status varchar(30),
assigned_staff varchar(20),
Date date,
time time,
notes varchar(120));

create table guest(
guest_id int primary key identity (1,1),
reservation_id int,
first_name varchar(50),
last_name varchar(50),
gender varchar(10),
phone_number varchar(20) ,
email varchar (80),
nationality varchar (25),
address varchar (100),
id_type varchar(50),
id_number varchar (50),
notes varchar (100));

create table bills_payments(
bill_id int primary key identity (1,1),
reservation_id int,
foreign key (reservation_id) references reservations (reservation_id),
guest_name varchar (50),
room_number int,
check_in_date date,
ckeck_out_date date,
room_charges int,
extra_services int,
discount decimal (12,2),
tax int,
total_amount decimal (12,2),
payment_method varchar (80),
reference_number varchar(50),
amount_paid decimal(12,2),
balance decimal (12,2),
payment_status varchar(50),
payment_date date,
recieved_by varchar(50));

create table check_in_check_out(
reservation_id int,
guest_name varchar(50),
room_number int,
room_type varchar(30),
check_in_date date,
check_out_date date,
number_of_guests int,
expected_nights int,
notes varchar(200),
total_nights int,
room_rate int,
final_amount int,
payment_method varchar(30),
amount_paid int,
balance int);


