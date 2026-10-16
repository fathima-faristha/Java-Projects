create database HMS;
use HMS;

CREATE TABLE roles (
	role_id INT PRIMARY KEY identity(1,1),
	role VARCHAR(50) NOT NULL);

CREATE TABLE users (
	user_id INT PRIMARY KEY identity(1,1),
	username VARCHAR(50) UNIQUE NOT NULL,
	email varchar(100) unique not null,
	password VARCHAR(255) NOT NULL,
	role_id INT,
	FOREIGN KEY (role_id) REFERENCES roles(role_id));


CREATE TABLE patients (
	patient_id INT PRIMARY KEY identity(1,1),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	date_of_birth DATE,
	gender VARCHAR(10),
	phone_number VARCHAR(20),
	email varchar(50),
	Address varchar(200),
	Emergency_contact int);

CREATE TABLE doctors (
	doctor_id INT PRIMARY KEY identity(1,1),
	user_id int,
	doctor_name varchar(20),
	specialization VARCHAR(100),
	phone int,
	email varchar(30),
	FOREIGN KEY(user_id) REFERENCES users(user_id)); 

CREATE TABLE appointments (
	appointment_id INT PRIMARY KEY identity(1,1),
	patient_id INT,
	patient_name varchar(100),
	doctor_name varchar(100),
	appointment_date DATE,
	appointment_time TIME,
	status VARCHAR(20),
	notes varchar(100),
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id));
	select * from appointments;

CREATE TABLE EMR (
	record_id INT PRIMARY KEY identity(1,1),
	patient_id INT,
	patient_name varchar(100),
	doctor_id INT,
	doctor_name varchar(100),
	record_date DATE,
	diagnosis varchar(100),
	treatment varchar(100),
	medical_history varchar(100),
	allergies varchar(100),
	follow_up_date date,
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id));
	
	USE eden;
ALTER TABLE EMR DROP CONSTRAINT FK_EMRdoctor_id_32E0915F;

CREATE TABLE prescriptions (
	prescription_id INT PRIMARY KEY identity(1,1),
	record_id INT,
	medicine_name VARCHAR(100),
	dosage VARCHAR(50),
	duration VARCHAR(50),
	FOREIGN KEY (record_id) REFERENCES EMR(record_id));

CREATE TABLE bills (
	bill_id INT PRIMARY KEY identity(1,1),
	patient_id INT,
	total_amount DECIMAL(10,2),
	payment_status VARCHAR(20),
	bill_date DATE,
	FOREIGN KEY (patient_id) REFERENCES patients(patient_id));
	alter table bills add patient_name varchar(20);
	alter table bills add grand_total varchar(20);

CREATE TABLE inventory(
	item_id INT primary key identity(1,1),
	item_name varchar(100),
	quantity int,
	unit_price int,
	expiry_date date);

CREATE TABLE lab_tests(
	test_id int primary key identity(1,1),
	patient_id int,
	doctor_id int,
	test_name varchar(50),
	results varchar(100),
	Foreign key (patient_id) references patients(patient_id));


CREATE TABLE payments(
	payment_id int primary key identity(1,1),
	bill_id int,
	amount decimal(10,2),
	payment_date date,
	payment_mode varchar(50),
	foreign key(bill_id) references bills(bill_id)); 


USE EDEN;
ALTER TABLE EMR ALTER COLUMN treatment varchar(200);
ALTER TABLE EMR ALTER COLUMN doctor_name varchar(100);
ALTER TABLE EMR ALTER COLUMN diagnosis varchar(200);
ALTER TABLE EMR ALTER COLUMN patient_name varchar(100);
ALTER TABLE EMR ALTER COLUMN medical_history varchar(500);
ALTER TABLE EMR ALTER COLUMN allergies varchar(200);

SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('EMR');

ALTER TABLE EMR DROP CONSTRAINT FK_EMRdoctor_id_32E0915F;

DECLARE @sql NVARCHAR(200)
SELECT @sql = 'ALTER TABLE EMR DROP CONSTRAINT ' + name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('EMR') 
AND referenced_object_id = OBJECT_ID('doctors')
EXEC(@sql)

SELECT * FROM EMR;

CREATE TABLE departments (
    department_id INT PRIMARY KEY IDENTITY(1,1),
    department_name VARCHAR(100) NOT NULL,
    description VARCHAR(200)
);

ALTER TABLE doctors ADD department_id INT;
ALTER TABLE doctors ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE doctors ADD department_id INT;
ALTER TABLE doctors ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE doctors ALTER COLUMN phone VARCHAR(20);
Alter table doctors alter column doctor_name varchar(100);
ALTER TABLE patients ALTER COLUMN Emergency_contact VARCHAR(20);

