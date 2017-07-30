# MYSQL 더 알아보기

## TABLE의 내용을 보고싶을때
```
SHOW CREATE TABLE 테이블이름;
DESC 테이블이름;

SHOW CREATE TABLE 테이블이름\G;
# 내가 테이블을 만들 때 쓴 쿼리가 그대로 나온다.
# TABLE을 좀 깔끔하게 보고싶을때.
# DB엔진명과 Charset을 알 수 있다.
```

## 데이터타입
예를 들어서!
```
CREATE TABLE JUNE (
);
```
을 한다고 해보자 .
여기에는 여러 칼럼이 들어갈 수 있고, 칼럼에 맞춰서 적절한 **데이터타입** 을 설정해주는게 중요하다.
잘못된 데이터타입을 입력했다가는 메모리 낭비가 아주 심한 DB를 구축하는게 될 수 있다!

데이터 타입들은 ([다음링크](https://dev.mysql.com/doc/refman/5.7/en/data-types.html))에서 자세하게 살펴볼 수 있다.
간단하게 살펴보자.
```
INT
# 말그대로 INT. 정수형. key값으로 보통 많이 씀.
DEC(6,3)
# DECIMAL형. 금액등을 표현할때 많이 씀. 앞의 숫자는 총 자리수, 뒤의 숫자는 소수 자리수. 즉 100.000 식으로 표현 간으
DOUBLE
# 더블형. 부동소수점 표현
CHAR(8)
# 캐릭터형. 이 예제에서는 8자 이하의 String값을 표현할 수 있음. 하지만 공간은 계속 8만큼 먹음.
VARCHAR(64)
# 최대 64자 까지 표현할 수 있는 유동적인 캐릭터형. 글자수에 따라 공간을 먹지만, 유동적으로 변형 해주는 속성에 대한 오버헤드가 따로 있음!
DATETIME
# 날짜 + 시간을 표현하는 형. 0000~ 9999년 까지 모든 년도를 표현할 수 있음.
DATE
# 연월일의 날짜만 표현하는 형
TIMESTAMP
# DATETIME과 동일하지만, 1970년부터 2038년까지만 저장가능. 또한 NULL값을 넣어서 레코드를 저장하면 NOW()를 넣은것과 동일하게 작동한다!
# UPDATE_DATE 등의 칼럼에 적용하면 편리할 듯. 자동으로 시간이 바뀐다.
```

## 날짜 처리하는 쿼리
```
NOW()
# 현재 날짜 + 시간
CURTIME()
# 현재 시간
CURDATE()
# 현재 날짜
```

날짜를 넣으면, GMT기준으로 들어간다.
예전에는 한국에서 만들면 GMT+9 기준으로 디비에서 처리하도록했는데,
요즘에는 글로벌 서비스를 노려서 다들 GMT로 저장해두고, 어플리케이션 단에서 GMT + 9로 나오도록한다.

### 특정 날짜 혹은 시간에 값을 더하거나 빼주고싶을 때
```
DATE_ADD(NOW(),INTERVAL 2 DAY)
# 현재 시간에 2일을 더한다.
DATE_SUB(NOW(),INTERVAL 30 MINUTE)
# 현재 시간에서 30분을 뺀다.

UPDATE FROM USER SET CURRENT_TIME = DATE_SUB(NOW(),INTERVAL 30 MINUTE)
# 위의 식처럼 응용해볼수있다. user의 모든 current time을 현재시간에서 30분씩 빼준다.
```


## 칼럼들 제약 조건
### PRIMARY KEY
반드시 고유해야하는 대표값이라구 한다.
```
CREATE TABLE USER (
	  UID INT PRIMARY KEY AUTO_INCREMENT
);
# USER라는 테이블의 PRIMARY KEY를 UID로하고, 이 값은 INT이며 자동으로 수가 올라간다.
```

### NOT NULL
이 필드에는  NULL값을 못 넣도록하는 제약 조건
```
CREATE TABLE USER(
	UID INT PRIMARY KEY AUTO_INCREMENT,
	EMAIL VARCHAR(64) NOT NULL
);
# USER 테이블에서 EMAIL은 NULL값을 넣으면 안된다.
```


### DEFAULT
기본으로 들어갈 값 지정 가능!
```
CREATE TABLE USER(
	UID INT PRIMARY KEY AUTO_INCREMENT,
	EMAIL VARCHAR(64) NOT NULL,
	MONEY DEC(10,2) DEFAULT 4.99 NOT NULL
);
# 딱히 money 칼럼에 값을 넣어주지않아도 null이 아니라 4.99로 초기화된다.
```

### ENUM
프로그래밍의 enum 타입과 동일하며, 잘 사용하지 않는 경향이 있다.
그런데 왜 쓸까?
오타가 나는 걸 막을 수도 있고ㅋㅋㅋㅋ하는 장점이 있지만,
중요한 건 **정렬** 할 때 쓸모가 있다.
코드를 보자
```
CREATE TABLE USER(
	UID INT PRIMARY KEY AUTO_INCREMENT,
	EMAIL VARCHAR(64) NOT NULL,
	MONEY DEC(10,2) DEFAULT 4.99 NOT NULL,
	TIER ENUM('bronze','silver','gold','platinum','diamond') DEFAULT 'bronze' NOT NULL
);
```

위의 코드에서 티어를  브론즈 / 실버 / 골드 / 플레 / 다이아로 초기화했다.
ENUM이 아니라 CHAR로 줬다면, TIER로 정렬했을 때 abc순으로 정렬이 되지만
ENUM으로 줬기때문에 티어 순으로 정렬할 수 있다.


## MYSQL에 여러개를 INSERT하기

### MULTIINSERT

```
INSERT INTO USER(EMAIL,TIER)
	VALUES ('junekim@gmail.com', 'platinum'),
('starbucks@gmail.com', 'bronze'),
('disney@gmail.com', 'diamond')
;
```

하나의 테이블에 여러개의 값을 입력하는 방법.
하지만 정말 많은 값을 입력하는데는 한계가 있다.

### CSV LOAD
csv파일을 로딩하는 방법.
csv파일은 엑셀이나 구글 spreadsheet로도 만들 수 있다.
표를 작성하는 프로그램이라면 웬만해서는 지원하는 형식이다.
csv파일을 작성한뒤에

```
LOAD DATA LOCAL INFILE '파일경로'
INTO TABLE 테이블이름
FIELDS TERMINATED BY '구분자';
```

구분자에 ,를 넣으면 ,로 필드를 구분한다.
적절한 로컬파일 경로를 사용해서 정말 다량 (몇천, 몇만개) 의 필드를 넣을 수 있다.

이 방법은 서버의 데이터를 외부에서 주는 경우가 많기때문에 쓴다.

## 그외 꼭 알아야할 쿼리들

### WHERE 조건절

#### LIKE
```
SELECT * FROM USER WHERE EMAIL LIKE 'h%';
# % 를 쓰면 0개 이상의 임의의 문자
# _를 쓰면 1개의 임의의 문자
# 즉 여기서는 USER 테이블에서 EMAIL에 h가 포함된 모든 레코드를 부름
```

### IN (중첩쿼리)
쿼리의 결과는 3가지가 있다.
그냥 값 하나 혹은 NULL인 경우, 1차원 값(Scalar 값)이라고 한다.
컬럼의 집합(레코드)인 경우도 있는데, 이걸 2차원 값(Set)이라고 한다. (30, 40, 50) 과 같은 식으로 나온다.
대개의 경우 테이블로 나온다.
```
SELECT * FROM USER WHERE UID IN (1, 2, 3);
SELECT UID FROM USER WHERE NAME LIKE '%n%';
SELECT * FROM USER WHERE UID IN
(SELECT UID FROM USER WHERE NAME LIKE '%n%');
```

SELECT는 테이블에 대해서 닫힌 연산이다.
Scalar와 Set도 넓은 의미에서 테이블이기때문이다!

### Aggregate Function

```
SELEECT AVG(MONEY) FROM USER;
# MONEY 칼럼의 평균을 낸다.
SELECT SUM(MONEY) FROM USER;
# MONEY 칼럼의 총합을 낸다.
SELET COUNT(*) FROM USER;
# USER의 총 레코드 수를 센다.
```


### GROUP BY  / HAVING
* 원하는데서 전체 통계를 낼때
* 사용자별로 group을 만들면됨
GROUP으로 묶어서 표를 보여준다. 이때 기준이 되는 칼럼도 같이 선택해서 보여줘야한다.
HAVING은 그룹함수에서의 where(조건절) 역할을 한다.
```
SELECT USER_ID, COUNT(*) FROM BOARD GROUP BY USER_ID
    -> ;
+---------+----------+
| USER_ID | COUNT(*) |
+---------+----------+
| 1       |        2 |
| 2       |        1 |
| 3       |        1 |
| 4       |        3 |
| 5       |        3 |
+---------+----------+
5 rows in set (0.01 sec)

SELECT GRADE, COUNT(*) FROM USER GROUP BY GRADE;
SELECT GRADE, COUNT(*) AS NUM FROM USER GROUP BY GRADE HAVING NUM >= 2;
#  두명 이상 있는 GRADE의 레코드 수를 보여줘!
```

### ORDER BY
말 그대로 순서대로 나오게 하는 연산이다.
하지만 느린 연산이기도 하다.
자주 정렬할 일이 있다면, 그 컬럼에 대해서 index를 만드는 방법을 추천한다.
```
SELECT * FROM USER ORDER BY GRADE DESC;
# GRADE로 정렬하는데 내림차순으로 정렬한다.
```


### ALTER
테이블을 변형하는 쿼리

```
ALTER TABLE USER ADD COLUMN LOGIN DATETIME FIRST;
# USER 테이블에 LOGIN이라는 DATETIME 컬럼을 넣는데 맨 처음에 넣어라 (?)
ALTER TABLE USER ADD COLUMN LAST DATETIME AFTER NAME;
# USER 테이블에 LAST라는 DATETIME컬럼을 넣는데 NAME컬럼 다음에 넣어라.
```


### DROP
테이블이나 칼럼을 삭제하고 싶을때 쓴다.

```
DROP TABLE 테이블이름;
# 테이블 삭제
ALTER TABLE USER DROP COLUMN LAST;
# USER테이블의 마지막 컬럼 삭제
```
