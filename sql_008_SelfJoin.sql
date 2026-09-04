DROP DATABASE IF EXISTS self_join;
CREATE DATABASE self_join;
USE self_join;

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    department    VARCHAR(20) NOT NULL,
    salary        INT NOT NULL,        -- 연봉, 만원 단위
    manager_id    INT                  -- 상급자의 employee_id. 없으면 NULL
);

INSERT INTO employees VALUES
(1, '김민수', '경영', 9000, NULL),
(2, '박지훈', '개발', 7000, 1),
(3, '이서연', '영업', 6500, 1),
(4, '최준호', '개발', 5000, 2),
(5, '정하윤', '개발', 5500, 2),
(6, '강도현', '영업', 4800, 3);

SELECT * FROM employees;

-- 1. 계층형 구조 조회 셀프조인 활용
-- 즉 각 직원에 살급자 이름을 조회

select e.* , m.employee_name as 상급자
from employees e
left join employees m
on e.manager_id = m.employee_id;

-- 셀프 조인은 inner join 으로 변경해보기 

select e.* , m.employee_name as 상급자
from employees e
join employees m
on e.manager_id = m.employee_id;

-- 상급자의 차상급자까지 찾기 

select e.*, m.employee_name as 상급자, mm.employee_name as 차상급자
from employees e
left join employees m
on e.manager_id = m.employee_id
left join employees mm
on m.manager_id = mm.employee_id;


-- 용도 2 같은 테이블 안에서 서로 다른행을 비교할수있다 
--  같은 부서에서 
select e.employee_name as 직원,e.salary as 내연봉 , h.employee_name as 더높은사람, h.salary as높은사람연봉
from employees e
join employees h
on e.department = h.department and e.salary < h.salary
order by 1,2;

-- on 조건을 두개 써야하는 이유 
-- 1. 만약 join 연산에서 on 졸이 없으면 coss join이됨

select count(*)
from employees e
join employees m;

-- 2. on 절에서 부서만 있는 경우 확인 
select *
from employees e
join employees h
on e.department = h.department
where e.department = '개발'
order by 1;

-- 3 on절에 연봉만 있는경우 
select *
from employees e
join employees h
on e.salary < h.salary
where e.employee_name = '강도현'
order by 1;

-- on 과 where 에서 어디에 조건을 걸어야 타당하나
-- inner join은 같다
-- left join은 다르다 
select e.employee_name as 직원,e.salary as 내연봉 , h.employee_name as 더높은사람, h.salary as높은사람연봉
from employees e
join employees h
on e.department = h.department 
where e.salary < h.salary
order by 1,2;

-- 각 직원의 (이름, 부서, 상급자 이름, **상급자의 부서)**를 조회하세요. 상급자가 없는 직원도 결과에 나와야 합니다.

select * from employees;

select e.employee_name as 이름 ,e.department as 부서, m.employee_name as 상급자이름, m.department as 상급자의부서
from employees e
left join employees m
on e.manager_id = m.employee_id;

-- 각 직원의 이름과 **그 직원의 직속 부하 직원 이름**을 조회하세요. 부하 직원이 없는 직원도 결과에 나와야 합니다.
select m.employee_name as 직원이름 ,m.department as 직원부서, e.employee_name as 부하직원이름, e.department as 부하직원의부서
from employees m
left join employees e
on m.employee_id = e.manager_id;

