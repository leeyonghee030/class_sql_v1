
DROP DATABASE IF EXISTS alias_practice;
CREATE DATABASE alias_practice;
USE alias_practice;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    score INT
);

INSERT INTO students VALUES (1, '홍길동', 75), (2, '김철수', 55);

SELECT * FROM students;

-- 1. 별칭
 
 select 100 as student_id , '반장' as title;
 
 -- 2. 테이블에 별칭 주기
select s.name
from students as s;

-- 3 사용자 변수란 ?
-- mysql 에서 @ 기호를 사용하여 사용자 정의 변수를 선언하고 사용할수있다
-- 이변수는 세션 단위로 유지되며, 간단한 데이터 저장과 조건 확인에 유용하다

-- 1 변수에 값 저장 
SET @score = 85;

-- 2 변수 출력 
select @score as 점수;

-- 주의점 
--  선언하지 않은 변수를 사용 하면 NULL이다
select @never_set; -- 오류가 발생하지 않음 (변수명 오타 조심)

-- 3 변수에 퀴리 결과 저장하기
-- 문볍 (selct 컬럼 in 변수 from 테이브 where 조건;)
--  select .. into 이 문법은 퀴리 결과를 변수에 저장할수있음

-- 테이블에서 점수를 가져와서 변수에 저장 가능
select score into @student_score from students where id = 1;

--  확인 
select @student_score as 점수;
-- 단, 컬럼과 변수의 개수가 맞아야하며, 앞에서 부터 순서대로 짝지어진다

select name, score into @n, @s from students where id = 2;

select @n as 이름 , @s as 점수;

-- if 함수 사용하기 
select name ,score , if(score >= 60, 'PASS', 'FAIL') as result
from students;