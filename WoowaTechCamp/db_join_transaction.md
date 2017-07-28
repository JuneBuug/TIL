# 오늘도 즐거운 디비디비 
의식적으로 부족한걸 채우려는걸 
3000~5000시간 공부하면 먹고살만한 개발자가 됨 

고수가 되려면 만시간 정도하면 고오수
10년~20년

-

## SQL 
선언적언어  
Declarative language

관계형 DB들 많음 
오라클 / mysql / mysql  점유율 합치면 90퍼 정도 됨

배울때는 mssql 도 좋음. 클라이언트 툴이 되게 좋음 
은행에서 db2를 많이 씀 우리나라 은행은 oracle을 쓰고 있다 

### NOSQL
보조제 
그래프디비,도큐먼트디비, key-value store
Ex) mongo db
Cassandra 대용량 가능
Redis 캐시로 많이 씀
Elasticsearch - 서치엔진
하둡을 만든분이 elasticsearch 안에 들어가는 엔진만드심

백엔드 개발자면 40위까지는 대충알아야함,,,?

## 용어 

### CAP 일관성 / 가용성 / 파티션 내성 
분산시스템! 여러대의 서버가 한 기능을 하는걸 말함.
분산시스템은 CAP때문에 만듦
일관성 : 
> 이미지 서버를 구축했는데 한대에만 하면 안됨. 열대 모두에게 요청했는데 똑같은거   
가용성
> 게임은 가용성은 좀 없음. 정기점검때문에?ㅋㅋㅋㅋㅋ 1년 365일 돌아감.. 고가용성은 99.99% 시간동안 서비스가 돌아간다는 뜻   
파티션 내성
> 서버는 홀수대 있음. 한대가 다운되면 걔가 가지고있던 데이터를 알아서 잘 분리해서 서비스가 돌아가게 하는거.   

수학적으로 3카피가 있으면 99.99% 가용성을 얻을 수 있음. 하나가 죽으면 나머지 하나는 복사하고 하나는 서비스 용으로 쓰도록. 
분산서버에서는 서버가 죽은지 아닌지 모름.
서버가 응답을 안하는 경우가 있는데 다수결로 투표 판단하려고  홀수대 있음… 

CAP를 100% 만족하는 시스템은 수학적으로 불가능하다는게 불가.

관계형 디비는
Consistency를 굉장히 중요해함

### ACID
원자성 / 일관성 / 고립성 / 내구성 
면ㅋㅋㅋ접ㅋㅋㅋ포인틐ㅋㅋㅋㅋ 
원자성은  All or nothing
일관성 - DB의 상태가 항상! 시작 - 중간 -끝 일관성 만족해야함
고립성 - 
내구성 - commit해서 완료된 트랜잭션은 무조건 저장이 된다는게 보장됨

짐그레이가 정의 

-
### BASE
Basically a…..?
Soft state
Eventual consistency  - 즉시 안됨. 특정시간 이후에 됨. 몇초인지 몇분 이후인지는 모름

nosql의 특징임 

### 확장성
수직확장 - 더 비싼 메모리 사는거 
수평확장 - 몇대를 더 확장하는거 

서버 두대가 더 유리함 
관계형 DB는 수평확장이 잘 안됨 

## Graph DB
Graph > tree
data와 data관계ㅇㅔ 복잡한게 있으면 
친구관계를 표현하기위해서 graphDB

## Document DB
이 document는 json을 말함
Javascript object notation

Json
장점  : 하드웨어/ 종류에 상관없이 읽을수있는 포맷임. 이기종간.
단점 : 쓸데없이 데이터가 너무 커짐. 압축도 안되고 static한 포맷임 

이걸 효율적으로 하려고 son..?
함
아무거나 막 저장 몽고디비 

## key-value DB
엄청 빠름
초당 50만개 - 젤싼 ec2여도 
일반 디비는 2만개
심플한 데이터 
키로 값만 읽을 수 있고 할수있느게 별로없음
캐시용으로 많이 사용 


Three-tier에서 DB가 하나면 병목이 될 수 있음 
backupscript를 만들어서 standby에 복사 
디비를 늘릴수있음. RR

-
HARI..?
스크립트로 RR로 분리해줌

성능이 안나오면 Cache를 추가해서 
Data를 일단 cache에서 읽고 없음녀 DB에서 읽는다 
50배쯤 좋음

단점은 개발이 어려워짐

라인이 몇억건은 날라옴
관계형에 못함
관계형은 수십TB까지만씀
그래서 
하둡에 HBASE라는걸 씀
하둡은 분산디비 

-구글에서 논문을 씀
Google file system
데이터 조따많음
구글이 원하는 만큼의 정보를 저장할수있는 시스템
특징은 모든 파일이 3카피 저장
물리적으로 최대한 멀리떨어트려서 저장
대박수

서버끼우면끼울수록 데이터용량이 계속늘어남
하드는 많은데 CPU가 놀고 있는데 이걸로 분산처리해얗지하고 만든게
 …리듀스

BIBTABLE?
논문을 보고 만든게 하둡임 

