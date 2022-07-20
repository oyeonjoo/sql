-- DDL(Data Definition Language)

drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname
from tab; -- data dictionary(데이터를 저장하고 있는 곳)

-- 과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
-------------------------------------------------------------------------------------
-- DCL(Data Control Language : data base를 관리하는 것)
-- hr user는 실행 못하고 system user만 실행 가능하다
-- system user(system connection 으로 변경한다.)

create user you identified by you;
grant connect, resource to you;
-- 이 명령어는 dcl 이고 dcl은 hr user는 실행할 수 없다.

-- you user(you connection 으로 변경한다.)
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key, -- pk 지정
department_name varchar2(20)); -- constraint 제약 조건(필드 밸류 제약)

desc user_constraints -- data dictionary

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key,
emp_name varchar2(10) constraint emps_empname_nn not null, -- emp_name에 null 값이 들어오면 안된다
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email),
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id)); -- 참조한다

-- DDL 은 자동으로 commit이 일어난다? DCL?

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;
delete depts; -- error, (YOU.EMPS_DEPTID_FK) violated, integrity 무결성, 참된 데이터가 있게 한다.
-- 100번부서를 지우면 거기서 일하는 사람은 존재하지 않기 때문에 거짓이 된다
-- 무결성 때문에 레코드 삭제를 거부한다
insert into depts values(100, 'Marketing'); -- error, (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null, 'Marketing'); -- error, cannot insert NULL
insert into emps values(501, null, 'good@gmail.com', 6000, 100); -- error, annot insert NULL
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); -- error, (YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200); -- error, parent key not found, 200번 부서는 존재하지 않는다

drop table emps cascade constraints; -- table 삭제
select constraint_name, constraint_type, table_name
from user_constraints;

-- system user
grant all on hr.departments to you; -- hr.departments(department_id)를 조회할 수 있게 권한을 부여한다.

-- you user
drop table employees cascade constraints;
create table employees( -- 테이블에서 프라이머리 키 제약조건은 하나만 존재한다
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
-------------------------------------------------------------------------------------
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu(
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); -- gu가 del되면 dong도 같이 del 하겠다

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); -- gu가 del되면 dong은 null 하겠다
-- auto commit
-- insert into 부터 트랜지션 시작
insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong; -- 데이터 복제

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit; 
-------------------------------------------------------------------------------------

-- disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); -- error, parent key not found, 제약조건을 잠재우고 실행가능하지만 거짓데이터 이다.

alter table b disable constraint b_aid_fk; -- 제약조건을 잠재운다
insert into b values(32, 9);

alter table b enable constraint b_aid_fk; -- error, parent keys not found, fk 를 깨운다
alter table b enable novalidate constraint b_aid_fk; -- 데이터 검증 없이 fk를 깨운다

insert into b values(33, 8); -- error, parent key not found
-------------------------------------------------------------------------------------
drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments

select * from sub_departments;
-------------------------------------------------------------------------------------
drop table users cascade constraints;

create table users(
user_id number(3));

desc users

alter table users add(user_name varchar2(10));
desc users

alter table users modify(user_name number(7));
desc users

alter table users drop column user_name;
desc users
-------------------------------------------------------------------------------------
insert into users values(1);

alter table users read only; -- 읽기만 가능하게 바꾼다
insert into users values(2); -- error, update operation not allowed

alter table users read write; -- 쓰기가 가능하게 바꾼다
insert into users values(2);

commit;