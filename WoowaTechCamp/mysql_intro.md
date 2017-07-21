chmod -x ~ 
실행권한을 빼겠다
+x 더하겠다 
+/ - / w r x  조합 

이 스크립트를 서비스로 실행해서 
자동으로 실행 



### AWS

AWS 접속링크
web: https://962895253643.signin.aws.amazon.com/console
edward1, juno4914

mobile: 
https://089220199183.signin.aws.amazon.com/console
edward2, juno4914

-

junekim 
nGCpnp}h%|zY


 slack service 실행까지 

![](mysql_intro/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202017-07-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%202.16.48.png)

upgrade안되어서 그럼 
빨리하구싶으면 그냥 `sudo reboot`

근데 오류가 생기면 `sudo dpkg —configure -a` 하면됨 

왜 이런 문제가 생겼나?
방금 선택하는걸 못해서 거기서 락이 생기는거임

-keep local version선택 


`sudo -i` 하면 통채로 루트 사용자가 됨 

`vimtutor` vim tutor 
`man git`  등의 
설명서들이 다 영어로 나오는데 
셋팅 다하면 쉘을 나온다음에 
ssh를 끊고 다시함  

## mysql 깔기 
여기서 password설정할때 그냥 엔터쳐버리면 보안때문에 안됨 
방법없음 
rootpassword는 어마어마하게 중요한겁니다.

그 다음에 
`sudo systemctl status mysql`
하면 mysql의 상태를 볼 수 있음 
#### service는 레거시, systemctl 쓰자! 

접속을 하고싶으면 
`mysql -u root -p` 

나가고싶으면 exit

* 추천책 `real mysql`. 학부때 DB를 봤을때! 

## mysql character-set 설정 
`mysql> status`

`latin1`인 경우가 많다 
이걸 utf-8로 바꾸자!

옛날에는 mysql안에 있는 my.conf에 들어있었는데 
이젠 안됨 


### 흔히 하는 실수 
root 사용자로 개발해서 하면 안됨 
탈취당했을때 위험도가 너무 큼 
그래서 사용자를 만들어야함 


## mysql
관계형 데이터베이스 RDB
data는 정보 
컴퓨터에 저장할 수 있는 형태 인것
의미 있는 사실을 뽑아내면 information

그보다 한단계 높아진 좀더 유용한 지식 knowledge 

그거보다 나아진건 insight 회사에 도움이 되는 지식 

결과적으로 원하는 궁극적인 목표는 insight, 예측을 하고 싶은건데 
신뢰도 100%는 절대 없음 

mysql는 DBMS임 
excel도 db임 

관계형은 데이터와 데이터의 관계가 중요함 
학생과 수업사이에 `듣는다` 라는 관계 

-
천공카드 썰 
천공카드가 80자ㅏㅏㅏㅏ 
VGA라고 부르는 그래픽 카드 표준 해상도 640 * 480 
아스키로 글자를 쓰면 하나에 8pixel 
8 * 80이라서 640임 
최초 TV? 비율인 4:3 

-

IBM에서 DB2라는 관계형DB를 만듦
마이클 스톰브레이커…?
인그레스라고 하는 RDB
대학원생들을 조져서 
postgress 를 만듦
쟁고에 있음 오픈형중에 제일 좋음 

-
Mysql 은 오픈소스였는데 오라클이 먹음
오라클이 관계형 디비의 대부분! 젤좋음


-
nosql 관계형 디비가 아님
Not only sql 


-
관계형 DB 는
Transaction 지원 
이는 concurrency가 중요함.
주로 전자상거래나 ! 그런거에는 아직도 씀

어려운 기술이여서 느리고 무거움 

요즘은 big data니까 이럴땐 
nosql을 씀 

-

RDB는 기초만 해도 한학기
nosql는 종류마다 다르지만 하루만 배워도 
서비스에 적용할 수 있음 
nosql는 쓰기가 쉽거나 관계형 db가 못다루는 영역을 하는 것 

-
Sql 
Structed query language
시퀄이라고 부르기도함 
그 사람들은 쿼리language를 SEQUEL이라고 했음 
-

