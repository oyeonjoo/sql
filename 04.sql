-- single function) datatype conversion

select hire_date
from employees
where hire_date = '2003/06/17';
-- 문자가 자동으로 날짜로 변환

select salary
from employees
where salary = '7000';
-- 문자가 자동으로 숫자로 변환

select hire_date || ''
from employees;
-- 날짜를 문자로 변환

select salary || ''
from employees;
-- 숫자를 문자로 변환
-------------------------------------------------------------------------------------
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') -- 'yyyy-mm-dd' : fm(format model)
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)') -- 4장 참고
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)') -- 4장 참고
from dual;

select to_char(sysdate, 'd') -- 오늘날짜: 목요일 > 5
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day'),
    to_char(hire_date,'d')
from employees;
-- 과제] 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date -1,'d');

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR') -- fm: fill mode, 칸의 너비를 줄여서 붙인다
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--      인사평가일은 입사한 지 3개월 후 첫번째 월요일이다.
--      날짜는 YYYY.MM.DD 로 표시한다.
select last_name, to_char(hire_date,'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date   
from employees;
-------------------------------------------------------------------------------------
select to_char(salary)
from employees;

select to_char(salary, '$99,999.99') -- 9자리에 숫자가 들어간다, 소수점 둘째자리까지 넣겠다
from employees
where last_name = 'Ernst';

select to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|', -- space를 줄여준다
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237,'L9999') -- won쓰고 싶으면 L
from dual;

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>.로 조회하라.
select last_name || ' earns ' || 
    to_char(salary, 'fm$99,999') || ' monthly but wants ' || 
    to_char(salary * 3, 'fm$99,999') || '.'
from employees;
-------------------------------------------------------------------------------------
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005','fxMon dd yy'); -- Format eXtract - 형식에 맞지 않으면 err

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005','fxMon dd, yyyy'); -- err x
-- 문자를 날짜로

select to_number('1237')
from dual;
-- 문자를 숫자로

select to_number('1,237.12')
from dual; -- error , ','때문에 파싱을 못한다

select to_number('1,237.12', '9,999.99')
from dual;
-- 문자를 숫자로
-------------------------------------------------------------------------------------

-- null
select nvl(null, 0) -- 내가 정한 값을 return
from dual;

select job_id, nvl(commission_pct, 0) -- 하나의 칼럼을 구성하고 있어서 데이터 타입이 같아야 한다
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

-- 과제] 사원들의 이름, 커미션율을 조회하라.
--      커미션이 없으면 No Commission 을 표시한다.
select last_name, nvl(to_char(commission_pct),'No Commission')
from employees; -- 데이터 타입이 같아야 해서 to_char > 문자로 바꿔준다

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees; -- 두번째가 null이면, 세번째값 return

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees; -- 0은 문자

select first_name, last_name,
    nullif(length(first_name), length(last_name))
from employees; -- null을 리턴하거나 첫번째 파라미터 값을 리턴한다

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees; -- 처음으로 0이 아닌 값을 리턴한다
-------------------------------------------------------------------------------------
select last_name, salary, -- 기준값, 비교값, 리턴값, 마지막에 기본값 // 파라미터 갯수는 제약없음
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

select decode(salary, 'a', 1) -- 기본값을 안쓰면 null이 리턴된다
from employees;

select decode(salary, 'a', 1, 0) -- 기본값 0
from employees;

select decode(job_id, 1, 1) -- job_id를 숫자로 바꾸려다 실패
from employees; -- error, invaild number // 타입이 다르면 err

select decode(hire_date, 'a', 1) -- hire_date를 문자로 바꾼다
from employees;

select decode(hire_date, 1, 1) 
from employees; -- err // hire_date를 숫자로 바꾸려다 실패

-- 과제] 사원들의 직업, 직업별 등급을 조회하라.
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

select last_name, job_id, salary, -- when 필요한만큼나열, then 다음에 리턴값, 마지막에 end
    case job_id when 'IT_PROG' then 1.10 * salary -- case 기준값 when 비교값 then 리턴값 else 기본값 end
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id when '1' then 1
                    when '2' then 2
                    else 0 -- 데이터 타입은 전부 같아야한다(리턴값은 같지 않아도된다)
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

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
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

-- 과제] 2005년 이전에 입사한 사원들에게 100만원 상품권,
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name, hire_date,
    case when  hire_date <= '2005/12/31' then '100만원 상품권'
        else '10만원 상품권' end gift
from employees
order by gift, hire_date;
