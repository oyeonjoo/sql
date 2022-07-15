-- single function) datatype conversion

select hire_date
from employees
where hire_date = '2003/06/17';
-- ���ڰ� �ڵ����� ��¥�� ��ȯ

select salary
from employees
where salary = '7000';
-- ���ڰ� �ڵ����� ���ڷ� ��ȯ

select hire_date || ''
from employees;
-- ��¥�� ���ڷ� ��ȯ

select salary || ''
from employees;
-- ���ڸ� ���ڷ� ��ȯ
-------------------------------------------------------------------------------------
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') -- 'yyyy-mm-dd' : fm(format model)
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)') -- 4�� ����
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)') -- 4�� ����
from dual;

select to_char(sysdate, 'd') -- ���ó�¥: ����� > 5
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date,'d')
from employees;
-- ����] �� ���̺��� �����Ϻ��� �Ի��ϼ� �������� �����϶�.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date -1,'d');

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR') -- fm: fill mode, ĭ�� �ʺ� �ٿ��� ���δ�
from employees;

-- ����] ������� �̸�, �Ի���, �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� �� 3���� �� ù��° �������̴�.
--      ��¥�� YYYY.MM.DD �� ǥ���Ѵ�.
select last_name, to_char(hire_date,'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date   
from employees;
-------------------------------------------------------------------------------------
select to_char(salary)
from employees;

select to_char(salary, '$99,999.99') -- 9�ڸ��� ���ڰ� ����, �Ҽ��� ��°�ڸ����� �ְڴ�
from employees
where last_name = 'Ernst';

select to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|', -- space�� �ٿ��ش�
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237,'L9999') -- won���� ������ L
from dual;

-- ����] <�̸�> earns <$,����> monthly but wants <$,����x3>.�� ��ȸ�϶�.
select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999') || ' monthly but wants ' || 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;
-------------------------------------------------------------------------------------
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005','fxMon dd yy'); -- Format eXtract - ���Ŀ� ���� ������ err

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005','fxMon dd, yyyy'); -- err x
-- ���ڸ� ��¥��

select to_number('1237')
from dual;
-- ���ڸ� ���ڷ�

select to_number('1,237.12')
from dual; -- error , ','������ �Ľ��� ���Ѵ�

select to_number('1,237.12', '9,999.99')
from dual;
-- ���ڸ� ���ڷ�
-------------------------------------------------------------------------------------

-- null
select nvl(null, 0) -- ���� ���� ���� return
from dual;

select job_id, nvl(commission_pct, 0) -- �ϳ��� Į���� �����ϰ� �־ ������ Ÿ���� ���ƾ� �Ѵ�
from employees;

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- ����] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--      Ŀ�̼��� ������ No Commission �� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct),'No Commission')
from employees; -- ������ Ÿ���� ���ƾ� �ؼ� to_char > ���ڷ� �ٲ��ش�

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; -- �ι�°�� null�̸�, ����°�� return

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees; -- 0�� ����

select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees; -- null�� �����ϰų� ù��° �Ķ���� ���� �����Ѵ�

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees; -- ó������ 0�� �ƴ� ���� �����Ѵ�
-------------------------------------------------------------------------------------
select last_name, salary, -- ���ذ�, �񱳰�, ���ϰ�, �������� �⺻�� // �Ķ���� ������ �������
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1) -- �⺻���� �Ⱦ��� null�� ���ϵȴ�
from employees;

select decode(salary, 'a', 1, 0) -- �⺻�� 0
from employees;

select decode(job_id, 1, 1) -- job_id�� ���ڷ� �ٲٷ��� ����
from employees; -- error, invaild number // Ÿ���� �ٸ��� err

select decode(hire_date, 'a', 1) -- hire_date�� ���ڷ� �ٲ۴�
from employees;

select decode(hire_date, 1, 1) 
from employees; -- err // hire_date�� ���ڷ� �ٲٷ��� ����

-- ����] ������� ����, ������ ����� ��ȸ�϶�.
--      IT_PROG    A
--      AD_PRES    B
--      ST_MAN     C
--      ST_CLERK   D
select job_id, decode(job_id, 
        'IT_PROG', 'A',
        'AD_PRES', 'B',
        'ST_MAN', 'C',
        'ST_CLERK', 'D') grade
from employees;

select last_name, job_id, salary, -- when �ʿ��Ѹ�ŭ����, then ������ ���ϰ�, �������� end
    case job_id when 'IT_PROG' then 1.10 * salary -- case ���ذ� when �񱳰� then ���ϰ� else �⺻�� end
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 -- ������ Ÿ���� ���� ���ƾ��Ѵ�(���ϰ��� ���� �ʾƵ��ȴ�)
        end grade
from employees;
        
select case salary when 1 then 1
                    when 2 then 2
                    else '0'
        end grade
from employees;
        
select case salary when '1' then '1'
                    when 2 then '2'
                    else '0'
        end grade
from employees;        -- error

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0
        end grade
from employees;        -- error

select case salary when 1 then 1
                    when 2 then '2'
                    else '0'
        end grade
from employees;        -- error

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

-- ����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--      2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�Ǳݾ��� ��ȸ�϶�.
select last_name, hire_date,
    case when  hire_date <= '2005/12/31' then '100���� ��ǰ��'
        else '10���� ��ǰ��' end gift
from employees
order by gift, hire_date;