```
CREATE USER '유저명'@'%' IDENTIFIED BY '비밀번호' ;
# DB의 %는 모든이라는 뜻. 어디에서나 접속가능한 유저를 만들겠따
끝은 항상 semicolon

CREATE DATABASE db이름 

GRANT ALL ON db이름.* TO '유저명'@'%';
# db안의 모든 테이블의 권한을 이 사용자에게 주겠다. 
# ALL이 아니라 READ WRITE같은걸 넣으면 특정 권한을 줄 수 있음 

FLUSH PRIVILEGES; 
# 실제 업데이트 

이거 끝나고 

mysql -u 유저명 -p
하고 패스워드 하면됨 

그리고 테이블 확인
show databases; 
```


### sequel pro 다운로드 
맥에서 mysql 볼수 있는 프로그램

얘를 통해서 접속을 해야함 
설치하고 나면 연결을 해야함. 접속을 만들어야하는데 
+를 눌러서 자주사용하는 접속을 만들수있음 
이름도 쓰고 
Host 주소는 웹서버 주소를 적는 거임(aws)

username은 dbusername
하고 pw도 dbusername
딱하면 안됨 

 막혀있따는 뜻 
포트를 열어줘야함. 
아예 막혀있으면 패킷이 새기때문에 오래걸림

통신은 갔는데 서버에서 넌 안돼! 하면 즉시 돌아옴

Security group - inbound edit해서 
Add rule한다음에 mysql을 허용해주면됨.
custom을 anywhere로 하면됨
TCP 3306번 

그래도 여전히 안됨 
db기때문에 외부 접속이 안되도록 막혀있음 

설정 파일 중에 보면 

```
cd /etc/mysql
```

![](mysql_intro/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202017-07-21%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%203.30.51.png)

-
Public ip를 알고싶으면 `curl 169.254.169.254/latest/meta-data/public-ipv4`
아마존 리눅스에서만 되는거. 
169.254.169.254 클라우드를 관리하는 하이퍼바이저에게 요청을 보내서 내 아이피 보내는것 ! 
이를 응용해서 마지막만 `instance-id`  같은걸로 하면 

-

`set nu`

vi에서 써보기
-

## sql 문법

USE db이름 
AUTO_INCREMENT
PRIMARY KEY

VARCHAR 
한글 한글자가 대충 3바이트쯤 먹음 

```
USE junekimdb;
DROP TABLE IF EXISTS USER;
CREATE TABLE USER(
	ID INT PRIMARY KEY AUTO_INCREMENT, 
	NAME VARCHAR(64),
	START_DATE DATETIME
);

INSERT INTO USER VALUES(null,'junekim','2017-07-21');
INSERT INTO USER (NAME) VALUES ('jk'),('totoro'),('zedd');
INSERT INTO USER (NAME,START_DATE) VALUES ('준킴',NOW());

SELECT * FROM USER;

SELECT NAME FROM USER WHERE NAME = 'junekim';
SELECT NAME, START_DATE FROM USER WHERE START_DATE > '1994-06-13' AND NAME LIKE '%june%';

SELECT NAME, START_DATE 
FROM USER 
WHERE START_DATE IS NULL AND NAME LIKE 't%';



UPDATE USER SET NAME = 'coffee' WHERE NAME LIKE '%totoro%';

UPDATE USER SET START_DATE = NOW();


DELETE FROM USER WHERE NAME LIKE '%tom%';


---
SALARY DEC(10,2)
소숫점 두자리, 10자리를 쓰겠다.


CREATE TABLE PROFESSOR(
	PID INT PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(64),
	SALARY DECIMAL(10,2)
);

INSERT INTO PROFESSOR VALUES(NULL,"김정",99999.99);

CREATE TABLE COURSE(
	CID CHAR(5) PRIMARY KEY,
	PROF_ID INT
	
);

ALTER TABLE COURSE ADD COLUMN CNAME VARCHAR(64) AFTER CID;

INSERT INTO COURSE VALUES("CS101","iOS",1);

SELECT * FROM COURSE;
SELECT * FROM COURSE C JOIN PROFESSOR P ON C.PROF_ID = P.PID
```


### CRUD
일반적인 DB는
R가 대부분 제일 중요함

주문은 C가 더 많이 일어남
OLTP 동네에서는 쓰기가 굉장히 중요함 


### DB의 관계 


—

조별로 USER테이블에 200만건을 넣어보세요 

```
LOAD DATA LOCAL INFILE '/Users/~'
INTO TABLE USER
FIELDS TERMINATED BY '/'
IGNORE 1LINES;
```

LOAD DATA는 1~2분이면 끝남 


`SELECT COUNT(*) FROM USER`

`scp -i pem키 data.csv 서버주소`
서버로 파일 옮기는  명령어 


