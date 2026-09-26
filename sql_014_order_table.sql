create database shopping_mall;
use shopping_mall;

create table grade (
	grade_id int primary key auto_increment,
    grade_name varchar(50) not null,
    discount_rate decimal(5,2) not null
);

create table member (
	member_id bigint primary key auto_increment,
    name varchar(30) not null,
    password        VARCHAR(255) NOT NULL,   -- 평문 금지, 해시값 저장
    email           VARCHAR(100) NOT NULL UNIQUE,
    address         VARCHAR(255) NOT NULL,
    phone           VARCHAR(20) NOT NULL,
    grade_id        INT,
    status          VARCHAR(20) NOT NULL,
    create_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (grade_id) REFERENCES grade(grade_id)
);

-- 물건
CREATE TABLE item (
    item_id         INT AUTO_INCREMENT PRIMARY KEY,
    item_name       VARCHAR(100) NOT NULL,
    price           INT NOT NULL,
    stock           INT NOT NULL,
    create_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(20) NOT NULL
);

-- 물건 사이즈 (물건 1 : 사이즈 N)
CREATE TABLE item_size (
    size_id         INT AUTO_INCREMENT PRIMARY KEY,
    size_name       VARCHAR(20) NOT NULL,
    item_id         INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

-- 주문 (헤더)
-- order는 예약어라 orders로 씀
CREATE TABLE orders (
    order_id        INT AUTO_INCREMENT PRIMARY KEY,
    member_id       INT NOT NULL,
    total_price     INT NOT NULL,
    order_date      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES member(member_id)
);

-- 주문상세 (주문 1 : 주문상세 N, 상품별로 한 줄씩)
CREATE TABLE order_item (
    order_item_id   INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    item_id         INT NOT NULL,
    quantity        INT NOT NULL,
    price_at_order  INT NOT NULL,   -- 주문 당시 단가 (이후 item 가격 변동과 무관)
    subtotal        INT NOT NULL,   -- quantity * price_at_order
    order_status    VARCHAR(20) NOT NULL,  -- 상품별 배송/취소 상태
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);

-- 결제
CREATE TABLE payment (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_id        INT NOT NULL,
    payment_method  VARCHAR(30) NOT NULL,
    payment_info    VARCHAR(255) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
 
-- 환불 (상품 단위이므로 order_item 참조)
CREATE TABLE refund (
    refund_id       INT AUTO_INCREMENT PRIMARY KEY,
    order_item_id   INT NOT NULL,
    refund_status   VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_item_id) REFERENCES order_item(order_item_id)
);
 
-- 찜
CREATE TABLE wishlist (
    wishlist_id     INT AUTO_INCREMENT PRIMARY KEY,
    item_id         INT NOT NULL,
    member_id       INT NOT NULL,
    FOREIGN KEY (item_id) REFERENCES item(item_id),
    FOREIGN KEY (member_id) REFERENCES member(member_id),
    UNIQUE (member_id, item_id)   -- 같은 상품 중복 찜 방지
);



