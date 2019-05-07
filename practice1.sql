-- sql 연습 1
-- 1번
select concat(first_name,' ', last_name) from employees where emp_no=19044;
-- 2번
select concat(first_name, last_name) as '이름', gender as '성별', hire_date as '입사일'
from employees
order by hire_date asc;
-- 3번
select gender, count(*)
from employees
group by gender;
-- 4번
select count(*)
from salaries
where to_date = '9999-01-01';
-- 5번
select count(dept_no)
from departments;
-- 6번
select count(*)
from dept_manager
where to_date = '9999-01-01';

-- 7번
select *
from departments
order by char_length(dept_name) desc;

-- 답
select distinct dept_name
from departments
order by length(dept_name) desc;

-- 8번
select count(*)
from salaries
where to_date = '9999-01-01'
and salary >= 120000;

-- 9번
select distinct title
from titles
order by char_length(title) desc;

-- 10번
select count(emp_no)
from titles
where title = 'Engineer'
and to_date = '9999-01-01';

-- 11번
select emp_no,title,to_date
from titles
where emp_no = 13250
order by to_date asc;

-- 답
select title, from_date, to_date
from titles
where emp_no = 13250
order by from_date asc;

select * from titles;
select * from employees;
select * from dept_manager;