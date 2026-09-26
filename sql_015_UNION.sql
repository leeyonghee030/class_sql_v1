DROP DATABASE IF EXISTS union_practice;
CREATE DATABASE union_practice;
USE union_practice;

-- 재학생과 졸업생
CREATE TABLE students (
    id    INT         PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE alumni (
    id    INT         PRIMARY KEY AUTO_INCREMENT,
    name  VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

INSERT INTO students (name, email) VALUES
('김철수', 'chulsoo@example.com'),
('이영희', 'younghee@example.com'),
('박민수', 'minsoo@example.com');

INSERT INTO alumni (name, email) VALUES
('김철수', 'chulsoo@example.com'),    -- 재학생과 중복
('최영수', 'youngsoo@example.com'),
('이영희', 'younghee@example.com');   -- 재학생과 중복

-- uinion all (전부 이어 붙인다)
select name, email from students
union all 
select name, email from alumni;

-- union (중복제거 ) (중복조건 이름, 이메일)
-- 선택한 모든 컬럼의 값이 같으면 중복으로 판단한다
-- 단, 하나라도 값이 다르면 중복이 아니다 
select name, email from students
union 
select name, email from alumni;

-- 어느것을쓸까?
-- union all  (중복이 없다고 확실할때)
-- 주문과 환불 처럼 성격이 다른 데이터를 합칠떄 
-- union보다 빠르다 장점

-- union (중복을 없애야 할 떄)
--      중복을 찾기위해 전체를 정렬후 비교를 하기떄문에 느리다

-- union에 규칙
-- 1. 컬럼수가 값아야한다
-- 2. 타입이 달라도 오류가 나지 않는다 (조심해야 될 부분)
-- 3. 컬럼명은 첫번쨰 select 의 기준이 된다
-- 4. order by는 마지막에 하나 
-- 5. order by가 없으면 순서는 보장 되지 않음 

