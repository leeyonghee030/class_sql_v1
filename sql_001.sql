-- DML 사용하기 

SELECT * FROM student;
-- 데이터 추가  (한건)
INSERT INTO student (student_id, name, greade, major, phone) VALUES (1001,'김철수',2,'컴퓨터공학','010-1111-2222');

-- 데이터 추가 (여러건 )
INSERT INTO student (student_id, name, greade, major, phone) 
		VALUES (1002,'박진영',2,'경영학','010-1111-2222'),
        (1003,'이영희',2,'전자공학','010-1111-2222'),
        (1004,'금잔디',2,'생명공학','010-1111-2222');
        
-- DML 데이터 조회 - SELECT
SELECT name,major FROM student;
SELECT name,major FROM student WHERE grade = 2;
 
 ALTER TABLE student RENAME COLUMN greade TO grade;
 
 -- 데이터 수정 DML - UPDATE
 -- 수정 질의어에서 WHERE 절없으면 전체 행 (row)을 수정하라는 명령어라서 가능한 정대 WHERE 없이 사용하면 안된다 
 -- WHERE이 없으면 전체가 변경된다 (가능한 WHERE 구문없는 UPDATE는 사용하지말자)
 UPDATE student SET major = '컴공' WHERE student_id = 1001; 
 
 UPDATE student SET grade = 4 WHERE student_id = 1001;
 
 -- DML 데이터 삭제 DML -DELETE password123
 -- 삭제 질의어를 사용할떄도 반드시 where 절 두번 세번 확인하자 
 -- 특이 사항  삭제 퀴리는 없는 데이터 삭제 요청을 하더라도 오류거 아니다
 DELETE FROM student WHERE name = '박진영';  -- 이름으로 안되나 ??
 DELETE FROM student WHERE student_id = 1;
  DELETE FROM student WHERE grade = 4;

 