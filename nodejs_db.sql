-- 도커 컨테이너 mysql 클라이언트에 인코딩 알림(안하면 한글 깨짐)
SET NAMES utf8mb4;

CREATE DATABASE nodejs_db DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_general_ci;
USE nodejs_db;

-- DROP TABLE IF EXISTS user;
CREATE TABLE user (
    -- 정수로 지정하여 21억까지 사용, 1부터 자동증가시켜 중복방지, AUTO_INCREMENT면 자동으로 NOT NULL
    -- 로우를 고유하게 식별할 수 있는 후보키중 하나를 기본키로 선정
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    -- 가장긴이름이 30글자이므로 여유있게 50글자 가변문자지정, NULL 허용안함
    name VARCHAR(50) NOT NULL,
    -- TINYINT 범위: -128 ~ 127, UNSIGNED: 0 ~ 255
    age TINYINT UNSIGNED NOT NULL,
    -- 자기소개, TEXT: 게시글, 뉴스기사등 긴글일때 사용
    comment TEXT NULL,
    -- 생성시간: DATETIME서버 타임존 변경에 의존하지않음, 글로벌서비스에서 타임존 변경 반영하려면 TIMESTAMP
    -- DEFAULT: 현재날짜, 시간을 기본값으로 저장
    created_at DATETIME NOT NULL DEFAULT NOW()
);

-- DROP TABLE IF EXISTS comment;
CREATE TABLE comment (
	comment_id INT AUTO_INCREMENT PRIMARY KEY,
    -- user테이블의 기본키를 넣어 join시 참조하며 두 테이블의 관계를 설정
    user_id INT NOT NULL,
    comment VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW()
);

-- user_id는 자동증가, created_at은 DEFAULT로 자동으로 들어감
INSERT INTO user (name, age, comment) VALUES ('ossam', 99, '안녕하세요. ossam입니다');
INSERT INTO user (name, age, comment) VALUES ('철수', 32, '반가워요. 철수입니다');
INSERT INTO user (name, age, comment) VALUES ('영희', 22, '반가워요. 영희입니다');

INSERT INTO comment (user_id, comment) VALUES (1, 'ossam의 댓글');
INSERT INTO comment (user_id, comment) VALUES (2, '철수의 댓글');

CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE
);

INSERT INTO category (category_name) VALUES ('디자인'),('프론트엔드'),('백엔드');

CREATE TABLE post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    title VARCHAR(255),
    views INT DEFAULT 0,
    created_at DATETIME DEFAULT NOW()
);

INSERT INTO post (category_id, title, views)
VALUES 
(1, '디자인 게시물 1', 47),
(1, '디자인 게시물 2', 66),
(1, '디자인 게시물 3', 32),
(1, '디자인 게시물 4', 91),
(1, '디자인 게시물 5', 18);

-- 프론트엔드 게시물 15개
INSERT INTO post (category_id, title, views)
VALUES 
(2, '프론트엔드 게시물 1', 70),
(2, '프론트엔드 게시물 2', 11),
(2, '프론트엔드 게시물 3', 39),
(2, '프론트엔드 게시물 4', 85),
(2, '프론트엔드 게시물 5', 24),
(2, '프론트엔드 게시물 6', 52),
(2, '프론트엔드 게시물 7', 63),
(2, '프론트엔드 게시물 8', 96),
(2, '프론트엔드 게시물 9', 44),
(2, '프론트엔드 게시물 10', 77),
(2, '프론트엔드 게시물 11', 21),
(2, '프론트엔드 게시물 12', 88),
(2, '프론트엔드 게시물 13', 30),
(2, '프론트엔드 게시물 14', 55),
(2, '프론트엔드 게시물 15', 68);

INSERT INTO post (category_id, title, views)
VALUES 
(3, '백엔드 게시물 1', 93),
(3, '백엔드 게시물 2', 17),
(3, '백엔드 게시물 3', 46),
(3, '백엔드 게시물 4', 29),
(3, '백엔드 게시물 5', 82),
(3, '백엔드 게시물 6', 61),
(3, '백엔드 게시물 7', 74),
(3, '백엔드 게시물 8', 35),
(3, '백엔드 게시물 9', 90),
(3, '백엔드 게시물 10', 58);






