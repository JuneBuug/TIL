# Software Engineering : preparation for Quiz

## SWEBOK (Software Engineering Body of Knowledge)
소프트웨어 요구 사항 / 디자인 / 만들기 / 테스트 / 유지 /  설정 관리 / 엔지니어링 관리 / 엔지니어링 과정 / 모델&메소드 엔지니어링  / 소프트웨어 품질 / 엔지니어링 전문 연습 / 경제 / 컴퓨팅 기반 / 수학적 기반 / 공학적 기반 
## Evaluation Assurance Levels
a numerical grade assigned following the completion of a Common Criteria security evaluation, an international standard in effect since 1999.
Common Criteria security evaluation 에 따라 주어진 점수.

높을수록 기준에 잘 맞는다는 뜻. 
특정 EAL을 달성하려면 `assurance requirements` 를 만족시켜야함. 
Documentation / design analysis/ functional testing / penetration testing.  물론 높을 수록 이런게 잘 되어있고, 시간과 돈이 많이 듦.

`TOE: target of evaluation`

1. EAL1 : Functionally tested (기능적 실험완료)
작동이 바르고 , 신뢰성도 있지만 보안에 대해서는 중요하게 안여기는 수준
2. EAL2 : Structrually tested(구조적 실험완료)
디자인 정보와 실험 결과의 전달에 있어서 개발자의 도움이 필요함.
상용규격과 일치할 필요는 없음
3. EAL3 : Methodically Tested and checked
..?
4. EAL4 : Methodically Designed, Tested and Reviewed
개발자가 엄격하게 관리해서 상용개발 규범 하의 최고 보안을 보장하는 수준.
상용 운영체제들. 
Windows / Redhat linux 
5. EAL5 : Semiformally designed and tested
상용 개발 과정에서는 보안적으로 최고 수준.
6. EAL6: Semiformally Verified Design and tested
7. EVL7 : Formally verified design and tested 
수준에 맞는 소프트웨어 공학 절차가 있음. 소프트웨어는 수준에 맞는 평가를 받고, 수준에 맞게 사용되어야 함.## Software crisis > 요구된 시간안에 쓸모있고 효율적인 프로그램을 작성하는 것의 어려움을 지칭하는 말.  

Software crisis는 컴퓨터 파워의 빠른 성장과 해결할 수 없는 문제들의 복잡도 때문임 ㅎㅎ

Software crisis는 다양한 방식으로 나타난다.
* projects running over-budget
* projects running over-time
* software was very inefficient
* Software was of low quality
* Software often did not meet requirements
* Projects were unmanageable and code difficult to maintain
* Software was never delivered (vaporware: 발표했지만 사라진거) 
## Mythical Man-months > 늦은 프로젝트에 사람을 더 투입하면 프로젝트가 더 늦어진다  
Ex) IBM에서 OS/360을 개발할 때, 늦은 프로젝트에 사람을 추가했는데 결국 프로젝트를 더 늦추고 말았음. 
ALGOL 컴파일러를 할 때도, 개발자의 수에 상관없이 6개월이 걸렸음.

Man-month 자체는 한 사람이 한 달에 할 수 있는 일의 달을 나타내는 이론적 단위.
이 법칙은 실제 쓸모있는 일을 측정할 때 man-month를 사용하는 거 자체가 말도 안된다는 거임.

왜? 복잡한 프로젝트, 소통없이도 해낼 수 있는 각각의 일로 완벽하게 떨어질수가 없음. task간의 복잡한 관계와 그걸 하는 사람들에 대한 상호작용을 알고 있어야함. 

그래서 늦은 프로젝트에 사람을 투여하면, 새로운 사람들이 프로젝트에 대해서 배워야하는 오버헤드가 결국 전체 시간을 잡아먹게 됨. 
n명이 상호작용하려면 O(n^2)니까. 


