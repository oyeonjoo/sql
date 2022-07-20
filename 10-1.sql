-- DDL(Data Definition Language)

drop table hire_dates2;

create table hire_dates2(
id number(8),
hire_date date default sysdate);

select tname
from tab;

-- 과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates2 values(1, to_date('2025/12/21'));
insert into hire_dates2 values(2, null);
insert into hire_dates2(id) values(3);

commit;

select *
from hire_dates2;
-------------------------------------------------------------------------------------
create user you2 identified by you2;
grant connect, resource to you2;

select tname
from tab;

create table depts2(
department_id number(3) constraint depts2_detid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;
