-- inner join 특수한 향태 (coss join)

select * from tb_student
join tb_grade; -- join (inner join 의미)
-- on 조건식  -- on 조건식이 없는 상태는 크로스 조인이 됨
select count(*) from tb_student
join tb_grade; -- 학생 수 * 등급 수 = 로 나옴

select count(*) from tb_grade;
select count(*) from tb_student;

select tb_student.no, tb_student.name, tb_student.grade,tb_grade.grade 
from tb_student
inner join tb_grade 
on tb_grade.grade = tb_student.grade;

-- 별칭
select s.no, s.name, s.grade,g.grade 
from tb_student s
inner join tb_grade g
on g.grade = s.grade;

-- outer join 방향 먼저 개념 잡기 

select s.no, s.name, s.grade,g.grade 
from tb_student s
left join tb_grade g
on g.grade = s.grade;

select s.no, s.name, s.grade,g.grade 
from tb_grade g
left join tb_student s
on g.grade = s.grade;

-- 추가 테이블 생성 및 데이터 수정 및 추가


CREATE TABLE tb_club (
    club_id   INT PRIMARY KEY,
    club_name VARCHAR(20)
);

INSERT INTO tb_club VALUES (1, '축구부'), (2, '밴드부');

ALTER TABLE tb_student ADD COLUMN club_id INT;
ALTER TABLE tb_student ADD FOREIGN KEY (club_id) REFERENCES tb_club(club_id);

UPDATE tb_student SET club_id = 1 WHERE no = 20170001;  -- 조이
UPDATE tb_student SET club_id = 2 WHERE no = 20170020;  -- 앤드류
UPDATE tb_student SET club_id = 1 WHERE no = 20180800;  -- 데이지
-- 다나, 스카이, 제임스는 동아리 없음 (club_id 가 NULL)

SELECT * FROM tb_student;


-- 학생 정보 + 등급 점수 + 동아리 이름 

select s.* , g.score, c.club_name
from tb_student s
left join tb_grade g
on s.grade = g.grade
left join tb_club c
on s.club_id = c.club_id;

-- left join 연습  학생 명단이 다 나와야합니다 

select *
from tb_student s
left join tb_grade g
on s.grade = g.grade;

-- right join 연습 상황 모든 등급이 나와야합니다 

select *
from tb_student s
right join tb_grade g
on g.grade = s.grade;

select s.name, s.age, s.grade, g.score
from tb_student s
inner join tb_grade g
on s.grade = g.grade
where s.grade in ('A','B');

select s.name, s.grade,g.score
from tb_student s
left join tb_grade g
on s.grade = g.grade
where s.gender = 'M';

select s.name, g.grade,g.score
from tb_student s
right join tb_grade g 
on s.grade = g.grade
where g.score >= 60;


