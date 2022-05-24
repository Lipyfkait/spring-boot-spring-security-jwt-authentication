create database Employee_BAse_4P1;
use Employee_BAse_4P1;

create table Employee
(
	ID_Employee int not null auto_increment primary key,
    First_Name varchar(30) not null,
    Second_Name varchar(30) not null,
    Middle_Name varchar(30) null default '-',
    Employee_Phone varchar(17) not null unique check (regexp_like(Employee_Phone, '\\+7\\([0-9]{3}\\)[0-9]{3}\\-[0-9]{2}\\-[0-9]{2}')),
    Employee_Email varchar(200) null check(Employee_Email like '%@%.%') default '@.'
);

DELIMITER //
create procedure Employee_Update (in p_ID_Employee int, in p_First_Name varchar(30), in p_Second_Name varchar(30),
in p_Middle_Name varchar(30), in p_Employee_Phone varchar(17), in p_Employee_Email varchar(200))
begin
	declare have_record int;
    select count(*) into have_record from Employee
    where First_Name = p_First_Name and Second_Name = p_Second_Name
    and Middle_Name = p_Middle_Name;
    if have_record <> 0 then
		select'Сотрудник с указаным ФИО уже есть!';
    else
		update employee set
			First_Name = p_First_Name,
            Second_Name = p_Second_Name,
            Middle_Name = p_Middle_Name,
            Employee_Phone = p_Employee_Phone,
            Employee_Email = p_Employee_Email
				where
					ID_Employees = p_ID_Employee;
    end if;
end;

DELIMITER //
create procedure Employee_Insert (in p_First_Name varchar(30), in p_Second_Name varchar(30),
in p_Middle_Name varchar(30), in p_Employee_Phone varchar(17), in p_Employee_Email varchar(200))
begin
	declare have_record int;
    select count(*) into have_record from Employee
    where First_Name = p_First_Name and Second_Name = p_Second_Name
    and Middle_Name = p_Middle_Name;
    if have_record <> 0 then
		select'Сотрудник с указаным ФИО уже есть!';
    else
		insert into employee (First_Name, Second_Name, Middle_Name, Employee_Phone,
        Employee_Email)
        values (p_First_Name, p_Second_Name, p_Middle_Name, p_Employee_Phone,
        p_Employee_Email);
    end if;
end;

DELIMITER //
create procedure Employee_Delete (in p_ID_Employee int)
begin
	declare have_record int;
    select count(*) into have_record from combination
    where Employee_ID = p_ID_Employee;
    if have_record <> 0 then
		select 'Удалить сотрудника не возможно, так как у него есть должность!';
    else
		delete from employee
			where ID_Employee = p_ID_Employee;
    end if;
end;

call Employee_Insert('Жмышенко','Альберт','Альбертович','+7(999)834-22-56','1488DED_2@mail.ru');
select * from Employee;

insert into Employee (First_Name, Second_Name, Middle_Name, Employee_Phone, Employee_Email)
values ('Жмышенко','Валерий','Альбертович','+7(999)834-22-55','1488DED@mail.ru'),
('Иванов','Иван','Иванович','+7(987)343-67-17','ivan@example.ru');

insert into Employee (First_Name, Second_Name, Employee_Phone)
values ('Попов','Иван','+7(999)237-44-67');

select * from Employee;

create table Post
(
	ID_Post int not null auto_increment primary key,
    Post_Name varchar(50) not null unique,
    Post_Price decimal(38,2) null check (Post_Price >= 0.0) default 0.0
);

insert into Post(Post_Name, Post_Price)
values ('Директор', 25000.20),
('Бухгалтер', 120000.50),
('Продавец-консультант', 55000.25);

insert into Post(Post_Name)
values ('Охранник');

select * from Post;

create table Combination
(
	ID_Combination int not null auto_increment primary key,
    Employee_ID int not null,
    Post_ID int not null,
    Date_Of_Create timestamp null default now(),
    Post_Part decimal(38,1) null check(Post_Part >= 0.0) default 0.1,
    constraint FK_Employee_Combination foreign key (Employee_ID)
    references Employee (ID_Employee),
    constraint FK_Post_Combination foreign key (Post_ID)
    references Post (ID_Post)
);

insert into Combination(Employee_ID, Post_ID, Post_Part)
values (1,1,1),
(2,2,1),
(3,3,0.7);

select * from Combination;

select First_Name, Second_Name, Middle_Name, Employee_Phone, Employee_Email, Post_Name, Post_Price,
Post_Part from combination
 inner join employee on Employee_ID = ID_Employee
 inner join post on Post_ID = ID_Post;
 
 

