-- 실습 준비 

-- insert_practice;  DB 이미 있으면 통쨰로 삭제한다.
-- IF EXISTS "한건 이라도 있으면 이라는조건
-- 만약  insert_practice DB 없다면 여기서 바로 스크립트가 오류가 나서 멈춤 
DROP DATABASE IF EXISTS insert_practice;

CREATE DATABASE insert_practice;

-- 앞으로 모든 명령을 insert_practice 데이터 베이스 대상으로한다 .
USE insert_practice;

-- student 테이블 생성

CREATE TABLE student (
	student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    grade INT NOT NULL,
    major VARCHAR(50) NOT NULL DEFAULT '미정'
);

-- 1번 한건씩 넣기

INSERT INTO student (student_id, name, grade, major)
VALUES (1, "홍길동",3,"컴퓨터공학과");

INSERT INTO student (student_id, name, grade, major)
VALUES (2, "김철수",4,"전자공학과");
INSERT INTO student (student_id, name, grade, major)
VALUES (3, "이구구",2,"경영학과");

SELECT * FROM student;

INSERT INTO student (student_id, name, grade, major)
VALUES (4, "김박수",1,"전자공학과"),
		(5, "이신야",2,"컴퓨터학과"),
		(6, "이박사",3,"경영학과");
        
-- 제약조건 확인 : PRIMARY KEY
INSERT INTO student (student_id, name, grade, major)
VALUES (7, "티모",3,"컴퓨터공학과"),
		(1, "티모",3,"컴퓨터공학과"),
		(8, "티모",3,"컴퓨터공학과");

-- 여러 건을 한번에 넣을떄 그 값중 하나만 중복이라도 블록 전체가 들어가지 않습니다.
-- 원자성 (Atomicity)	하나의 INSERT 문은 전부 성공하거나 전부 실패함 (ACID의 A)
SELECT * FROM student;

-- 제약 조건 2:  NOT NULL
 INSERT INTO student (student_id,name,grade)
	VALUES (9,NULL,1);
    
INSERT INTO student (student_id,grade)
	VALUES (9,1);
    
    -- 제약 조건 3 : DEFAULT
    -- 방법 1 (디폴트 값을 넣는 방법)
    INSERT INTO student (student_id,name,grade,major)
    VALUES (10,'이순신',1,DEFAULT),
			(11,'유관순',3,'전자공학과');
            
	-- 방법 2 (디폴트 값을 넣는 방법)
    INSERT INTO student (student_id,name,grade)
    VALUES (12,'길길동',1),
			(13,'박길순',3);

-- DATE 타입에 값 넣기

--  ORDER BY 에서 예약어를 이름으로 쓸려면 백틴으로 감싸야한다 `` 
-- 하지만 가능한 예약어를 사용하지말고 ,orders라고 하는게 좋다
CREATE TABLE `order`(
	id INT PRIMARY KEY,
    customer_note VARCHAR(50),
    product_name VARCHAR(20),
    quantity INT NOT NULL,
	order_date DATE
);
-- 따음표로 감싼 문자열
INSERT INTO `order` (id, customer_note,product_name,quantity,order_date)
	VALUES (1, '빠른배송','신라면',2,'2026-09-01');
    
    -- 방법 2  하이픈 없는 숫자 
    INSERT INTO `order` (id, customer_note,product_name,quantity,order_date)
	VALUES (2 ,'문앞배송','신라면',2,20260901);
    
    -- 잘못된 날짜는 걸러집니다.
    -- 1년 12개월인데 만약 22월을 넣으면 어떻게 되는지 확인해보자
    INSERT INTO `order` (id, customer_note,product_name,quantity,order_date)
	VALUES (1, '빠른배송','신라면',2,20262201);

-- AUTO_ INCREMENT 
-- 새행을 넣을떄 마다 하나씩 자종으로 올려주는 기능 
-- 주로 Pk이다
CREATE TABLE customer(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    address VARCHAR(100) NOT NULL
    );
    
    SELECT * FROM customer;
    
    -- id 컬럼을 적지않아도 됩니다
    INSERT INTO customer (name, email, address)
		VALUES ('이수수','123@naver.com','부산시진구'),
			('박진수','234@naver.com','부산시중구'),
            ('진자자','345@naver.com','부산시남구');
            
	-- AUTO_INCREMENT 에 알아 두면 좋은 두가지 
    -- 직접 값을 지정하면 그 다음 번호가 이어집니다 .
    INSERT INTO customer (id,name, address)
		VALUES (18,'이가가','부산시진구');
        
	INSERT INTO customer (name, email, address)
		VALUES ('구구가','123@naver.com','부산시진구');
        
	-- 삭제 해도 번호는 돌아오지 않습니다.
    DELETE FROM customer WHERE id = 11;
    
    INSERT INTO customer (name, email, address)
		VALUES ('이그가','123@naver.com','부산시진구');
        
        CREATE TABLE post (
    post_id    INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(100) NOT NULL,
    content    TEXT,
    writer     VARCHAR(20) NOT NULL,
    view_count INT DEFAULT 0,
    created_at DATETIME DEFAULT NOW()  -- NOW() 사용 가능
);
ALTER TABLE post ADD  email VARCHAR(20) UNIQUE;
INSERT INTO post (title,content,writer,view_count,email)
		VALUES ('t','cc','ww',10,'ee@naver.com');
        
        
	INSERT INTO customer(id,name,email,address)
		VALUES (1,'박영희','1233@naver.com','서울시강남구'),
				(2,'이상구','1223@naver.com','경기도성남시'),
				(3,'김잔구','12223@naver.com','부산시영도구'),
                (4,'이장구','1232323@naver.com','경기도수원시');
		
	-- 샘플데이터 추가저장
        INSERT INTO customer(name,email,address)
		VALUES ('홍길동','1233@naver.com','부산시진구');

