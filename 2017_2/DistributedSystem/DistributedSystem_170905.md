# 분산처리 20170905

## 교재 
Distributed System. pearson책 
Fifth edition

## 평가
중간 35/ 기말 35/ 프로젝트 20/ 기타 10
프로젝트를 많이 줄였음
중간 기말 45 45 로 갈수도있음

조교님 송충건 - 라이시움 321A


## 분산시스템의 개념 
분산시스템 : 분산 운영체제 (DOS)
Operating system은 centralized system을 중심으로 얘기했던 것 
분산은  stand-alone시스템들을 연결한 환경 
하나의 시스템이 운영되는것처럼 사용하고자하는 생각에서!
그럼 그걸 어떻게 운영할거냐는 이슈 때문에 나옴

> System in which hardware or software components located at networked computers communicate and coordinate their actions only by message passing.  

Communicating 방식 : message passing / shared memory 방식 이 있는데 
Message passing으로만 상호 통신하고 coordinate(synchronize한다) 
Synchronize - 특정한 DB에 대한 access 같은. 

Concurrency control!
1: N-1로 통신하면서 맞춰야하는데 
이런걸 해결해야함.

### 결과 

#### Concurrency
A와 B간 순서를 얘기하기 어려움
`happen before`   키워드처럼 사용

* deadlock 
detection자체가 어려움 

#### no global clock 
* yes local clock 
ㅋㅋㅋㅋㅋ
각각 시스템에 있는 clock을 맞출수있나? - 못맞춤.
물론 휴대폰은 외부에서 sync 하니까 가능한거임
하지만 모든 standalone system은 안됨
Computer system 모두는 안되지

* 현실적으로 global clock이 없음
sync하려는 시도에는 한계가 있음 
 
그래서 physical clock을 사용하지않고 logical clock을 사용함

#### independent failures 

네트워크에서 잘못이 Computer system의 isolation을 초래함
network를 끊어진것에 대해서 확실하게 모름
uncertainty를 가짐.


### 분산시스템 예 

* Web search 
방대한 인터넷 환경에서 뭔가를 찾을 때 

### Trends in distributed systems

Open-ended 
필요할 때 add하고 없을 때 삭제하고 하는 게 자유롭다. 

-

* Intranet
작은 분산시스템이라고 할수있음



