-- subquery(

select last_name, salary -- 조회되는 것은 메인쿼리의 리턴값
from employees -- 쿼리 속에 쿼리(서브쿼리, 갯수 제한은 없다)
where salary > (select salary
                from employees
                where last_name = 'Abel');

-- 과제] Kochhar 에게 보고하는 사원들의 이름, 월급을 조회하라.
select last_name, salary
from employees
where manager_id = (select employee_id
                        from employees
                        where last_name = 'Kochhar');

select last_name, job_id, salary
from employees
where job_id = (select job_id
                from employees
                where last_name = 'Ernst') -- 직업이 같고
and salary > (select salary
                from employees
                where last_name = 'Ernst'); -- salary를 더 많이 받는

-- 과제] IT 부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
select department_id, last_name, job_id
from employees
where department_id in (select department_id
                         from employees
                            where job_id like 'IT%');
                            
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                         from departments
                            where department_name = 'IT'); 

                
-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
--      이름 순으로 오름차순 정렬한다.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel')
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees 
where salary > (select salary
                from employees -- 서브 쿼리는 리턴값이 1개여야 한다
                where last_name = 'King'); -- King이 2명이기 때문에 리턴값이 2개라서 error
                
select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);
                        
-- 과제] 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by salary desc;
------------------------------------------------------------------------------------------
select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); -- error , 서브쿼리 리턴값이 2개이상이면 = 가 작동을 못한다

-- 과제] 이름에 u가 포함된 사원과 같은 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in(select department_id
                        from employees
                        where last_name like '%u%');
                        
-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in(select department_id
                        from departments
                        where location_id = 1700);
-----------------------------------------------------------------------------------------

select employee_id, last_name
from employees
where salary in (select min(salary)
                    from employees
                    group by department_id); -- 서브쿼리가 리턴한 12개의 레코드를 in으로 비교한 것 
                
select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id); -- in > =any any는 다른 연산자와 함께 쓰인다.                
                    
select employee_id, last_name, job_id, salary
from employees
where salary <any (select salary -- 값이 1개만 true여도 된다
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';   

-- 과제] 60번 부서의 일부 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary >any (select salary
                    from employees
                    where department_id = 60);

-- 과제] 회사 평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는
--      사원들의 이름, 직업, 월급을 조회하라.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary >all (select salary
                    from employees
                    where job_id = 'IT_PROG');
----------------------------------------------------------------------------------
-- no row(서브쿼리에서 리턴되는 것이 없으면 메인쿼리에서도 리턴되는 것이 없다.)
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);

select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT'); 

-- null
select last_name
from employees
where employee_id in(select manager_id
                        from employees);
                        
select last_name
from employees
where employee_id not in(select manager_id
                        from employees);  -- not in: 어느 하나도 일치하지 않는다                   

-- 과제] 위 문장을 all 연산자로 refactoring 하라.
select last_name
from employees
where employee_id <>all(select manager_id
                        from employees);
-----------------------------------------------------------------------------------                
select count(*)
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);
-- exists 존재하는지, 사원이 있는 부서를 조회 

select count(*)
from departments d
where not exists (select *
                from employees e
                where e.department_id = d.department_id);
-- 사원이 없는 부서를 조회

-- 과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;


select employee_id, last_name, job_id, salary
from employees
where salary <all (select salary -- 모든 것이 true여야 한다
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';        
                