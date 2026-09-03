
-- 앞 차시에서 만든 order 테이블이 남아있으면 지우고 시작
DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  id INT PRIMARY KEY,
  order_name VARCHAR(20) NOT NULL,
  product_name VARCHAR(20) NOT NULL,
  quantity INT NOT NULL,
  order_date DATE NOT NULL
);

INSERT INTO `order` (id, order_name, product_name, quantity, order_date) VALUES
(1, '홍길동', '피자', 2, '2022-02-26'),
(2, '김영희', '치킨', 3, '2022-02-26'),
(3, '이철수', '햄버거', 1, '2022-02-27'),
(4, '박지민', '스테이크', 2, '2022-02-27'),
(5, '최영희', '짬뽕', 1, '2022-02-27'),
(6, '박서준', '초밥', 3, '2022-02-28'),
(7, '김민지', '파스타', 2, '2022-02-28'),
(8, '정재은', '토스트', 1, '2022-02-28'),
(9, '신은주', '감바스', 1, '2022-03-01'),
(10, '유지훈', '돈까스', 1, '2022-03-01');

-- 1. 단일 조건 수정
-- ID가 2인 주문의 수량을 4로 수정
UPDATE `order`
SET quantity = 4
WHERE id = 2;

-- ID가 4인 상풍명을 파스타로 변셩
UPDATE `order`
SET product_name = '파스타'
WHERE id = 4;

-- ID가 5인 주문의 날짜를 2022년 03월 01로 변경
UPDATE `order`
SET order_date = "2023-03-01"
WHERE id = 5;


-- 2 복합 조건 수정 
-- 수량이 2 이상이고 , 상풍명이 피자인 경우 주문자를 김철수로 변경

UPDATE `order`
SET order_name = '김철수'
WHERE quantity >= 2 AND product_name = '피자';

-- 주문일이 2022-02-28 이고 상품이 초밥인 경우 수량을 6으로
UPDATE `order`
SET quantity = 6
WHERE order_date = "2022-02-28" AND product_name = '초밥';

-- 상품명이 '토스트' 이거나 '카레' 인 주문의 수량을 4로 변경 
UPDATE `order`
SET quantity = 4
WHERE product_name = '토스트' OR product_name = '카레';

-- 3. 테이블 구조 변경 + UPDATE
-- address 컬럼 추가 (최대 100글자)
ALTER TABLE `order` ADD address VARCHAR(100);
--  NOT NULL이어도 DEFAULT 없이 추가하면 에러 없이 실행되고, 기존 행에는 VARCHAR 기준 빈 문자열 ''이 자동으로 채워집니다.
-- 문제는 그 빈 값이 "주소 없음"인지 구분이 안 돼서, 나중에 IS NULL로 못 찾고 = ''로 찾아야 하는 게 함정입니다.
-- 안전하게 하려면 DEFAULT 값을 명시하거나, NULL 허용으로 추가 후 UPDATE로 채우고 나서 NOT NULL로 바꾸는 3단계 방식을 쓰세요.

-- 수량이 1 이하이고 상품이 감바스인경우 주소를 서울시 강남구로 설정 
UPDATE `order`
SET address = '서울시 강남구'
WHERE quantity <= 1 AND product_name = '감바스';

-- 도전과제 


SELECT * FROM `order`WHERE quantity <= 1 AND product_name = '감바스';
SELECT * FROM `order`;


-- 도전 과제 

-- 주문일이 2022-02-26인 주문의 상품명을 '샐러드'로 변경
UPDATE `order`
SET product_name = '샐러드'
WHERE order_date = '2022-02-26';

-- 주문자가 '김민지'이고 수량이 2인 경우, 주소를 '경기도 수원시'로 수정
UPDATE `order`
SET address =  '경기도 수원시'
WHERE order_name = '김민지' AND quantity = 2;
-- ID가 3부터 7인 주문들의 수량을 3으로 수정
UPDATE `order`
SET quantity = 3
WHERE quantity BETWEEN 3 AND 7;

-- 주소가 아직 없는(NULL인) 주문의 주소를 '주소 미입력'으로 채우기
UPDATE `order`
SET address = '주소 미입력'
WHERE address is NULL;

-- 디폴트로 할떄 
-- ALTER TABLE `order` ALTER COLUMN address SET DEFAULT '주소 미입력';


-- 업데이트전 무조건 SELECT 로 확인후 변경하기!! 

SELECT * FROM `order` WHERE address is NULL;
SELECT * FROM `order`;