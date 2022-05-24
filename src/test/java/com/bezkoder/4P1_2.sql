use Employee_BAse_4P1;

create or replace view Employee_Posts
as
select concat(First_Name,' ',substr(Second_Name from 1 for 1),'.',substr(Middle_Name from 1 for 1),
'.')
as "Персональные данные сотрудника",
Concat('Телефон: ',Employee_Phone,', Email: ',Employee_Email) as "Контактные данные",
Concat('Занимаемая должность: ',Post_Name,'. Ставка: ',Post_Part, '. Оклад с НДФЛ ='
,round(Post_Price*Post_Part*0.87,2)) as "Данные по должности"
 from combination
inner join employee on Employee_ID = ID_Employee
inner join post on Post_ID = ID_Post;
;

select * from employee_posts;