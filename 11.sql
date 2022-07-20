-- view
-- view는 쿼리의 별명이다, 데이터를 담는 것이 아니라 보여주는 것이다
-- view 는 read only로 만드는 것이 좋다

drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80

select * from empvu80; -- 아래 코드를 간단하게 쓸 수 있다.

select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
create or replace view empvu80 as -- 이미 있으면 덮어쓰고 없으면 새로 만든다
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
----------------------------------------------------------------------
 drop table teams;
 drop view team50;
 
 create table teams as
    select department_id team_id, department_name team_name
    from departments;

create view team50 as
    select *
    from teams
    where team_id = 50;
    
select * from team50;
    
select count(*) from teams;
insert into team50
values(300, 'Marketing');
select count(*) from teams;

create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; -- view 의 제약조건

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Sipport'); -- error, view WITH CHECK OPTION where-clause violation

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; -- create or replace view: DDL

insert into empvu10 values(501, 'abel', 'Sales'); -- error, cannot perform a DML
--------------------------------------------------------------------------------
drop sequence 