use eden;
	CREATE TABLE staff (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    staff_name VARCHAR(100) NOT NULL,
    role_title VARCHAR(50),      
	department varchar(40),
    phone VARCHAR(20),
    email VARCHAR(50),
    hire_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


	CREATE TABLE doctor_schedules (
    schedule_id INT PRIMARY KEY IDENTITY(1,1),
    doctor_id INT,
    day_of_week VARCHAR(10),       
    start_time TIME,
    end_time TIME,
    slot_duration_minutes INT DEFAULT 30,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

ALTER TABLE appointments ADD doctor_id INT;
ALTER TABLE appointments ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
ALTER TABLE appointments ADD duration_minutes INT DEFAULT 30;
ALTER TABLE appointments ADD room_number VARCHAR(20);

	CREATE TABLE bill_items (
    bill_item_id INT PRIMARY KEY IDENTITY(1,1),
    bill_id INT,
    item_description VARCHAR(100),  
    item_type VARCHAR(50),          
    reference_id INT,               
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2),
    amount DECIMAL(10,2),
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
);

	CREATE TABLE insurance (
    insurance_id INT PRIMARY KEY IDENTITY(1,1),
    patient_id INT,
    provider_name VARCHAR(100),
    policy_number VARCHAR(50),
    coverage_amount DECIMAL(10,2),
    valid_until DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

	CREATE TABLE pharmacy_dispense (
    dispense_id INT PRIMARY KEY IDENTITY(1,1),
    prescription_id INT,
    item_id INT,                    
    quantity_dispensed INT,
    dispense_date DATE,
    dispensed_by INT,               
    FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id),
    FOREIGN KEY (item_id) REFERENCES inventory(item_id),
    FOREIGN KEY (dispensed_by) REFERENCES users(user_id)
);

ALTER TABLE inventory ADD category VARCHAR(50);
ALTER TABLE inventory ADD supplier VARCHAR(100);


ALTER TABLE lab_tests ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
ALTER TABLE lab_tests ADD test_date DATE;
ALTER TABLE lab_tests ADD cost DECIMAL(10,2);

	CREATE TABLE audit_log (
    log_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT,
    action VARCHAR(200),
    table_affected VARCHAR(50),
    record_id INT,
    action_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

select * from doctors;
use eden;

select * from users;
USE eden;
ALTER TABLE users DROP CONSTRAINT FK__users__role_id__276EDEB3;
ALTER TABLE users DROP COLUMN role_id;
ALTER TABLE users ADD role VARCHAR(20);

USE eden;
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'bills';
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'bill_items';
SELECT name FROM sys.tables;

select * from bills;
select * from bill_items;
delete from bills;
delete from payments;
delete from bill_items;
delete from appointments;
delete from patients;

USE eden;
DELETE FROM patients WHERE patient_id = 0;
DBCC CHECKIDENT ('patients', RESEED, 4);

select patient_id,first_name,last_name from patients;
USE eden;
DELETE FROM patients
DBCC CHECKIDENT ('patients', RESEED, 0);

select * from prescriptions;
select * from emr;

select * from pharmacy_dispense;
USE eden;
ALTER TABLE pharmacy_dispense ADD patient_id INT;
ALTER TABLE pharmacy_dispense ADD medicine_name VARCHAR(100);
ALTER TABLE pharmacy_dispense ADD quantity INT;
ALTER TABLE pharmacy_dispense ADD unit_price DECIMAL(10,2);
ALTER TABLE pharmacy_dispense ADD total_cost DECIMAL(10,2);
ALTER TABLE pharmacy_dispense ADD patient_name varchar(100);

SELECT fk.name, COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS column_name
FROM sys.foreign_key_columns fkc
JOIN sys.foreign_keys fk ON fkc.constraint_object_id = fk.object_id
WHERE fk.parent_object_id = OBJECT_ID('pharmacy_dispense');

SELECT 'ALTER TABLE pharmacy_dispense DROP CONSTRAINT ' + name + ';'
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('pharmacy_dispense');

ALTER TABLE pharmacy_dispense DROP CONSTRAINT FK__pharmacy___presc__5EBF139D;
ALTER TABLE pharmacy_dispense DROP CONSTRAINT FK__pharmacy___item___5FB337D6;
ALTER TABLE pharmacy_dispense DROP CONSTRAINT FK__pharmacy___dispe__60A75C0F;

ALTER TABLE pharmacy_dispense drop quantity_dispensed;
select top 5 * from pharmacy_dispense;

ALTER TABLE pharmacy_dispense DROP COLUMN quantity_dispensed;
ALTER TABLE pharmacy_dispense DROP COLUMN prescription_id;
ALTER TABLE pharmacy_dispense DROP COLUMN item_id;
ALTER TABLE pharmacy_dispense DROP COLUMN dispensed_by;
SELECT TOP 5 * FROM pharmacy_dispense;

select top 1* from bill_items;
alter table bill_items add patient_id int;
alter table bill_items add patient_name int;
alter table bill_items add medicine varchar(100);
alter table bill_items add total int;

alter table bill_items alter column patient_name varchar(50);

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'bill_items';
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pharmacy_dispense';
alter table bill_items add patient_id int;

select * from pharmacy_dispense;
use eden;
USE eden;
SELECT bill_item_id, patient_id, item_description, amount FROM bill_items;

select top 3 * from bills;

USE eden;
ALTER TABLE appointments ADD status VARCHAR(20) DEFAULT 'Pending';
UPDATE appointments SET status = 'Pending' WHERE status IS NULL;

select * from appointments;