

select * from dept_manager;
select * from dept_emp;
select * from employees;
select * from departments ;

-- 부서 번호 부서명 사원번호 이름   to_date = '9999-01-01
select d.dept_no, d.emp_no,e.last_name
from  dept_manager d
join employees e
on d.emp_no = e.emp_no and d.to_date = '9999-01-01';

select d.dept_no, ds.dept_name, d.emp_no,d.last_name
from departments ds
join (select d.dept_no, d.emp_no,e.last_name
from  dept_manager d
join employees e
on d.emp_no = e.emp_no and d.to_date = '9999-01-01') d
on ds.dept_no = d.dept_no;

-- 부서 번호 사원번호 이름   to_date = '9999-01-01

select d.dept_no, e.emp_no, e.last_name
from employees e
join dept_emp d
on e.emp_no = d.emp_no and d.to_date = '9999-01-01' and e.emp_no not in (select emp_no
from dept_manager d
where emp_no is not null);


-- 1) 부서장 조회 (작성하신 인라인 뷰 방식 유지)
SELECT 
    ds.dept_no AS `부서 번호`,
    ds.dept_name AS `부서명`,
    '부서장' AS `사원 구분`,         -- 3번째 위치로 변경
    d.emp_no AS `사원 번호`,
    d.last_name AS `사원 이름`
FROM departments ds
JOIN (
    SELECT d.dept_no, d.emp_no, e.last_name
    FROM dept_manager d
    JOIN employees e ON d.emp_no = e.emp_no 
    WHERE d.to_date = '9999-01-01'
) d ON ds.dept_no = d.dept_no

UNION ALL -- UNION에서 UNION ALL로 변경

-- 2) 일반 사원 조회 (작성하신 인라인 뷰 방식 유지)
SELECT 
    ds.dept_no,
    ds.dept_name,
    '일반 사원',                     -- '직원' -> '일반 사원'으로 변경
    d.emp_no,
    d.last_name
FROM departments ds
JOIN (
    SELECT d.dept_no, e.emp_no, e.last_name
    FROM employees e
    JOIN dept_emp d ON e.emp_no = d.emp_no 
    WHERE d.to_date = '9999-01-01' 
      AND e.emp_no NOT IN (
          SELECT emp_no 
          FROM dept_manager 
          WHERE to_date = '9999-01-01' -- ★ 현재 매니저만 제외하도록 to_date 조건 추가
            AND emp_no IS NOT NULL    -- IS NOT NULL 유지
      )
) d ON ds.dept_no = d.dept_no
ORDER BY `부서 번호` ASC, `사원 구분` ASC, `사원 번호` ASC;



SELECT 
    ds.dept_no AS `부서 번호`,
    ds.dept_name AS `부서명`,
    '부서장' AS `사원 구분`,
    d.emp_no AS `사원 번호`,
    e.last_name AS `사원 이름`
FROM dept_manager d
JOIN employees e ON d.emp_no = e.emp_no
JOIN departments ds ON d.dept_no = ds.dept_no
WHERE d.to_date = '9999-01-01';

select d.dept_no, ds.dept_name, d.emp_no,d.last_name
from departments ds
join (select d.dept_no, d.emp_no,e.last_name
from  dept_manager d
join employees e
on d.emp_no = e.emp_no and d.to_date = '9999-01-01') d
on ds.dept_no = d.dept_no;


