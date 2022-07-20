-- join(table-record n개를 결합)
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join (equal 연산자를 사용해서)
select department_id, department_name, location_id, city
from departments natural join locations; 
-- 양쪽 테이블의 레코드를 살펴보고 공통 칼럼을 찾는다 > 공통된 레코드값의 필드를 조인 시킨다
-- 데이터 타입이 같아야 한다, pk fk 가 있어야 한다

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);
-- natural join 의 단점을 개선한 코드

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;
-------------------------------------------------------------------------------------
select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name -- 칼럼, 테이블의 별명 사용
from locations l join departments d -- 별명을 붙여준다 > 가독성이 좋아진다
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id) -- using절은 접두사를 가지지 못한다
where d.location_id = 1400; --error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id) -- using절은 접두사를 가지지 못한다
where d.location_id = 1400; --error

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; -- error 접두사를 붙여줘야한다

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100; -- (d)접두사를 붙여서 애매함을 제거
-----------------------------------------------------------------------------------
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- on 조건문

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 과제] 위 문장을, using 으로 refactoring 하라.
select employee_id, city, department_name
from employees e join departments d
using(department_id)
join locations l
using(location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의
--       이름, 직업, 부서번호, 부서명을 조회하라.
select city, last_name, employee_id, department_id, department_name
from employees e join departments d
using(department_id)
join locations l
using(location_id)
where city = 'Toronto';

select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join(equl 연산자가 아닌 경우)
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
------------------------------------------------------------------------------------
-- self join(접두사 필수)
-- 하나의 테이블이지만 다른 테이블인척 join하는 것

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- 각 사원의 상사가 누구인지 조회한다

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error, 접두사가 없어서 에러

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- self join은 접두사가 필수이다.

-- 과제] 같은 부서에서 일하는 사원들의 부서번호, 이름, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id -- <> 다르다 연산자
order by 1,2,3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-- 과제] 매니저보다 먼저 입사한 사원들의 이름, 입사일, 매니저명, 매니저입사일을 조회하라.
select w.last_name , w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date;
----------------------------------------------------------------------------------------

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id; -- Grant 누락

-- outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id; -- Grant 포함

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id; -- Grant 누락

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id; -- Grant 포함

-- 과제] 사원들의 이름, 사번, 매니저명, 매니저의 사번을 조회하라.
--      King 사장도 테이블에 포함한다.
select w.last_name , w.employee_id, m.last_name, m.employee_id
from employees w left outer join employees m
on w.manager_id = m.employee_id
order by 2;
-------------------------------------------------------------------------------------------
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id; -- 왼쪽에 (+): right outer join

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+); -- 오른쪽에 (+): left outer join

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id; -- self join