#### 왜 primary key로 찾으면 빨리 찾을까?
디비는 레코드가 page로 저장되어있다 
연속된 페이지로 계속 만드는 거이 ㅁ

주소록을 짜고 있음 
사람을 insert순서대로 붙일거냐?
정렬해서 넣을거냐?


파일을 정렬할때 ㄴ머지소트 
디스크에 들어있기때문에. 

레코드가 순서대로 있으면 
Binary search 할 수 있음 
Log n 
세네번 돌면 금방 나옴

하지만 실제 DB는
매번 파일 정렬하면 힘들엉
인서트할때마다 정렬하면 넘 힘들어 
`삽입을 효율적으로 하기위해서 정렬을 생략한다`
`레코드는 그래서 정렬이 안되어있고 들어오는 순서대로 온다 `
`그런데도 PK 검색은 빠르다`
`그런데 일반 column 검색은 느리다 `
Primary key에대해서 그럼 어떠케 빨리한겨 
다른 컬럼에 대해서는 좀 느림 

`B-tree 를 사용하기 때문이다`

끝에 pointer가 매달려있음 
8k에 숫자가 많이 들어있고 
대충 3번만 가면 원하는 데이터를 찾을 수 있음 

그래서 보통 DB를 그릴때는 
pk에 대해서 b-tree가 인덱스가 걸려있고 
얘가 레코드에 대한 포인터를 달려있음
pk  검색을 하면 b-tree 인덱스를 타니까 훨씬 빠름 

pk로는 검색이 금방된다 
일반적인 DB의 구조 

사실 dB에서 쓰는 트리는 `B+ tree임` 


레코드의 포인터가 달려있음 메모리 포인터가 아니고 
Key는 hhoa998 
v: (5(페이지번호),2) 이걸 RID라고 (record번호)
(아래 툼스톤 뒤로 붙은 번호 ) 

첫번째로는 페이지번호를 알아야함

자동으로 Pk에 생긴걸 Clustering index라고 함 
근데 수동으로 index를 만들 수 있음 , 그래서 검색 빠르게하려고!
Secondary index
date로 index를 만든다고 하자 
얘는 datat를 못가르킴 

대신 pk를 가리켜서 Clustering index를 다시 사용해야함

그래서 clustering index 를 거쳐서 한번 검색을 해야함
Secondary index 는 미묘하게 더 느리긴하지만 괜찮음. 

-

그 안에 원하는 레코드가 있다고 할 때 
통채로 다 읽지 않고 정확하게 저걸 찾아내려면 ?

레코드 각각은 다 길이가 제각각임. 레코드ㅏㄱ 있을때/ 없을 때 + archer
그래서 size * 해서 찾아갈 수 가 없음 

이 페이지 맨 뒤에는 메타데이터 - Transaction 정보를 적어줌(BOOK)
그 앞에 
(어느 위치에 있는지 , 몇바이트) 
(200,30) 식으로 쭉 붙여줌 
(-1,0) 이면 삭제된 것 (tombstone)

[레코드들]
FREE SPACE
 3 2 1  0  [BOOK]


record가 길어져서 업데이트 해야하면 그 자리만 지우고 free space에 붙인다음에 
가리키는 자리를 업데이트해줌.


## 인덱스 만들기 
의미 있는걸로 ! 
```
CREATE INDEX woowa_idx ON user(필드명);
# 이 필드에 대해서  secondary index가 만들어진다.
# 시간이 좀 걸림 b+ tree만들어야하니까! 9초.. 

```

Index만들면 insert가 살짝 느려짐 
`insert 속도를 희생하고 공간낭비를 좀 하는 대신에 검색속도를 높이겠다`
`DB에는 검색이 중요하니까 `


```
explain SELECT * from user WHERE id='홀롤롤';
# optimizer라는게 DBㅔ 들어있어서 실행안해도 가르쳐줌 
# 여기서 ref가 index가 있고 없음! type ALL은 DB를 다 뒤지겠따! 
# index만들어도 전체의 25% 이상이면 전체를 검색하는게 빠름. 그럴땐 옵티마이저가 알아서 ALL로 만들어줌. 왜냐하면 key는 랜덤이고 db쭉은 sequence기 때문
# type range => 인덱스를 사용해서 범위검색을 하겠다.
```
-

Turbo pascal 만든 사람이 
DelPI을 만듬 
GUI로 data다루는..

이 아조씨가 MS에 입사해서 만든게 c#
java보다 생산성이 좋고 
GUI 만들기 쉬움

-


