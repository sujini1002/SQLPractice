select count(*) from employees;
-- 주석
select * from employees;

-- select 기본
select * from departments;

select first_name, gender,hire_date from employees;

-- concat()
select concat(first_name,' ',last_name) as 'full name', gender as '성별', hire_date as '입사일'  from employees;

-- distinct
select distinct title from titles;

-- order by
select concat(first_name,' ',last_name) as 'full name', gender as '성별', hire_date as '입사일'  
from employees
order by hire_date desc;

select emp_no,salary,from_date from salaries where from_date like '2001%' order by salary desc;

-- 1991년에 입사한 사람
select concat(first_name,' ',last_name) as 'full name', gender as '성별', hire_date as '입사일'  
from employees
where hire_date < '1991-01-01';

-- 1989년 전에 입사한 여자 직원
select concat(first_name,' ',last_name) as 'full name', gender as '성별', hire_date as '입사일'  
from employees
where hire_date < '1989-01-01'
and gender = 'F';

-- 
select emp_no, dept_no 
from dept_emp
where dept_no in ('d005','d009');