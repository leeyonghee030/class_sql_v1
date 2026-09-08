DROP DATABASE IF EXISTS group_practice;
CREATE DATABASE group_practice;
USE group_practice;

DROP TABLE IF EXISTS tb_student;
-- IF EXISTS : 해당 테이블이 존재할 경우에만 삭제하도록 조건을 거는 옵션

CREATE TABLE tb_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    class CHAR(1) NOT NULL,
    score INT NOT NULL
);

INSERT INTO tb_student (name, class, score) VALUES
('김민수', 'A', 85),
('이서연', 'B', 75),
('박지훈', 'A', 65),
('최예린', 'A', 70),
('정하윤', 'B', 95),
('강동현', 'C', 88),
('오소연', 'C', 92),
('한지민', 'B', 78),
('윤태양', 'A', 85),
('문채원', 'C', 90);

select * from tb_student order by class;

-- 1. 클래스 별  평균을 구해보자 
select class, round(avg(score),2) as 평균
from tb_student
group by class;

-- 2 그룹 바이 이후에 평균 80점 이상만  출력
select class, round(avg(score),2) as 평균
from tb_student
group by class
having avg(score) > 80;
-- avg(score) or 평균 

-- 3. 각 클래스별 최고및 최저 점수
select class, max(score) as 최고점수, min(score) as 최저점수
from tb_student
group by class;

-- 4. select 절에 비집계 컬럼을 넣어보자
select class, max(score) as 최고점수, min(score) as 최저점수 , name
from tb_student
group by class;

DROP TABLE IF EXISTS tb_employees;

CREATE TABLE tb_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);

INSERT INTO tb_employees (name, department, salary) VALUES
('김도현', '영업',   48000000),
('이소영', '영업',   55000000),
('박지영', '마케팅', 50000000),
('최민재', '마케팅', 45000000),
('강민호', '인사',   35000000),
('오수진', '인사',   40000000),
('정우성', '개발',   75000000),
('한지은', '개발',   65000000),
('윤서현', '개발',   72000000),
('문태준', '개발',   68000000),
('신동엽', '영업',   52000000),
('장미란', '영업',   51000000),
('황아영', '마케팅', 47000000),
('류현진', '인사',   43000000),
('김나영', '인사',   39000000);

-- 1. 부서별 평균 급여
select department as 부서, round(avg(salary),2) as 부서볊평균급여
from tb_employees
group by  department;

-- 2. 부서별 평균 급여가 5000만원 이상인 부서  출력
select department as 부서, round(avg(salary)) as 부서볊평균급여
from tb_employees
group by  department
having avg(salary) >= 50000000;

-- 3 부서별 최고 급여 출력
select department, max(salary) as 최고연봉
from tb_employees
group by department;

select * from tb_employees;
-- 직원이 4명 이상인 부서 출력 
select department, concat(count(department),'명') as 부서인원수
from tb_employees
group by department
having count(department) >= 4;

-- 부서별 평균 급여와 직원 수를 출력하시오 
select department, round(avg(salary))as 평균급여 , concat(count(*),'명') as 인원수
from tb_employees
group by department;


select * from tb_employees;

-- where : 묶기전에 걸러낸다
-- having : 그룹으로 걸러낸다 

select department,round(avg(salary)) as 부서별평균
from tb_employees
where salary >= 50000000
group by department;
-- 5000만원 미만인 직원을 제외하고 부서 평균 구하기

select department,round(avg(salary)) as 부서별평균
from tb_employees
group by department
having avg(salary) >= 50000000;
-- 부서 평균 금액이 5000만원 이상은 부서 

select * from tb_student;

select class, concat(count(*),'명') as 반인원, round(avg(score),2) as 반평균
from tb_student
group by class 
having count(*) >= 4;

select department, max(salary)as 최고급여, min(salary) as 최저급여,  max(salary) - min(salary) as 급여차이
from tb_employees
group by department
having max(salary) - min(salary) >= 10000000;



select distinct department from tb_employees order by department; 

-- 컬럼이 여러개만 조합 기준이 됩니다
select distinct department, salary from tb_employees order by department; 

select * from tb_employees 
limit 3 offset 4; 
-- 4 다음부터  3개 

-- row가 15개인  5개씩 보여주는 페이지
-- 1페이지
select * from tb_employees 
limit 5 offset 0; 

-- 2페이지
select * from tb_employees 
limit 5 offset 5; 

-- 3페이지
select * from tb_employees 
limit 5 offset 10; 

-- 15 개 씩 5개씩 한 화묜에 출력한다면 페이지 블록 3개 

