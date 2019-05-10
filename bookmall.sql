show tables;

desc book;
desc cart;
desc category;
desc member;
desc orders;
desc order_book;


-- category insert
insert into category values(null,'예술');

-- category select 
select no, name from category;

select no from category where name = '예술';
-- book insert
insert into book values(null,(select no from category where name = '예술'),'현대의 미술',20000);
-- book select
select b.no,c.name,b.title,b.price from book b, category c where b.cate_no = c.no; 
-- book update
update book set cate_no = (select no from category where name = '과학'), title = '물리의정석',price = 15000 where no = 1;
-- book delete
delete from book where no = 3;

-- test 
select * from book;

-- member select
select no, name, phone, email from member;

-- member insert
insert into member values(null,'강수진','010-5555-4444','aje234@gmail.com',password('1234'));
insert into member values(null,'박둘리','010-5645-3443','ajdsf34@gmail.com',password('1234'));
-- member update
update member set name = '수지니', phone = '010-2222-5555', email = 'tgif@gamil.com', password = password('12') where no = 2;
-- member delete
delete from member where no = 1;

-- test
select * from member;
select * from book;
-- cart insert
insert into cart values(1,2,2,(select price*2 from book where no = 1));
insert into cart values(6,2,1,(select price*1 from book where no = 6));
insert into cart values(6,4,2,(select price*1 from book where no = 6));
insert into cart values(8,5,1,(select price*1 from book where no = 8));
-- cart select
select b.title,m.name,c.cnt,c.price from book b, member m, cart c where b.no = c.book_no and m.no = c.member_no and c.member_no = 2;
-- cart delete
delete from cart where book_no = 6 and member_no =4;
-- test
select * from cart;

select last_insert_id();

-- orders insert
insert into orders values(null,4,(select concat(date_format(now(),'%Y%m%d'),'-',lpad((select count(*)from orders a where order_date = curdate())+1,5,'0'))),50000,'서울시 성북구 길음동',now());


select concat(date_format(now(),'%Y%m%d'),'-',lpad((select count(*)from orders where  DATE(order_date) = DATE(now()))+1,5,'0'));


select if((select count(*)from orders where order_date = curdate())=0,lpad('1',5,'0'),lpad((select count(*)from orders where order_date = curdate())+1,5,'0'));
-- orders select
select order_no,concat((select b.title from order_book ob, book b where ob.book_no = b.no and ob.order_no = (select no from orders where member_no = 6) order by b.title limit 0,1),' 외 ',(select count(*) from orders o where member_no = 6)),date_format(order_date,'%Y-%m-%d %H:%i') as 'order_date',order_price,receive  from orders where member_no = 6 order by no;

select o.order_no,b.title,date_format(o.order_date,'%Y-%m-%d %H:%i')as 'order_date',o.order_price,o.receive
from orders o, order_book ob, book b
where o.no = ob.order_no
and ob.book_no = b.no
and o.member_no = 6
group by o.no
;
select * from order_book;
select * from orders;
-- concat((select b.title from order_book ob, book b where ob.book_no = b.no and ob.order_no = (select no from orders where member_no = 4) order by b.title limit 0,1),'외',(select count(*) from orders o where member_no = 4))
select * from orders;
select no from orders where member_no = 6;
select count(*) from orders o where member_no = 4;
select no
from orders
where member_no = 4;

select * from orders;
-- orders delete

-- order_book insert
insert into order_book values(1,8,1);
-- order_book select
select ob.order_no,b.title,b.price,ob.cnt from order_book ob, book b where ob.book_no = b.no and ob.order_no = 1;

select * from order_book;
-- order_book delete
select * from orders;
select * from order_book;

select last_insert_id();
