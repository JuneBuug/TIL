# Mysql 기본 쿼리 

## Mysql이란? 
Mysql은 관계형 데이터베이스(Relational Database) Management System입니다. 

데이터는 `컴퓨터에 저장할 수 있는 형태의 정보` 입니다.
여기서 의미 있는 사실을 뽑아내면 information 이 됩니다. 
그보다 한단계 높여, 좀더 유용한 지식을 knowledge라고 합니다. 
knowledge보다도 나아지는, 미래를 예측하는데 도움이 되는 지식을 insight라고 합니다.
하지만  신뢰도 100%의 insight라는 건 없겠죠. :) 

관계형! 이라고 말을 했는데, 
관계형은 데이터와 데이터 간 관계가 중요합니다. 
학생이라는 데이터와 수업이라는 데이터 간에는 `수강한다` 라는 관계가 형성됩니다.

관계형 DB는 Transaction을 지원하여, 데이터베이스의 concurrency를 유지합니다. Transaction은 간단히 말해서 연산을 묶어놓은 것입니다.  
1번~4번까지의 연산이 한 트랜젝션이라고 하면, 
한 트랙젝션을 수행할 때 DB에 1번부터 4번이 모두 반영되거나, 모두 반영되지 말아야합니다.
은행에서, 카드를 넣고 잔액을 확인하고 인출하는 일련의 과정을 트랜젝션으로 볼 수 있습니다. 
중간에 취소되면 그 결과는 DB에 반영되지 않습니다 :) 
전자상거래를 비롯해 데이터베이스의 동시성이 중요한 부분에서 많이 쓰입니다. 
트랜젝션은 어려운 기술이기때문에,  느리고 무겁습니다. 

### Nosql 
따라서 빅데이터에는 무겁고 느린 트랜젝션을 지원하는 DB를 쓸 필요가 없습니다.
nosql(Not only sql)은, 관계형 DB가 아닌 DB들을 통칭하는 말입니다. 
일반적으로 RDB는 러닝커브가 가파르지만 nosql은  러닝커브가 낮은 편입니다. 
그래서 하루동안 잘 배워도 서비스에 적용할 수 있다고 합니다. 
따라서 빠르게 배워야하는 경우 혹은 관계형 DB를 쓸 수 없는 경우 씁니다. 
하지만 이 포스팅에서는 nosql이 아닌 **mysql**을 다뤄보겠습니다.  

### Sql 
Structed query language라는 뜻으로, 시퀄이라고 부르기도 합니다. 

## CRUD 문법 
CRUD는 Create / Retrieve / Update / Delete 의 줄임말입니다. 
삽입 / 조회 / 변경 / 삭제의 이 4가지 기능이 가장 기본적인 DB의 연산입니다.


### Database 만들고 사용하기 
```
$  CREATE DATABASE junekim;
#  junekim이라는 DB를 만든다. 

$ SHOW DATABASES;
# Database 목록을 확인한다. 

$ USE junekim; 
# junekim이라는 DB를 사용한다. 
```

### Table만들기 
```
CREATE TABLE USER (USERID INT PRIMARY KEY AUTO_INCREMENT,EMAIL VARCHAR(64),NAME VARCHAR(64),PASSWORD VARCHAR(64),COMMENT TEXT,START_DATE DATETIME,);
# USER라는 테이블을 만든다
# USERID라는 항목은 INT값이 들어있는 애인데, 이 테이블의 항목을 구별해줄 수 있는 Primary Key로 쓸거고 이 값은 자동으로 올라간다
# EMAIL / NAME / PASSWORD라는 항목을 만들거고 최대 64bytes( 혹은 Character) 가 되는 가변길이 문자열로 받을 거야 
# COMMENT 는 TEXT로 만들거고, 얘는 기본 값이 없다
# START_DATE는 년월일시 등이 있는 DATETIME값으로 만들거다
```

### Table에 삽입하기 
```
INSERT INTO USER VALUES (NULL,'abc@gmail.com', ... );
# USER라는 테이블에 VALUES다음에 있는 값들을 한 행으로 해서 삽입할것 
# 맨처음이 NULL인 이유는 Primary key인 USERID가 AUTO_INCREMENT이기 때문
INSERT INTO USER(NAME,PASSWORD) VALUES ('abc','pw');
# USER테이블의 NAME 항목에 abc를, PASSWORD항목에 pw를 넣는다. 
```

### Table 내용 조회하기 
```
SELECT * FROM USER;
# USER라는 테이블의 내용 전부를 본다SELECT ID, NAME FROM USER;
# USER 테이블의 ID / NAME 항목만 본다SELECT ID, NAME FROM USER WHERE ID=3;
# USER 테이블의 ID / NAME 항목만 보는데 ID가 3인것만 본다 
```

### Table 내용 변경하기 (주의)
무조건 SELECT문 실행해본 뒤에 해볼 것. 
DB에 영향을 끼칠 수 있는 구문. 
```
UPDATE USER SET MONEY = 0; 
# USER테이블 내 모든 값의 Money항목을 0으로 업데이트UPDATE USER SET NAME = 'junekim' WHERE ID=2;
# USER테이블의 ID가 2인 친구를 NAME을 junekim으로 바꾼다 
```

### Table 내용 삭제하기 (주의)
무조건 SELECT문 실행해본 뒤에 해볼 것. 
DB에 영향을 끼칠 수 있는 구문. 
```
DELETE FROM USER; 
# USER테이블의 모든 레코드 삭제DELETE FROM USER WHERE ID = 4;
# USER테이블의 ID가 4인 레코드 삭제 
```