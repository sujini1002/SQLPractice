show tables;

desc department;

insert into department values(1,'총무팀');
insert into department values(2,'개발팀');
insert into department values(3,'인사팀');
insert into department values(4,'영업팀');

select * from department;

insert into employee values(1,'둘리',1);
insert into employee values(2,'마이콜',2);
insert into employee values(3,'또치',3);
insert into employee values(4,'길동이',null);


select * from employee;

-- join
select d.no, d.name, e.no, e.name
from department d
join employee e on d.no = e.department_no ;

-- outer join
select d.name,ifnull(e.name,'없음')  as 사원이름
from department d
left outer join employee e on d.no = e.department_no ;

select ifnull(d.name,'업음') as 부서이름, e.name
from department d
right outer join employee e on d.no = e.department_no ;

-- mysql은 full join 지원 안함
-- select d.no, d.name, e.no, e.name
-- from department d
-- full join employee e on d.no = e.department_no ;
