-- group function(null값을 무시한다)
select avg(salary), max(salary), min(salary), sum(salary)
from employees; -- 싱글은 파라미터 레코드가 1개, 그룹은 파라미터 레코드가 n개 이상 들어온다
-- 싱글, 그룹 전부 리턴값은 1개이다.

select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;
------------------------------------------------------------------------------------
select count(*) -- count(*)은 모든 칼럼을 지칭한다
from employees;

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id) -- 프라이머리 키 : null값을 가지지 않는다
from employees;

select count(manager_id)
from employees; -- 그룹함수에서 파라미터 밸류가 null이면 무시한다

-- null 값이 없으려면 프라이머리 키인 칼럼을 쓰거나 *을 쓴다

select avg(commission_pct)
from employees; -- 영업직의 커미션률

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct,0))
from employees;
-------------------------------------------------------------------------------------
select avg(salary)
from employees;

select avg(distinct salary)
from employees; -- distinct: 중복 제거

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
-------------------------------------------------------------------------------------
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id) -- 그룹의 제목이 온다, job_id는 논리적으로 불가능
from employees -- 필드값1: department_id, 필드값2: employee_id가 아니고, count의 리턴값 
group by department_id -- group by절에 들어오는 칼럼이 select절에 올 수 있다
order by department_id; -- error
-- group by절에 들어오는 칼럼이 select절에 올 수 있다, selsct절에는 그룹 펑션을 쓸 수 있다
-- department_id는 레이블이다

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;
-------------------------------------------------------------------------------------
select department_id, max(salary)
from employees -- 그룹을 먼저 만들고 골라낸것**
group by department_id
having department_id > 50; -- having: 그룹을 골라낸다

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000; -- 그룹이 가지고 있는 필드명을 조건문에 쓰면 된다

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error, having 에서는 별명 사용이 안된다


select department_id, max(salary)
from employees -- 골라낸 레코드로 그룹을 만든것**
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- 과제] 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--      최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;
-------------------------------------------------------------------------------------
select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary))
from employees
group by department_id; -- error, too deeply 그룹 함수는 2개까지만 중첩이 가능하다.

select department_id, round(avg(salary))
from employees
group by department_id;

select departnemt_id, round(avg(salary))
from employees; -- error

-- 과제] 2001년, 2002년, 2003년도별 입사자 수를 조회하라.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- 과제] 직업별, 부서별 월급합을 조회하라.
--      부서는 20, 50, 80 이다.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;