SELECT * FROM customer;
-- 1. 서울시 강남구에 사는 고객 조회 (컬럼 id, name, adress)
SELECT id,name,address FROM customer WHERE address = '서울시강남구';
-- 2. email이 NULL인고객 조회
SELECT * FROM customer WHERE email is NULL;
-- 3. 이름이 박영희인 고객 조회
SELECT * FROM customer WHERE name = '박영희';

--  복합 조건
-- 서울시에 사는 ID 3이하 고객 조회
SELECT * FROM customer WHERE address LIKE '서울시%' AND id <= 3;

-- 5. 서울시에 사는 고객이 아닌 사람들만 조회 
SELECT * FROM customer WHERE address  NOT LIKE '서울시%';

-- 6. 서울시 또는 경기도에 사는 고객 조회 
SELECT * FROM customer WHERE address LIKE '서울시%' OR address LIKE '경기도%';

-- 특수 연산자 
-- ID가 2~5 번인 고객 조회
-- 양쪽 끝을 포함한다 
 SELECT * FROM customer WHERE id BETWEEN 2 AND 5;
 
 -- 강남구 , 서초구, 송파구 에사는 고객만 조회
 SELECT * FROM customer WHERE address IN ('서울시강남구','서울시서초구','서울시송파구');
 
-- 샘플 데이터 2 
-- COMMENT '학번' 주석? 
CREATE TABLE student2 (
    student_id INT PRIMARY KEY COMMENT '학번',
    name VARCHAR(50) NOT NULL COMMENT '이름',
    grade INT NOT NULL COMMENT '학년',
    major VARCHAR(100) NOT NULL COMMENT '학과'
)COMMENT = '학생 정보 테이블';

SELECT * FROM student2;
SHOW FULL COLUMNS FROM student2;
-- COMMENT 는 컬럼과 테이블에 설명을 달아두는 기능입ㄴ디ㅏ 
-- 동잗에는 영향을 주지않지만 나중에 다른 사람이 볼떄 도움이 됩니다 


INSERT INTO student2 (student_id, name, grade, major)
VALUES
  (1,  '김철수', 1, '컴퓨터공학과'),
  (2,  '박영희', 2, '경영학과'),
  (3,  '이민수', 4, '전자공학과'),
  (4,  '홍길동', 1, '디자인학과'),
  (5,  '임성민', 3, '컴퓨터공학과'),
  (6,  '한지원', 2, '경영학과'),
  (7,  '박준형', 4, '전자공학과'),
  (8,  '김민지', 1, '디자인학과'),
  (9,  '이현수', 3, '컴퓨터공학과'),
  (10, '정미경', 2, '경영학과'),
  (11, '김성진', 4, '전자공학과'),
  (12, '임승환', 1, '디자인학과'),
  (13, '최수빈', 2, '컴퓨터공학과'),
  (14, '오지훈', 3, '경영학과'),
  (15, '윤서아', 2, '전자공학과'),
  (16, '장도윤', 4, '디자인학과');

SELECT * FROM student2;

-- student 테이블에서 학과가 '컴퓨터공항과'인  학생들의 이름과 학번을 조회하시오
SELECT name,student_id 
FROM student2
WHERE major = '컴퓨터공학과';

-- 1. grade가 3인 학생들 조회하기 (컬럼을 지정하지 않으면 전부 출력)
SELECT * FROM student2 WHERE grade = 3;
-- 2. 이름이 홍길동인 학생 조회하기
SELECT * FROM student2 WHERE name = '홍길동';
-- 3. 학번이 1부터 10까지인 학생들 조회하기 (BETWEEN)
 SELECT * FROM student2 WHERE student_id BETWEEN 1 AND 10;
-- 4. 학과가 컴퓨터공학과이면서 학년이 2학년인 학생들만 조회하기
SELECT * FROM student2 WHERE grade = 2 AND major = '컴퓨터공학과';
-- 5. 학과가 컴퓨터공학과이거나 학년이 2학년인 학생들 조회하기
 SELECT * FROM student2 WHERE grade =2 OR major = '컴퓨터공학과';
 
-- 6. 학생 이름이 홍길동이 아닌 학생들 조회하기
SELECT *
 FROM student2 
 WHERE name NOT LIKE '홍길동'; 
-- 7. 학년이 2학년 이상인 학생들 조회하기
SELECT *
 FROM student2 
 WHERE grade >= 2;
-- 8. 학년이 2학년 미만인 학생들 조회하기
SELECT * FROM student2 WHERE grade < 2;
-- 9. 학년이 1학년, 3학년, 4학년인 학생들 조회하기 (IN 사용)
SELECT * FROM student2 WHERE grade IN (1,3,4);
-- 10. 이름이 김씨인 학생들 조회하기 (LIKE 사용)
SELECT * FROM student2 WHERE name LIKE '김%';
-- 11. 컴퓨터공학과이거나 경영학과이면서, 2학년인 학생들 조회하기 (괄호 주의)
 SELECT * FROM student2 WHERE major ='컴퓨터공학과' OR (major = '경영학과' AND grade = 2);
 
