DELIMITER //
create function employee_Payment(p_ID_Employee int, p_Worked_Time decimal(38,2))
returns decimal(38,2)
deterministic
begin
	declare total_payment decimal(38,2);
		select (sum(Post_Part*Post_Price*0.87)*p_Worked_Time)/160 into total_payment from combination
        inner join post on Post_ID = ID_Post
        where Employee_ID = p_ID_Employee;
    return total_payment;
end;

select employee_Payment(2, 160);

select Post_Name as 'Должность',count(Employee_ID)as "Количество сотрудников" from combination
right join post on ID_Post = Post_ID
group by Post_Name;

create table History_Employee
(
	ID_History_Employee int not null auto_increment primary key,
    Record_Status varchar(30) not null,
    Employee_Info varchar(30) not null,
    Post_Info varchar(500) not null,
    Date_Create timestamp null default now()
);

DELIMITER //
create trigger tg_Employee_
on combination
for each row
begin
	if .ID_Combination then
		insert into History_Employee(Record_Status, Employee_Info, Post_Info)
        values('',
        (select concat(First_Name,' ',substr(Second_Name from 1 for 1),'.',substr(Middle_Name from 1 for 1),'.')
        from employee where ID_Employee = .Employee_ID),
        (select from concat('Должность: ',,'. С окладом = ',
        CAST(Post_Price as varchar(100)),' руб. Ставка = ',CAST(.Post_Part as varchar(100)))
        post where ID_Post = .Post_ID));
    end if;
end;






