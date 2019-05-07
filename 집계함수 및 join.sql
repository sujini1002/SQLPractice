select * 
from salaries
where emp_no = 11007
order by to_date desc
;
-- 예제1 : 각 사원별로 평균연봉 출력
SELECT emp_no, AVG(salary), max(salary)    
FROM salaries
GROUP BY emp_no
order by avg(salary) desc;

-- 예제2 : 각 현재 Manager 직책 사원에 대한  평균 연봉은?(join의 필요성)
select emp_no,title from titles where title='Manager';

-- 예제 3:  사원별 몇 번의 직책 변경이 있었는지 조회 
-- group by가 없으면 오류가 있는 구문이다.
select emp_no,count(title) 
from titles
group by emp_no;


-- 예제 4: 각 사원별로 평균연봉 출력 및 50,000불 이상 
select avg(salary)
from salaries
group by emp_no
having avg(salary)>50000;

-- 예제5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.
select * from salaries;
select title,avg(s.salary), count(t.title)
from salaries s join titles t
on s.emp_no = t.emp_no
where t.to_date = '9999-01-01'
group by t.title
having count(t.title) >= 100;

select title, count(emp_no) from titles where to_date='9999-01-01' group by title having count(emp_no)>= 100;
-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만  평균급여를 구하세요.
 select emp_no,salary
 from salaries
 where to_date = '9999-01-01';
 
 select emp_no,title
 from titles
 where title='Engineer';
 -- join
select title,avg(salary) as '평균급여' from salaries join titles on titles.emp_no = salaries.emp_no
where titles.title = 'Engineer' and titles.to_date = '9999-01-01'
and salaries.to_date='9999-01-01'; 
-- 답
select dept_name,dept_emp.dept_no,title,avg(salary) as '평균급여' from salaries join titles join dept_emp join departments on titles.emp_no = salaries.emp_no and titles.emp_no = dept_emp.emp_no and departments.dept_no = dept_emp.dept_no
where titles.title = 'Engineer' and titles.to_date = '9999-01-01' and salaries.to_date='9999-01-01'
group by dept_emp.dept_no;
-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요. 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.   
select title, sum(salary) as '총합'
from salaries s join titles t
on s.emp_no = t.emp_no
where t.title != 'Engineer' and s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by t.title
having sum(s.salary) >= 2000000000 
order by sum(s.salary) desc;

