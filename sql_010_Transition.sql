DROP DATABASE IF EXISTS bank;
CREATE DATABASE bank;
USE bank;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    name VARCHAR(50),
    balance INT NOT NULL
);

INSERT INTO accounts VALUES
    (1, 'Alice', 100000),
    (2, 'Bob', 50000);

SELECT * FROM accounts;

-- 실습 여제 1. 

-- 수동으로 트랙잭션 시작 

start transaction;
update accounts set balance = balance - 30000 where account_id = 1;
update accounts set balance = balance + 30000 where account_id = 2;

commit;
rollback; 

-- 오류가 발생하더라도 자동 취소가 안된다 직접 rollback 처리를 해야한다

rollback;

-- 잔액 부족일떄 
start transaction;
update accounts
set balance = balance - 200000
where acoount_id =1 and balance >=200000;

-- 적용된 row count 확인 명령어
select row_count() as 변경된행수;

commit;
select * from accounts;

-- DELMITER 구분자  여기까지가 한문장이야 라는 표시
-- mysql는 세미콜론을 만나면 문장이 끝난줄 알고 자동 실행해버립니다
-- 그런데 프로시저 구문 안에도 세미콜론이 여러개가 나올수있어서 다읽기전에 구문을 실행하다

DELIMITER //

create procedure 송금하기() 
begin
	start transaction;
    update accounts set balance = balance -20000
    where account_id = 1 AND balance >= 20000;
    
    IF ROW_COUNT() = 0 then 
    rollback;
    select '잔액부족' as 결과;
    ELSE
		update accounts set balance = balance +20000 where account_id =2;
        commit;
        select '송금완료' as 결과;
	END IF;
END //
	--여기까지가 프로시저의 끝입니다
DELIMITER ;

-- 프로시저를 만들었으면 프로시저 호풀해서사용
call 송금하기();

select * from accounts;

-- 직접 트랜젝션 구문을 사용하고 commit, rollback 확인해보기
-- 프로시저 사용안해도됌
delimiter //
create procedure 은행송금하기3()
begin
	start transaction;
    
	update accounts set balance = balance - 100000 where account_id = 1 and balance >= 100000;
    
    if row_count() = 0 then rollback;
		select '잔액부족' as 결과;
	else 
		update accounts set balance = balance +100000 where account_id = 3;
        
        if row_count() = 0 then rollback;
			select '입금계좌없음' as 결과;
        else  
			commit;
            select '송금완료' as 결과;
		end if;
	end if;
end //
delimiter //
	
call 은행송금하기3();
