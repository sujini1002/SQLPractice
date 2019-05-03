-- 문자형 함수
-- 대소문자 변환
select upper('Seoul'),ucase('seoul');
select upper(first_name) from employees;
SELECT LOWER('SEoul'), LCASE('SEOUL'); 

-- 특정 문자열 잘라서 가져오기
select substring('Happy Day',3,2);

SELECT concat( first_name, ' ', last_name ) AS 이름,
         hire_date AS 입사일
    FROM employees
   WHERE substring( hire_date, 1, 4) = '1989';

-- 왼쪽로 문자여 
select lpad('123456',10,'-'), rpad('123456',10,'-');


select emp_no,lpad(salary,10,'*'),salary
from salaries
where from_date like '2001-%'
and salary < 700000;

select concat('----',ltrim(' hello '),'----'), concat('----',rtrim(' hello '),'----'), concat('----',trim(' hello '),'----')
,concat('----',trim(both 'x' from'xxxxxhelloxxxxx'),'----');

-- 숫자형 함수
select abs(1), abs(-1);
select mod(234,10), 234%10;
select floor(1.2345), floor(-1.2345);
select ceiling(1.2345), ceiling(-1.2345);
select round(-1.23), round(-1.58), round(1.58),round(1.298,1);
select pow(2,3), power(2,-3);
select sign(-10),sign(10),sign(0);
select greatest(98,59,33),greatest('a','A','b','E','E','EB','ED');
select least(98,59,33),least('a','A','b','E','E','EB','ED');

