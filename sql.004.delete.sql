-- 앞 차시에서 만든 product 테이블이 남아있으면 지우고 시작
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  price INT NOT NULL,
  description VARCHAR(200)
);

INSERT INTO product (id, name, price, description) VALUES
(1, '아이폰 13', 1300000, 'Apple의 최신 모델 스마트폰'),
(2, '갤럭시 S21', 1200000, '삼성의 최신 모델 스마트폰'),
(3, '맥북 에어', 1500000, 'Apple의 대표적인 노트북'),
(4, 'LG 그램', 1300000, 'LG전자의 대표적인 노트북'),
(5, '아이패드', 800000, 'Apple의 태블릿'),
(6, '갤럭시 탭', 700000, '삼성의 태블릿'),
(7, '애플 워치', 500000, 'Apple의 스마트 워치'),
(8, '갤럭시 워치', 400000, '삼성의 스마트 워치'),
(9, '에어팟 프로', 300000, 'Apple의 무선 이어폰'),
(10, '갤럭시 버즈', 200000, '삼성의 무선 이어폰');


-- id 가 2인 상품 삭제
DELETE FROM product
WHERE id =2;

-- 가격이 100만원 이상인 상품 삭제
DELETE FROM product
WHERE price >= 1000000;

-- 상품 설명에 'apple' 이 포함된 상품 삭제 
DELETE FROM product
WHERE description LIKE '%Apple%';

-- 복합 조건 삭제
-- 가격이 50만원 이하이고 상품 설명에 스마트가 포함된 상품
DELETE FROM product 
WHERE price <= 500000 AND description LIKE '%스마트%';

-- 상품명이 갤럭시로 시작하고 가격이 100만원 이상인 상품 삭제
DELETE FROM product
WHERE name LIKE '갤럭시%' AND  price >= 1000000;

-- 도전과제 
-- ID가 5~8인 상품 삭제
DELETE FROM product
WHERE id BETWEEN 5 AND 8;

-- 상품 설명에 '태블릿'이 포함된 상품 삭제
DELETE FROM product
WHERE description LIKE '%태블릿%';

-- 가격이 300,000원 이하인 상품 삭제
DELETE FROM product
WHERE price <= 300000;

-- 상품명이 '아이폰' 또는 '아이패드'로 시작하는 상품 삭제
DELETE FROM product
WHERE name LIKE '아이폰%' OR name LIKE '아이패드%';
-- 가격이 1,000,000원 미만이고 설명에 '삼성'이 포함된 상품 삭제
DELETE FROM product
WHERE price <= 1000000 AND description LIKE '%삼성%';


SELECT * FROM product WHERE price <= 1000000 AND description LIKE '%삼성%';




