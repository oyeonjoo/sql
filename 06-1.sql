-- join(table-record n���� ����)
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join (equal �����ڸ� ����ؼ�)
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; --err

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- err

select e.last_name, d.department_name
from employees e join departments d
using (departmemt_id)
where manager_id = 100; -- err

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;
------------------------------------------------------------------------------------
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using ���� refactoring �϶�.
select employee_id, city, department_name
from employees s join departments d
using(department_id)
join locations l
using (location_id);

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

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--       �̸�, ����, �μ���ȣ, �μ����� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

