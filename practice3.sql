-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select e.emp_no,e.first_name,e.last_name,s.salary
from employees e
join salaries s on e.emp_no = s.emp_no
where to_date = '9999-01-01'
order by s.salary desc;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select e.emp_no,concat(e.first_name,' ',e.last_name)as '이름', t.title
from employees e join titles t
on e.emp_no = t.emp_no
where t.to_date = '9999-01-01'
group by t.emp_no
order by 이름 asc;

-- 답
select e.emp_no,concat(e.first_name,' ',e.last_name)as '이름', t.title
from employees e join titles t
on e.emp_no = t.emp_no
where t.to_date = '9999-01-01'
order by 이름 asc;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select  e.emp_no,concat(e.first_name,' ',e.last_name)as '이름',de.dept_no, d.dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no 
order by 이름 asc;

-- 답
select  e.emp_no,concat(e.first_name,' ',e.last_name)as '이름',de.dept_no, d.dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
where de.to_date = '9999-01-01' 
order by 이름 asc;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select e.emp_no,concat(e.first_name,' ',e.last_name)as '이름',s.salary,t.title,d.dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no 
join salaries s on e.emp_no = s.emp_no
join titles t on e.emp_no = t.emp_no
where s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
order by 이름;

-- 답
select e.emp_no,concat(e.first_name,' ',e.last_name)as '이름',s.salary,t.title,d.dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no 
join salaries s on e.emp_no = s.emp_no
join titles t on e.emp_no = t.emp_no
where s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
order by 이름;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
select e.emp_no,concat(e.first_name,' ',e.last_name)as '이름'
from employees e
join titles t on e.emp_no = t.emp_no
where t.title = 'Technique Leader'
and t.to_date != '9999-01-01' ;
-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select concat(a.first_name,' ',a.last_name)as '이름',c.dept_name,d.title
from employees a
join dept_emp b on a.emp_no = b.emp_no
join departments c on b.dept_no = c.dept_no
join titles d on a.emp_no = d.emp_no
where a.last_name like 'S%'
-- and d.to_date = '9999-01-01'
;

-- 답
select concat(a.first_name,' ',a.last_name)as '이름',c.dept_name,d.title
from employees a
join dept_emp b on a.emp_no = b.emp_no
join departments c on b.dept_no = c.dept_no
join titles d on a.emp_no = d.emp_no
where a.last_name like 'S%'
and d.to_date = '9999-01-01'
and d.title = '9999-01-01'
;
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
select t.emp_no,s.salary,t.title
from titles t 
join salaries s on t.emp_no = s.emp_no
where t.title = 'Engineer'
and s.salary >= 40000
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
order by s.salary desc;

-- 답
select concat(a.first_name,' ',a.last_name)as '이름', t.emp_no,s.salary,t.title
from employees e
join titles t on e.emp_no = t.title
join salaries s on e.emp_no = s.emp_no
where t.title = 'Engineer'
and s.salary >= 40000
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
order by s.salary desc;


-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select t.title,s.salary
from titles t
join salaries s on t.emp_no = s.emp_no
where s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title
having s.salary>=50000
order by s.salary desc;

select t.title,s.salary
from employees e
join titles t  on e.emp_no =t.emp_no
join salaries s on e.emp_no = s.emp_no
where s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and s.salary>=50000
order by s.salary desc;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select e.dept_no,avg(s.salary) as '부서별평균연봉'
from dept_emp e join salaries s
on e.emp_no =s.emp_no
where s.to_date = '9999-01-01'
and e.to_date = '9999-01-01'
group by e.dept_no
order by 부서별평균연봉 desc;

-- 답
select d.dept_name, avg(salary)
      from employees a
      join dept_emp b on a.emp_no = b.emp_no
      join salaries c on a.emp_no = c.emp_no
      join departments d on b.dept_no = d.dept_no
      where b.to_date = '9999-01-01'
       and c.to_date - '9999-01-01'      
  group by d.dept_name
  order by avg(salary) desc; 

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select t.title, avg(s.salary) as '직책별평균연봉'
from titles t
join salaries s on t.emp_no = s.emp_no
where s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by t.title
order by 직책별평균연봉 desc;

-- 답
select c.title, avg(b.salary)
     from employees a
	 join salaries b  on a.emp_no = b.emp_no 
	 join titles c  on a.emp_no = c.emp_no
     where b.to_date = '9999-01-01'
      and c.to_date - '9999-01-01'
 group by c.title
 order by avg(b.salary) desc;