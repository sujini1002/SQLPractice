-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 

select b.dept_no
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and concat(a.first_name,' ',b.last_name) = 'Fai Bale';

select *
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = 'd004';

-- 서브쿼리
select a.emp_no, concat(a.first_name,' ',a.last_name) as '이름' , b.dept_no
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = (select b.dept_no
				from employees a, dept_emp b
				where a.emp_no = b.emp_no
				and b.to_date = '9999-01-01'
				and concat(a.first_name,' ',a.last_name) = 'Fai Bale');

-- 단일행인 경우
-- <,>,=,!=,<=,>= 등호 사용가능

-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를  나타내세요.
select concat(e.first_name,' ',e.last_name) as '이름' , s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary < (select avg(salary)
				from salaries
                where to_date = '9999-01-01')
order by s.salary desc  -- 검증
;

-- 현재 가장적은 평균 급여를 받고 있는 직책에 대해서  평균 급여를 구하세요   
-- 방법1
SELECT 
    b.title, ROUND(AVG(a.salary))
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING ROUND(AVG(a.salary)) = (
								SELECT MIN(avg_salary)
								FROM
									(
										SELECT b.title, ROUND(AVG(a.salary)) AS avg_salary
										FROM salaries a, titles b
										WHERE a.emp_no = b.emp_no
										AND a.to_date = '9999-01-01'
										AND b.to_date = '9999-01-01'
										GROUP BY b.title
									) title_salary
								);

select title, min(avg_salary)
from (select b.title, avg(a.salary) as avg_salary
from salaries a, titles b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by b.title) title_salary
;

-- join으로 해결(TOP-K)f
SELECT 
    b.title, AVG(a.salary)as avg_salary
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
order by avg_salary
limit 0,1;

-- from절 서브쿼리
SELECT 
    b.title, AVG(a.salary)as avg_salary
FROM
-- (select b.title, avg(
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.titl
;

-- 다중행
-- in(NOT IN) 
-- ANY
-- = any(in과 동일한 기능) >any() : 하나라도 크면 ok, <>any(!=All과 동일),<=any,>=any,<any
-- ALL =all,>all,<all,<=all,>=a



-- 예제 : 현재 급여가 50000 이상인 직원 이름 출력
-- 서브쿼리 해결(any)
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no,b.salary) = any(select emp_no,salary
from salaries
where to_date = '9999-01-01'
and salary>50000);
-- 서브쿼리 해결(in)
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and (a.emp_no,b.salary) in(select emp_no,salary
from salaries
where to_date = '9999-01-01'
and salary>50000);

select a.first_name
from employees a, (select emp_no,salary
from salaries
where to_date = '9999-01-01'
and salary>50000) b
where a.emp_no = b.emp_no;

-- 조인으로 해결
select a.first_name
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and b.salary >= 50000;

-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력

-- 각 부서별 최고월급
select c.dept_no,max(b.salary) as max_salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by c.dept_no;

-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력
-- 방법 1 ) where절의 서브쿼리 사용
select a.first_name, c.dept_no,b.salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and (c.dept_no,b.salary) = any(
	select c.dept_no,max(b.salary) as max_salary
	from employees a, salaries b, dept_emp c
	where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
	group by c.dept_no
	)
;
-- 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력
-- 방법2 ) from절의 서브쿼리
select a.first_name, c.dept_no,b.salary
from employees a, salaries b, dept_emp c,
(select c.dept_no,max(b.salary) as max_salary
	from employees a, salaries b, dept_emp c
	where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
	group by c.dept_no) d
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and b.salary = d.max_salary
;