-- view
-- view�� ������ �����̴�, �����͸� ��� ���� �ƴ϶� �����ִ� ���̴�
-- view�� read only�� ����� ���� ����
-- hr user
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80

select * from empvu80; -- �Ʒ� �ڵ带 �����ϰ� �� �� �ִ�.

select * from (
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
create or replace view empvu80 as -- �̹� ������ ����� ������ ���� �����
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
----------------------------------------------------------------------
 drop table teams;
 drop view team50;
 
 create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;

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
    with check option; -- view �� ��������

insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support'); -- error, view WITH CHECK OPTION where-clause violation

create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; -- create or replace view: DDL

insert into empvu10 values(501, 'abel', 'Sales'); -- error, cannot perform a DML
--------------------------------------------------------------------------------
drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;