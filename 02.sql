-- where ���ǹ�

select employee_id, last_name, department_id
from employees
where department_id = 90; -- ���ǹ�(boolean type)

-- ����] 176�� ����� �̸��� �μ���ȣ�� ��ȸ�϶�.
select employee_id, last_name, department_id
from employees
where employee_id = '176'; -- primary key ���� = �����ڰ� �´�

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen'; -- ������ Ÿ���� ���ƾ� �����ڰ� ���ȴ�.

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06'; -- ��¥�� long type���� �����Ѵ�

select last_name, salary
from employees
where salary <= 3000;

-- ����] $12,000 �̻� ���� ������� �̸�, ������ ��ȸ�϶�.
select last_name, salary
from employees
where salary >= 12000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

select last_name, salary
from employees
where salary between 2500 and 3500; -- between ~�̻� ~����

select last_name
from employees
where last_name between 'King' and 'Smith';

-- ����] 'King'����� first name, last name, ����, ������ ��ȸ�϶�.
select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; -- ��Ʈ�� ���� �����ʹ� ��ҹ��ڸ� �����Ѵ�('king, King') sql�� �������� �ʴ� ���̴�

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';
-------------------------------------------------------------------------------------
select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); -- 100, 101, 201�� ����� ���ϰ� ��������, �Ǽ�

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
-------------------------------------------------------------------------------------   
select employee_id, last_name
from employees
where last_name in ('Hartstein', 'Vargas'); -- ���ڴ� '' ���� ����ǥ

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');
-------------------------------------------------------------------------------------
select last_name
from employees
where last_name like 'S%'; -- s: ������, %: wildcard, ������ 0�� �̻��� �����̴�(������ ���ڼ��� ����)

select last_name
from employees
where last_name like '%r'; -- like�� ���ڿ� ���

-- ����] �̸��� s�� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%s%';

-- ����] 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where hire_date like '2005%';

select last_name
from employees
where last_name like 'K___'; -- _ : ������ھ�, ���ڼ� ���� ���� wildcard

-- ����] �̸��� �ι�° ���ڰ� o�� ����� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '_o%'; -- like�� �˻��� �� ���ȴ�

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; -- escape ���ڸ� ���� �Ϲ� ���ڷ� �νĵȴ�

select last_name, job_id
from employees
where job_id like 'IT{_%' escape '{';

-- ����] ������ _R�� ���Ե� ������� �̸�, ������ ��ȸ�϶�.
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';
-------------------------------------------------------------------------------------
select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null;

select last_name, manager_id
from employees
where manager_id is null; -- ���Ŀ� null ���� �ϳ��� ������ ���� null�� �ȴ�(||������ ����) > is null ������ ���
-------------------------------------------------------------------------------------
select last_name, job_id, salary
from employees
where salary >= 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary >= 5000 or job_id like '%IT%';
-------------------------------------------------------------------------------------
select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); -- not���� �������� ���� �� �ִ�, not�� �ٸ� �����ڿ� ���� ����ؾ߸� ����� �� �ִ�(���)

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where manager_id is null and salary >= 20000;

select last_name, salary
from employees
where not (manager_id is null and salary >= 20000); -- �� ������ : ���� �������� ó��, ()�� ���´�

-- ����] ������ $5000 �̻� $12000 �����̴�, �׸���
--       20���̳� 50�� �μ��� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
    department_id in(20,50);
    
-- ����] �̸��� a�� e�� ���Ե� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where last_name like '%a%' and 
    last_name like '%e%';
    
-- ����] ������ �����̴�. �׸���, ������ $2500, %3500�� �ƴϴ�.
--      �� ������� �̸�, ����, ������ ��ȸ�϶�.    
select last_name, job_id, salary
from employees
where job_id like 'SA%' and
    salary not in(2500,3500);
-------------------------------------------------------------------------------------
select last_name, department_id
from employees
order by department_id; -- �������� ����

select last_name, department_id
from employees
order by department_id desc; -- �������� ����

select last_name, department_id
from employees
order by 2 desc; -- 2��° �׸����� �������� ����

select last_name, department_id dept_id
from employees
order by dept_id desc; -- �׸��� �������� ��������

select last_name, hire_date -- ��ȸ�����ʴ� �׸����ε� ���� ����, hire_date �����ص� ���İ����ϴ�
from employees
where department_id = 100
order by hire_date;

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc; -- asc: ��������, desc: ��������

