-- 집계(통계) 함수
select avg(salary),sum(salary), from_date -- from_date()은 아무 상관 없는 컬럼이므로 Oracle에선 오류가 난다. 
from salaries
where emp_no = 100601;

-- 한 사람 월급의 평균과 합계
select avg(salary),sum(salary) , emp_no
from salaries
group by emp_no;

select avg(salary), emp_no
from salaries
where from_date = '1985%'
group by emp_no
having avg(salary)>1000;