하둡 -  
상대적으로 느림 
무한한 용량을 저장하지만 느림

근데 채팅한마디가 5초뒤에 뜬다
안쓰겠자!

그래서 요 앞단에 똑같이 redis가 있음
영구적으로 저장이 안돼서 하둡에 저장하고 
최신메시지는 redis. 
요론식으로 쓰는게 cache기술임 


-

## Cloud DB 
문제는 파밍 아이템이 늘어남
ㅋㅋㅋㅋㅋㅋ아니 
유저가 파밍을 할때마다 아이템이 늘어남
유저 아이디를 포린키로 생김 
아이템 옵션이 랜덤하게 생김
레코드가 하나씩 생기는데 
돈을 레코드 단위로 받음

근데 실제로 게임 돌려봤더니 
유저는 원하는대로 안움직여줌
2만개씩 만들어냄 
대단함
nosql임

## 하둡 / 카산드라 / Elastic Search 
따로 공부해보면 좋겠따~




-


```
SHOW CREATE TABLE USER\G
# 좀 깔끔하게 보고싶을때. 쿼리가 나옴 
# 엔진이랑 charset보여줌
```

```
DEC(5,2)
#전체 5자리 소숫점 2자리. 크기가 좀 큼
VARCHAR는 VARCHAR의 오버헤드가 있어서 너무 작은건 부질없당

DATETIME
# 날짜 시간 
DATE
# 시간빼고
TIMESTAMP
# DATETIME과 동일 하지만 1970-2038년까지만 저장가능. 
# 업데이트하면 자동으로 시간 바꿔주고 그럼 
```


```
# 세션변수

SET @id= 'CRONG';

SELECT @id;

UPDATE BOARD SET USERID=@id WHERE TITLE = @id;

# 대용량 데이터를 처리하면 성능이 조금 느려짐 
```

콜레이션 - 대소문자 비교안하는 콜레이션이 디폴트로 되어있으면 그냥 비교안한당


```
SELECT NOW();
# 현재시간

SELECT CURTIME();
# 현재시간

SELECT CURDATE();
# 현재 날짜 

# 최근에는 어플리케이션에서 GMT변환해서 해줌

#오늘로부터 하루 전 
SELECT DATE_ADD(NOW(),INTERVAL -1 DAY);
```


-

```
NOT NULL
# NULL 아니게 
DEFAULT
# 기본값 
enum
# 지원하는 프레임워크가 없어서 잘 안씀
# 정렬할때 편함. order by enum으로 하면 티어순으로 정렬이 됨 

csv LOAD
# 서비스의 데이터를 외부에서 주는게 많음
# 최적화를 해야함. 
# 서버를 내리고 실행하는게 빠르겠쥬
# 멈추고 할 수 있을때 씁니다

SELECT 
# 필요한 항목 칼럼만 하세욤 

LIKE 'h_'
# 두글자짜리 

중첩쿼리
# 쿼리 결과가 3가지 결과가 있음
# 1차원 -SCALAR값이나 NULL
# 중첩일때는 1차원이 아니면 안됨
# 컬럼의 집합일수도 있음 - (30,40,50)
# 일반적인 경우  - 테이블 
# SELECT는 테이블에 대해서 닫힌 연산이다 
# Scalar / set도 테이블이니까

SELECT * FROM POST WHERE ID IN (1,2); 
# 범위~ 

서브쿼리보다는 JOIN이 성능이 더 나옴  


GROUP BY 
# 원하는데서 전체 통계를 낼때 
# 사용자별로 group을 만들면됨 

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

# Group함수에 적용할 수 있는 값은 그거와 관련된 것 

HAVING
# GROUP 절에 조건을 쓸 수 있음 
# 그 갯수에 조건을 걸때 주로 씀 


order by
# 느린 연산 
# 자주쓰면 index만들고 가급적이면 안쓰는게 좋다 

```


-

## JOIN

1. 데이터 저장공간 효율성
2. 빠른편이지만.. 생각만큼 빠르진 않다 
3. 쓸데없이 레코드를 다 고쳐버리는 현상이 필요할수도있음

성능이 안나와서 떨어진 테이블을 다시 합친ㄴ 과정이 필요 
역정규화
-저장공간은 낭비되지만 
성능은 좋아진다


```
CROSS JOIN
# cartesian 프로덕트 - 데카르트 
# 의미 없음. 여기에서 조건을 생겨줘야 의미가 생김

JOIN ON 
이 제일 좋음. ON 에 명시적인 조건이 있으니까 

EQUAL JOIN - 반대말 NON-EQU JOIN <>

INNER JOIN
# INNER TABLE에 의해서 결정이 됨 
# 매칭되지않은 레코드가 나오지않음 

글을 안쓴다고 지워버렸어!
OUTER JOIN을 씀 
# LEFT OUTER JOIN 
# 왼쪽에 있는 테이블을 다 나오게 해줌 

둘다 모두의 누락없이 보여주겠따
FULL OUTER JOIN
mysql 엔 없음
OUTER JOIN 두개를 UNION해주면 됨 

```


