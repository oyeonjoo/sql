-- single function(�Ķ���Ͱ� 1���� ���)

desc dual -- ��¥ table(DUMMY)
select * from dual; -- record�� return�� ���̴�

select lower('SQL Course') -- parameter�� field �� �ϳ�(SQL Course) �ִ� record�� �޾Ƽ� �ҹ��ڷ� return���ش�
from dual; -- �ҹ��ڷ� �ٲ��ش�

select upper('SQL Course') -- �ҹ��ڸ� �빮�ڷ� �ٲ��ش�
from dual;

select initcap('SQL course')-- ù���ڸ� �빮�ڷ� �ٲ��ش�
from dual;

select last_name
from employees
where last_name = 'higgins'; -- �빮�ڿ� �ٸ� �������̴�

select last_name
from employees
where last_name = 'Higgins'; -- �ҹ��ڿ� �ٸ� �������̴�

select last_name
from employees
where lower(last_name) = 'higgins';
-- last_name function���� �빮�ڰ� ������(���ڵ尡 �Ķ���ͷ� ����-���ڵ� ������ŭ ����ȴ�)
-- lower������ 'higgins'�� ���ٰ� ���´�

select concat('Hello', 'World')
from dual;

select substr('HelloWorld', 2, 5) --(idx��ġ-SQL�� 1���� ����, length)
from dual;
-- 2��° ���ں��� 5���� ����

select substr('Hello', -1, 1)
from dual;
-- idx ���� '-' �� ���̸� �ڿ��� ���� ����

select length('Hello')
from dual;
-- ���ڼ� Ȯ���ϴ� �޼ҵ�

select instr('Hello', 'l')
from dual;
-- ���ڰ� �ִ��� Ȯ���ϴ� �޼ҵ�, ���°�� �ִ��� �������ش�
-- 0���� ũ�� ���ڰ� �ְ�, 0�̸� ���ڰ� ����
select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') 
from employees; -- salary�� �Ἥ Į������ ���ش�
-- 5�ڸ��߿� ���ʿ� *�� �ְڴ�

select rpad(salary, 5, '*')
from employees;
-- 5�ڸ��߿� �����ʿ� *�� �ְڴ�

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�.
--      �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc; -- ������� salary�� �ۼ��ص��ȴ�(�׸� ��� ��ȸ����)

select replace('JACK and JUE', 'J', 'BL')
from dual;
-- J�ڸ��� BL�� �ְڴ�

select trim('H' from 'Hello')
from dual;
-- ù���ڿ� ������ ���ڸ� �� �� �ִ�

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;

-- ����] �� query���� ' '�� trim ������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';    

-- ����] �Ʒ� ���忡��, where ���� like �� refactoring �϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';   

-- ����] �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
--      �̸��� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
-------------------------------------------------------------------------------------
select round(46.926, 2)
from dual; -- �Ҽ��� ��°�ڸ� '�ݿø�'

select trunc(45.926, 2)
from dual; -- �Ҽ��� ��°�ڸ� '����'

select mod(1600, 300)
from dual; -- �������� ���Ѵ�

select round(45.923, 0), round(45.923)
from dual; -- round(45.923, 0): ������ ���� �� 0�� ���, 0 ��������

select trunc(45.923, 0) 
from dual; -- ���� ó���ؼ� ������ �ٲ۴�

-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����), �λ��(Increase)�� ��ȸ�϶�.
select last_name, salary,
    round(salary * 1.155) "New Salary",
    round(salary * 1.155) - salary "Increase"
from employees;
-------------------------------------------------------------------------------------

-- ��¥ �Լ�
select sysdate
from dual; -- ������ �ð�

select sysdate + 1
from dual;

select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- ����] 90�� �μ� ������� �̸�, �ټӳ���� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual; -- ������ ���(�տ� ū ��)

select add_months('2022/07/14', 1)
from dual; -- 1���� ���� ��¥

select next_day('2022/07/14', 7)
from dual; -- 7��14�� ���� ù��° ����, �Ͽ��� 1, ������ 2 ~ ����� 7

select next_day('2022/07/14', 'thursday')
from dual; -- 7��14�� ���� ù��° ����

select next_day('2022/07/14', 'thu')
from dual; -- 7��14�� ���� ù��° ����

select last_day('2022/07/14')
from dual; -- ���� ���

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--      ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;