-- DDL
create table member(
	no int not null,
    email varchar(50) not null default 'a@putyouremailaddress.com',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    primary key(no)
);
drop table member;
desc member;

insert into member(passwd,name,dept_name) values(password('1234'),'강수진','시스템개발팀');
select * from member;

ALTER TABLE member ADD juminbunho char(13) not null;
alter table user drop juminbunho;
alter table member add juminbunho char not null after no;

ALTER TABLE member ADD join_date datetime not null;
alter table member change no no int unsigned not null auto_increment;

alter table member change dept_name departments_name varchar(25);
alter table member change name name varchar(10);

alter table member rename user;

select * from user;

-- DCL(insert)
insert into user values(null,'',password(12345),'수지니3','인사팀',now());
insert into user(email,join_date,name,departments_name,passwd) values('',now(),'sujini','총무팀',password(12));

update user set join_date = (select now()) where no = 1;

update user set join_date = now(), name='kangsujin' where no =1;

delete from user where no = 2;