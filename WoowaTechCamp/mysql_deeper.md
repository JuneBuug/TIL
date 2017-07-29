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
여기에는 여러 칼럼이 들어갈 수 있고, 칼럼에 맞춰서 적절한 **데이터타입**을 설정해주는게 중요하다.
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

