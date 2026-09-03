
-- 관계 차수 
DROP DATABASE IF EXISTS relation_practice;
CREATE DATABASE relation_practice;
USE relation_practice;
-- 1대 1 관계
create table tb_persion(
	persion_id int auto_increment, 
    name varchar(50) not null,
    primary key (persion_id)
);

create table tb_passport (
	passport_id INT auto_increment ,
    passport_number varchar(20) not null,
    persion_id int unique, -- unique 가 1대 1을 만들어준다
    primary key (passport_id),
    foreign key (persion_id) references tb_persion(persion_id)
);

insert into tb_persion (name)
values ('홀길동'),
		('김영희'),
		('이철수');
        
insert into tb_passport (passport_number, persion_id)
values ('p123',1),
		('p456',2),
		('p789',3);        
        
select * from tb_persion;
select * from tb_passport;
        
	-- fk 외래키에 unoque 되어있어 1대1 관계를 보장한다 
insert into tb_passport (passport_number, persion_id) 
values ('p100',1);
-- Error Code: 1062. Duplicate entry '1' for key 'tb_passport.persion_id'

-- 1대 n 관계
create table tb_customer (
	customer_id int auto_increment,
    name varchar(50) not null,
    primary key (customer_id)
    );
    
create table tb_order(
	order_id int auto_increment,
    product_name varchar(50) not null,
    customer_id int , -- 유니크가없다 1 대 n 구조다 
    primary key (order_id),
    foreign key (customer_id) references tb_customer (customer_id)
);
    
select * from tb_customer;
select * from tborder;

insert into tb_customer (customer_id,name) 
values (1, '박민지'),
		(2, '이구구');
        
        insert into tb_order (order_id,product_name,customer_id) 
values  (201, '노트북',1),
		(202, '마우스',1),
		(203, '키보드',2);


-- 실습3 N대 M 만들기 
create table tb_student(
	student_id int auto_increment,
    name varchar(50) not null,
    primary key (student_id)
);

create table tb_course(
	course_id int auto_increment,
    title varchar(50) not null,
    primary key (course_id)
);

create table tb_student_course(
	student_id int,
    course_id int,
    primary key (student_id,course_id),
    foreign key (student_id) references tb_student (student_id),
    foreign key (course_id) references tb_course (course_id)
);


-- tb_student

insert into tb_student (name) 
values ('홍길동'),
		('이구구'),
        ('이바바');
        
insert into tb_course (course_id,title) 
values (101,'자바프로그래밍'),
		(102,'데이터베이스'),
        (103,'웹계발입문');
        
insert into tb_student_course (student_id,course_id)
values (1,101),
		(1,102),
        (2,102),
        (2,103),
         (3,101);
         
-- 1 대 1 
create table tb_user (
	user_id int primary key,
    user_name varchar(20)
);

create table tb_user_detail (
	user_id int primary key,
    email varchar(30),
    address varchar(30),
    foreign key (user_id) references tb_user (user_id)
);

         
-- 1대 n          
create table tb_department (
	dept_id int primary key,
    dept_name varchar(20) not null
);

create table tb_employee (
	eployee_id int primary key,
    eployee_name varchar(20) not null,
    dept_id int,
    foreign key (dept_id) references tb_department (dept_id)
);

-- n 대 m

-- 의사 테이블 

-- 환자 테이블 

-- 진료 기록 