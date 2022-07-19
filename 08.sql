-- set 집합

select employee_id, job_id
from employees -- 현재직업
union -- 집합, 중복제거
select employee_id, job_id
from job_history; -- 과거직업

-- 숫자 , 문자로 테이블 구조가 같다

select employee_id, job_id
from employees
union all -- 집합
select employee_id, job_id
from job_history;

-- 과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where job_id in (select job_id
                from job_history j
                where e.employee_id = j.employee_id);
                
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;


select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history; -- 차집합
-----------------------------------------------------------------------
select location_id, department_name
from departments
union
select location_id, state_province
from locations;

-- 과제] 위 문장을, service 관점에서 고쳐라.
--      union 을 사용한다.
select location_id, department_name, null state
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; -- error

-- 과제] 위 문장을, persistence 관점에서 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, null --  null 대신 0 도 들어갈 수 있다
from job_history
order by salary;