-- 3. 주요함수

-- 3.1 집계 함수 
-- 전체 직원 수와 부서가 정해진 직원 수
select * from employees;
select count(*) from employees;
select count(department) as 부서있음 from employees;

-- count(컬럼)  null 포함하지않음
-- count(*) null 포함 


-- 문제 2 : 평균 급여, 최저 급여, 최고 급여 

select round(avg(salary),2) as 평균급여 from employees;
select min(salary) as 최저급여 from employees;
select max(salary) as 최고급여 from employees;

select round(avg(salary),2) as 평균급여, min(salary) as 최저급여, max(salary) as 최고급여 from employees;

--  2. 문자열 함수
-- 문제 3 : 이름 뒤에 님 붙이고 성씨만 뽑기
select name, concat(name,' 님') as 호칭,
	substring(name,1,1) as 성씨,
	concat(substring(name,1,1),'**') as 이름마스킹
    from employees;

-- 문제 4: 이메일을 대문자로 변경 , 앞 4글자만 
select upper(email) as 대문자,
		lower(email) as 소문자,
        substring(upper(email),1,4) as 앞4글자
from employees;

-- 3. 논리 및 조건함수
-- 문제 5 : 급여에따라서 등급을 나누기
select name, salary,
		case 
        when salary >= 3500000 then '상'
        when salary >= 3000000 then '중'
        else '하'
		end as 등급
        from employees
        order by 등급;
        -- 주의 조건에 쓴 컬럼이 값이 null이라면 바론 when 에 걸리지않고 else로 바로 떨어진다
		
        -- 만약 부서가 없으면 '미배정' 으로 출력하기 
        select name, department ,
			case
            when department is null then '미배정' else department end as 부서표시
		from employees;
        
-- 문제 6 부서가 없으면 '미배정' 으로 표시 coalesce 
select name ,department,
		coalesce(department,'미배정') as 부서표시
        -- 첫번쨰 인자 값이 null이라면 두번쨰값 반환
	from employees;
    
    -- 4 날짜 및 시간함수 
    -- 문제 7 오늘 날짜와 현재 시각을 표시
    select current_date() as 오늘 ,
		current_time() as 현재시각,
        current_timestamp() as 현재일시;
        
	-- 문제 8 번 입사 연도와 월 추출 또는 입사일 추출
    -- extract(단위 from 날짜) 단위에는YEAR, MONTH, DAT , HOUR등 들어갈수있다
    select name, hire_date,
		extract(year from hire_date) as 입사연도,
		extract(month from hire_date) as 입사월,
		extract(day from hire_date) as 입사일
    from employees
    limit 3;
    
    -- 문제 9  근속 연수 계산  (datediff)
    
    select name, hire_date,
     -- 두 날짜의 일수차이를 돌려줍니다.
		datediff(current_date,hire_date) as 근무일수
    from employees;
    
    -- 근속 년수 
    
        select name, hire_date,
     -- 두 날짜의 일수차이를 돌려줍니다.
		datediff(current_date,hire_date) as 근무일수,
		floor(datediff(current_date,hire_date) /365.0) as 근무년수
    from employees;
    -- datediff mysql 전용함수이다
    
    -- 5. 형변환 함수
    -- signed : 부호 있는 정수, 즉 음수를 담을수 있음 
    -- unsigned : 부호없는 정수 , 0 이상만  담을수있다 
    select cast('123' as signed) as 숫자변환;
    select cast('-123' as signed) as 숫자변환;
    
	select cast('123' as unsigned) as 숫자변환;
    select cast('-123' as unsigned) as 숫자변환;
    
    -- mysql에서는 문자열 + 숫자는 숫자로 계산됨 자동
    select '123' + 3 as 문자열덧셈;
    select '123' + '3' as 문자열덧셈; -- 이거도 자동 숫자로 
    -- 만약 1233으로 표시 하고 싶다면 어덯게 할까요?
    -- mysql에서 문자열을 이을려면 반드시 concat 을ㄹ사용
    select concat('123','3');
    
    select cast(123 as char(3)) as 확인;employees_copy
    
    