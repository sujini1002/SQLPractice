-- employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요. 
select first_name, last_name, title
from employees a join titles b
on a.emp_no = b.emp_no
where a.gender = 'F' and b.title = 'Engineer';

-- equi join
select first_name, title
from employees a ,titles b
where a.emp_no = b.emp_no
and a.gender = 'F' and b.title = 'Engineer';

-- natural join
select count(a.emp_no)
from employees a 
join titles b
where a.gender = 'F' and b.title = 'Engineer';

-- join ~ using
select first_name, last_name, title
from employees a 
join titles b 
using (emp_no)
where a.gender = 'F' and b.title = 'Engineer';

-- 현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
select a.emp_no, a.first_name , a.last_name, c.dept_name
from employees a join dept_emp b join departments c
on a.emp_no = b.emp_no
and b.dept_no = c.dept_no
where b.to_date= '9999-01-01';

-- outer join
select a.emp_no, a.first_name , a.last_name, c.dept_name
from employees a  
left outer join dept_emp b on a.emp_no = b.emp_no
join departments c on b.dept_no = c.dept_no
where b.to_date= '9999-01-01'
and b.dept_no is null;

-- 현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요. 사번,  전체이름, 연봉  이런 형태로 출력하세요.

