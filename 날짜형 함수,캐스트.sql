-- 날짜형 함수
select curdate(), current_date();
select curtime(),current_time();
select now(),sysdate(),current_timestamp();

-- now와 sysdate 차이
select now(), sleep(2), now(); -- 쿼리가 실행되기 전에 처리되서 상수처럼 쓴다
select sysdate(), sleep(2), sysdate(); -- 쿼리가 실행중일 때 처리하여 의도치 않는 값이 나올 수 있다.

select date_format(now(),'%Y년 %c월 %d일 %h시 %i분 %s초');

SELECT concat(first_name, ' ', last_name) AS name,               
       PERIOD_DIFF( DATE_FORMAT(CURDATE(), '%Y%m'),  
                    DATE_FORMAT(hire_date, '%Y%m') ) as '차이 개월'
FROM employees;

select first_name, hire_date, date_add(hire_date, interval 6 MONTH) as '근무평가일'
from employees;

select now(),cast(now() as date);
select cast(1-2 as unsigned);
select cast(cast(1-2 as unsigned)as signed);