참조 무결성 제약 조건
외래키 값은 반드시 원래 테이블에 있는 값이든지 NULL 값이어야함 

```
ON DELETE CASCADE ON UPDATE CASCADE
# CASCADE는 중첩! 
# 만약에 foreign key를 지우거나 update하면 참조하던 애들도 다 싹 바궈줌
# ON DELETE CASCADE는 해야할지 말아야할지 선택임
# 웬만하면 안지우는게 좋음 

```

Foreign key 제약조건 있어야좋음
하지만 없으면 insert 성능이 좋아짐
대신에 개발자가 할 일이 많아짐 


### Table의 관계 

One - to many에서 
Foreign key를 many쪽에 붙여야한다

Many to many가 
유저와 아이템의 관계 
둘다 foreign key 
새로 테이블 만들어야해

-

-
한꺼번에 넣어서 뒤지면 성능이 수십배 좋아짐 BLOCK

 Foreign key에 
index가 있으면 full scan안해도됨
인덱스가 있다면
ID에 대해서 어디에있는지 찾을수가있음
맞는거 찾아읽기때문에 확 줄어들음

-

Sort merge join

만약에 두개가 모두 정렬이 되어있다고 가정해보자. 

userid로 post가 정렬되어있음
전체다 정렬을 할 필요 없이 큰쪽에 플러스 
사이즈는  N + M

정렬하는데 시간이 많이 듦
작을때는 nested가 좋고 
커지면 커질수록 정렬하고 sort merge join하는게 조흐

Query optimizer가 이런 방법을 선택해주는데
DBA들은  가끔 이 optimizer 에게 hint를 줘서 조절
하지만 mysql은 무조건 nested loop join 함
(바깥의 갯수) * (안은 페이지 갯수)
Join 순서에 따라 달라짐 
-

Hash Join
정렬을하지않고 hash만들어서 조인
두 테이블 중에 하나만 hash
작은쪽에. 
Build table이랑 probing table
Build table에 대해서 hash table을 만들고 실제 레코드를 가리킴
hash 함수를 돌리면 맞는 레코드가 나옴 

hash를 돌린다는건 cpu가 hash함수를 만들어야해서
오버헤드 가 있음
하나하나는 hash join이 빠르지만 항상 거의 여러개 돌리니까…

oracle은 큰 데이터에 대해서
Hash join을 하는 경향이 있음

* 인메모리 해시조인
Hash table이 메모리에 올라가지 않으면 안됨. 그걸 개선한게 그레이스

* 그레이스 해시조인
그레이스는 사람이름임…유예해시…

-

## Transaction

순서에따라서 결과가 달라질수있음
A: 5만원 B: 10% 상승 

Serializable 
만개를 했지만 1~10000개를 한거랑 결과가 똑같구나!
들어오는대로 절대로 실행되지 않음 
-
Lock이라는 공유리소스에..
접근 못하게 하는 걸 lock이라고 부름
잠근 사람이 해제를 해야한다 

가장 기본적인 lock은 
L과 Release

훨씬 복잡하지만 좀더 세분화하면

	S  | X 
S     O    X
_
X     X.   X. 


공유락-읽기락
Exclusive lock - 쓰기락

-

디비에서는 안생기는데 
개발자가 잘못짜면 언제든지 발생할수있는 lost update problem

## 트랜젝션의 문제점 상태 
Dirty Read Problem
잘못된 값을 읽게 되는 것 
Transaction 중간에 commit도 안한 값을 읽어버려서 그럼

-
Non-repeatable read problem 
중간에 다른애들이 커밋해버려서  처음이랑 다음이 다른 값이 읽힐때 

-
Phantom Read Problem
여러 레코드를 읽는 작업에서 생김
통계치 냈음 - 레코트 인서트/업데이트 - 통계다시냈더니 값이 다름
없는 친구를 읽었다고해서.


Serializable
성능이 더럽게 많이 오래걸림
그걸 보호하기 위해서
그러면 P 3개 다 안생김
-
Repeatable Read 
반복적으로 읽어도 값이 안바뀌는게 보장되는 경우 

Read committed
커밋된것만 읽겠다 

-
일관성을 적게 보장하면 
성능이 보장되고 
구현이 쉬워짐

Mysql 기본은 repeatable read
Read uncommited는 성능차이가 거의 안나기때문에 mysql에서 
쓰지마~.~


```
set transaction isolation level read uncommitted; 
set transaction isolation level read committed; 
set transaction isolation level repeatable read;
set transaction isolation level serializable;

show variables like '%tx_isolation%';
start transaction; 
commit; 
```

-

LOST UPDATE PROBLEM을 막기위해서 
Read uncommited에서도 
Update lock이 두개 걸리진 않는다 

-

ANSI

국제표준은 ISO

둘이 대부분 같음

국제 표준은 모드가 4개인데 
ORACLE 은 S랑 RC밖에없음
Mysql   serializable 성능 안좋음 
근데 mysql은 RR에서 phantom 막도록했다 
그래서 RR만써도되고, 성능 올리려면 Read committed 까지는 해봐라 

mssql은 네개 다 있음.  serializable 꽤 좋음 
