-- group function(null���� �����Ѵ�)
select avg(salary), max(salary), min(salary), sum(salary)
from employees; -- �̱��� �Ķ���� ���ڵ尡 1��, �׷��� �Ķ���� ���ڵ尡 n�� �̻� ���´�
-- �̱�, �׷� ���� ���ϰ��� 1���̴�.

select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ���ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

select count(*) -- count(*)�� ��� Į���� ��Ī�Ѵ�
from employees;

-- ����] 70�� �μ����� ������� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id) -- �����̸Ӹ� Ű : null���� ������ �ʴ´�
from employees;

select count(manager_id)
from employees; -- �׷��Լ����� �Ķ���� ����� null�̸� �����Ѵ�

-- null ���� �������� �����̸Ӹ� Ű�� Į���� ���ų� *�� ����

select avg(commission_pct)
from employees; -- �������� Ŀ�̼Ƿ�

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct,0))
from employees;

select avg(salary)
from employees;

select avg(distinct salary)
from employees; -- distinct: �ߺ� ����

select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
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

select department_id, job_id, count(employee_id) -- �׷��� ������ �´�, job_id�� �������� �Ұ���
from employees -- �ʵ尪1: department_id, �ʵ尪2: employee_id�� �ƴϰ�, count�� ���ϰ� 
group by department_id -- group by���� ������ Į���� select���� �� �� �ִ�
order by department_id; -- error
-- group by���� ������ Į���� select���� �� �� �ִ�, selsct������ �׷� ����� �� �� �ִ�
-- department_id�� ���̺��̴�

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;
-------------------------------------------------------------------------------------
select department_id, max(salary)
from employees -- �׷��� ���� ����� ��󳽰�
group by department_id
having department_id > 50; -- having: �׷��� ��󳽴�

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000; -- �׷��� ������ �ִ� �ʵ���� ���ǹ��� ���� �ȴ�

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error, having ������ ���� ����� �ȵȴ�


select department_id, max(salary)
from employees -- ��� ���ڵ�� �׷��� �����
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error

