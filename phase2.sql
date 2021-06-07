drop table if exists patient cascade;
drop table if exists hospital cascade;
drop table if exists searches cascade;
drop table if exists department cascade;
drop table if exists doctor cascade;
drop table if exists request_maintenance cascade;
drop table if exists staff cascade;
drop table if exists schedules cascade;
drop table if exists appointment cascade;
drop table if exists has cascade;
drop table if exists past cascade;
drop table if exists active cascade;
drop table if exists available cascade;
drop table if exists waitlist cascade;

--patient searches hospital:
create table patient (name varchar(30), patient_id integer NOT NULL, gender varchar(30), num_of_appointments integer, age integer, address varchar(30), primary key(patient_id));

create table hospital (name varchar(30), hospital_id integer NOT NULL, primary key(hospital_id));

create table appointment (appnt_id integer NOT NULL, date varchar(30), time_slot integer, primary key(appnt_id));

create table searches (patient_id integer NOT NULL, hospital_id integer NOT NULL, appnt_id integer NOT NULL, primary key(patient_id, hospital_id, appnt_id), foreign key(patient_id) references patient(patient_id), foreign key(hospital_id) references hospital(hospital_id), foreign key(appnt_id) references appointment(appnt_id));

--hospital includes department
create table department(name varchar(30), dept_id integer NOT NULL, primary key(dept_id), foreign key(hospital_id) references hospital(hospital_id));

--doctor works_dept department
create table doctor (name varchar(30), doctor_id integer NOT NULL, specialty varchar(30), primary key(doctor_id), foreign key(dept_id) references department(dept_id));

--doctor request maintenance staff --check time slot attribute !!!!!!!!!!!!!!!!!!
create table staff (name varchar(30), staff_id integer NOT NULL, primary key(staff_id), foreign key(hospital_id) references hospital(hospital_id));

create table request_maintenance (doctor_id integer NOT NULL, staff_id integer NOT NULL, patients_per_hour integer, dept_name varchar(30), time_slot integer, primary key(doctor_id, staff_id), foreign key(doctor_id) references doctor(doctor_id), foreign key(staff_id) references staff(staff_id));

--staff works_in hospital
--all i have to do is add foreign key in staff that refrences hospital

--staff schedules appointment -- check time slot and date attribute!!!!!!!!!!!!!

create table schedules (staff_id integer NOT NULL, appnt_id integer NOT NULL, primary key(staff_id, appnt_id), foreign key(staff_id) references staff(staff_id), foreign key(appnt_id) references appointment(appnt_id));

--appointment has doctor
create table has (appnt_id integer NOT NULL, doctor_id integer NOT NULL, primary key(appnt_id, doctor_id), foreign key(appnt_id) references appointment(appnt_id), foreign key(doctor_id) references doctor(doctor_id));

--patient serches appointment
--need to add to the searches table a new primary and foreign key

--appointment is a relationship with past active available and waitlist --this website could help but idk: https://dba.stackexchange.com/questions/5501/how-do-i-map-an-is-a-relationship-into-a-database
create table past (appnt_id integer NOT NULL, primary key(appnt_id), foreign key(appnt_id) references appointment(appnt_id));

create table active (appnt_id integer NOT NULL, primary key(appnt_id), foreign key(appnt_id) references appointment(appnt_id));

create table available (appnt_id integer NOT NULL, primary key(appnt_id), foreign key(appnt_id) references appointment(appnt_id));

create table waitlist (appnt_id integer NOT NULL, primary key(appnt_id), foreign key(appnt_id) references appointment(appnt_id));
