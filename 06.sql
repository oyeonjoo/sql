-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join (equal �����ڸ� ����ؼ�)
select department_id, department_name, location_id, city
from departments natural join locations; 
-- ���� ���̺��� ���ڵ带 ���캸�� ���� Į���� ã�´� > ����� ���ڵ尪�� �ʵ带 ���� ��Ų��
-- ������ Ÿ���� ���ƾ� �Ѵ�, pk fk �� �־�� �Ѵ�

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);
-- natural join �� ������ ������ �ڵ�

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
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

select l.city, d.department_name -- Į��, ���̺��� ���� ���
from locations l join departments d -- ������ �ٿ��ش� > �������� ��������
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id) -- using���� ���λ縦 ������ ���Ѵ�
where d.location_id = 1400; --error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id) -- using���� ���λ縦 ������ ���Ѵ�
where d.location_id = 1400; --error

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; -- error ���λ縦 �ٿ�����Ѵ�

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100; -- (d)���λ縦 �ٿ��� �ָ����� ����
-----------------------------------------------------------------------------------
select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- on ���ǹ�

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using ���� refactoring �϶�.
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

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� �������
--       �̸�, ����, �μ���ȣ, �μ����� ��ȸ�϶�.
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

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
------------------------------------------------------------------------------------
-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- �� ����� ��簡 �������� ��ȸ�Ѵ�

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error, ���λ簡 ��� ����

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- self join�� ���λ簡 �ʼ��̴�.

-- ����] ���� �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ �̸��� ��ȸ�϶�.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id -- <> �ٸ��� ������
order by 1,2,3;

-- ����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hite_date
from employees e join workers w
on e.hire_date < w.hire_date
and e.last_name = 'Davies';