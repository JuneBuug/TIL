# HTML / CSS 
* 옆사람 + 계속해서 배워야하는 양면성이 제일 힘듦
* 리뷰 + 스터디 + 설명 듣기 등을 통해 성장함
* 같이 공부하는 방법을 모름!
* 상당한 조직들은 페어 프로그래밍 / 리뷰하는 데 시간을 많이 쏟음
* 고고 ㅎ,ㅎ

## web ?
* 인터넷 ? 브라우저?
* 웹은 브라우저(장치)가 중요함 /OS에 올라가는 브라우저라는 애플리케이션 위에서 동작되는 것
* 문서를 주고 받기위해서 시작된 것
* 주고 받기 위한 약속(프로토콜)을 지정함
* (브라우저만 있으면) (특정 OS 등에 따라서 크게 영향 안받고)  어떤 장치에서나 쉽게 접근할 수 있는 큰 장점이 있음. **공유가 용이: 고유 자원uri가 있어서**
* 한계 : 브라우저 위에서 돌아가서 (앱대비) 느림. 빠른 연산이 필요한 건 앱
* OS를 대기업들이 장악하고 있음
* 웨일ㅋㅋㅋㅋㅋㅋ그냥 크롬이라곸ㅋㅋㅋㅋㅋㅋ
* OS_브라우저_웹표준기구도 대기업이 쥐고있음
* 때문에 웹이 꾸준히 올라가기 어려움
* 웹개발자는 브라우저를 여러개 + 기기도 여러개 해서 테스트해봐야함 - OS 갯수 * 브라우저 갯수 * 버전 갯수 ㅋㅋㅋㅋㅋㅋ만큼. / 호환성 이슈
* 테스트 자동화도 해야함
* 웹 서비스 라는 용어를 많이 함
* 어떤 기술들이 필요할까?
* 백엔드 + 스토리지 + 서버나 브라우저 단에서의 파서 + 프로토콜 + 환경세팅 +…
* url 은 만들기 나름임
* 메소드에 따라 서버가 빨리 해석 가능함
* 서버는 데몬 (항상 프로세스가 떠있음) 요청을 주고 받기위해 대기
* 요청도 병렬이 잘안됨 최대 동시 요청이 3~4개밖에 안된다구함


### 앱
요즘엔 모바일 애플리케이션을 얘기함
이전에는 그냥 CS 프로그램이라고 얘기함
앱은 어떤 언어로도 짤수있는 거임
OS 에 올라가는 성격

### client
모호함 => 지양
브라우저 / 유저 / 데스크탑 / 랩탑 모두 지칭할 수 있기때문

### 프로젝트에 관해
* 토이프로젝트에서 벗어나는 게 중요
* 회사 가면 유지 / 보수하는 경험을 많이하게됨
* 친구들에게 사용하게 해보고 또 바꿔보고

### 좋은 코드와 리팩토링
* 의도가 드러나는 코드여야 한다
* div로 도배된 html 보다는 …
* span : block형태(위에서 아래로 하나씩밖에 못쌓음) 이 아님
* 출시와 동시에 시작이다

## CSS
* 적절한 곳에  class 나  id 을! 상위에 줘서 같은 구조일때도 구분할 수 있게 한다.
* id는 하위에 잘 안줌. 고유한걸로 줌
* selector 문법
* DOM API에서도 query selector 문법이 있음.
* inline 협업에서 어려울수있고 , 수정이 어려움
* internal 서버에 request가 한번 감, 그러나 그때 코드가 늘어나니까 거기서 거기임
* external request가 추가로 감
* link를 여러개 넣을 수도 있음.
* 소스코드를 배포할때는 request를 줄이는게 나아서, css를 묶어서 배포하는 경우가 있음. 머지도구가 합쳐주고 빈칸도 없애줌. => 최소한의 용량으로 배포.
* js나 html도 마찬가지. 웹서버에서 gzip해서 내려주기도 함(브라우저에서는 기본 언집가능)
* 개발자도구에서 위쪽에 나오는 애들이 우선순위가 높은 스타일임.
* 최종 반영된건 computed에서 확인할 수 있음.
* 공백으로 하는건 이 아래 모든 애들, > 는 바로 아래

```
selector:nth-child : 자식의 갯수를 먼저 센 다음 그게 해당하는 selector면.
```
* 16px = 1 em (엠)

중앙
* line-height를 height값으로 준다

## layout
* relative 잘 안씀

### html emmet
자동화 툴

### @media query
* 분기문

### border 와 outline
border는 1픽셀씩 먹어서 테스트할 때 안씀
outline은 덧칠하게됨

### css 주석ㅋㅋㅋ앞에 숫자를 붙인다

### float의 문제점?
Float 하단에 뭐가 있으면 위에 가버림.
위 부분은 float하고 아래는 아니게해주려면 clear:both

### text-indent
들여쓰기

### inline-block 자제하기

### 향후 업데이트나 추가 고려
리사이즈는 js 로 조정을 많이함. 리사이즈 이벤트가 있을 때마다 정렬자체를 다시 하도록 하게 할 수 있음
여기에 애니메이션 추가할 수도 있고.
