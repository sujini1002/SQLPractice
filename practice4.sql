-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*)
from salaries
where to_date = '9999-01-01'
and salary > (select avg(salary)
			 from salaries
             where to_date = '9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select e.emp_no, concat(e.first_name,' ',e.last_name) as 'name', d.dept_name , s.salary
from employees e, dept_emp de, salaries s, departments d
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
and d.dept_no = de.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and s.salary in(
select max(s.salary) as max_salary
from titles t, salaries s
where t.emp_no = s.emp_no
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by t.title)
order by s.salary desc
;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select e.emp_no,concat(e.first_name,' ',e.last_name) as 'name',s.salary
from employees e, salaries s , dept_emp d,
(select d.dept_no,avg(salary) as avg_salary
    from salaries s, dept_emp d
    where s.emp_no = d.emp_no
    and s.to_date = '9999-01-01'
    and d.to_date = '9999-01-01'
    group by d.dept_no) dept_avg
where e.emp_no = s.emp_no
and dept_avg.dept_no = d.dept_no
and s.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
and s.salary > dept_avg.avg_salary
;


-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select e.emp_no,concat(e.first_name,' ',e.last_name),manager.manager,d.dept_name
from employees e, dept_manager dm, salaries s, departments d,
	(select dm.emp_no, concat(e.first_name,' ',e.last_name) as 'manager'
	from employees e join dept_manager dm
	on e.emp_no = dm.emp_no
	where dm.to_date = '9999-01-01') manager
where e.emp_no = dm.emp_no
and d.dept_no = dm.dept_no
and dm.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
;
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select e.emp_no,concat(e.first_name,' ',e.last_name) as'이름',t.title,s.salary
from employees e, titles t, salaries s, dept_emp d
where e.emp_no = t.emp_no
and e.emp_no = s.emp_no
and e.emp_no = d.emp_no
and d.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and d.dept_no = (select dept_no
				from dept_emp d, salaries s
				where d.emp_no = s.emp_no
				and s.to_date = '9999-01-01'
				and d.to_date = '9999-01-01'
				group by d.dept_no
				having round(avg(salary))=(select max(avg_dept)
											from (select round(avg(s.salary)) as avg_dept
													from dept_emp d join salaries s
													on d.emp_no = s.emp_no
													where s.to_date = '9999-01-01'
													and d.to_date = '9999-01-01'
													group by d.dept_no
												 ) tmp
										 )
			)
order by s.salary
;
select dept_no
				from dept_emp d, salaries s
				where d.emp_no = s.emp_no
				and s.to_date = '9999-01-01'
				and d.to_date = '9999-01-01'
				group by d.dept_no
				having round(avg(salary))=(select max(avg_dept)
											from (select round(avg(s.salary)) as avg_dept
													from dept_emp d join salaries s
													on d.emp_no = s.emp_no
													where s.to_date = '9999-01-01'
													and d.to_date = '9999-01-01'
													group by d.dept_no
												 ) tmp
										 );
-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
select d.dept_name
from dept_emp de, salaries s , departments d
where de.emp_no = s.emp_no
and de.dept_no = d.dept_no
group by de.dept_no 
having round(avg(s.salary))=(select max(dept_avg)
							from (select round(avg(s.salary)) as dept_avg
									from dept_emp de, salaries s
									where de.emp_no = s.emp_no
									group by de.dept_no) tmp
							)
;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select title
from titles t, salaries s
where t.emp_no = s.emp_no
group by title
having round(avg(s.salary)) = (
	select max(avg_title)
    from (
		select round(avg(s.salary)) as avg_title
        from titles t, salaries s
        where t.emp_no = s.emp_no
        group by t.title
    ) tmp
)
;
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name,concat(e.first_name,' ',e.last_name) as '이름',s.salary, manager.m_name, manager.m_salary
from employees e, salaries s, dept_emp de,departments d,
(select e.emp_no as 'm_no', concat(e.first_name,' ',e.last_name) as 'm_name' ,s.salary as 'm_salary'
from employees e, dept_manager dm, salaries s
where e.emp_no = dm.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and dm.to_date = '9999-01-01') manager
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and s.salary > manager.m_salary

;
-- 메니저 테이블
select e.emp_no as 'm_no', concat(e.first_name,' ',e.last_name) as 'm_name' ,s.salary as 'm_salary'
from employees e, dept_manager dm, salaries s
where e.emp_no = dm.emp_no
and e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and dm.to_date = '9999-01-01';