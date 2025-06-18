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
-- 테이블 스키마 확인
-- DESC user;

-- DROP TABLE IF EXISTS comment;
CREATE TABLE comment (
	comment_id INT AUTO_INCREMENT PRIMARY KEY,
    -- user테이블의 기본키를 넣어 join시 참조하며 두 테이블의 관계를 설정
    user_id INT NOT NULL,
    comment VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT NOW()
);
-- 테이블 보기
-- SHOW TABLES;

-- user_id는 자동증가, created_at은 DEFAULT로 자동으로 들어감
INSERT INTO user (name, age, comment) VALUES ('ossam', 99, '안녕하세요. ossam입니다');
INSERT INTO user (name, age, comment) VALUES ('철수', 32, '반가워요. 철수입니다');
INSERT INTO user (name, age, comment) VALUES ('영희', 22, '반가워요. 영희입니다');

INSERT INTO comment (user_id, comment) VALUES (1, 'ossam의 댓글');
INSERT INTO comment (user_id, comment) VALUES (2, '철수의 댓글');

-- 모든 컬럼 조회
-- SELECT * FROM user;
-- SELECT * FROM comment;

-- 특정 컬럼 조회
-- SELECT name, age FROM user;

-- 조건에 맞는 컬럼 조회
-- SELECT name, age FROM user
-- WHERE name = '철수' AND age > 30;

-- SELECT name, age FROM user
-- WHERE name = '철수' OR name = 'ossam';

-- ORDER BY 컬럼명, 기본값 ASC(오름차순) DESC(내림차순)
-- SELECT user_id, name, age FROM user
-- WHERE name = '철수' OR name = 'ossam'
-- ORDER BY age DESC;

-- 조회 갯수 설정
-- SELECT user_id, name, age FROM user
-- ORDER BY age DESC
-- LIMIT 1;

-- 조회 갯수, 건너뛸 갯수 설정, 페이지네이션 구현시 사용
-- SELECT user_id, name, age FROM user
-- ORDER BY age DESC
-- LIMIT 1 OFFSET 1;

-- 로우 갯수
-- SELECT COUNT(*) FROM user;

-- 최대값
-- SELECT MAX(age) FROM user;

-- 날짜 형식 변경
-- SELECT name, DATE_FORMAT(created_at, '%Y년 %m월 %d일') as '가입일', created_at FROM user;

-- UPDATE user SET comment = '바꿀 내용' WHERE user_id = 2;

-- DELETE FROM user WHERE user_id = 2;

-- user의 이름, 나이, 댓글 가져오기
-- SELECT u.name, u.age, c.comment
-- FROM user AS u
-- LEFT JOIN comment AS c ON u.user_id = c.user_id;
