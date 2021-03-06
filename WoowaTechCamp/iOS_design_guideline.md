# Human Interface Guidelines
## iOS Design 의 큰 컨셉
1. Clarity
시스템 전체에서, text는 어떤 사이즈든 잘 읽혀야하고, 아이콘은 정확해야하며, 장식은 미묘하고 적절하며, 기능에 대해 잘 생각하며 디자인을 만들어야합니다.
여백 / 색상 / 폰트 / 그래픽 / 인터페이스 요소가 중요한 내용을 잘 드러내고, 상호동작을 전달해야합니다.
2.  Deference
부드러운 모션과 아름다운 인터페이스가 사람들이 컨텐츠를 이해하고 상호작용하는데 도움을 줍니다.
투명도와 blur를 쓰고, bezel / gradients / drop shadow를 자제해서 인터페이스를 가볍고 airy하게 합니다.
3. Depth
개별적인 비주얼 레이어와 현실감있는 모션이 계층관계에 대해서 알려주고, 생동감을 주며, 이해를 돕습니다.


## iOS 디자인시 명심해야할 점

1. Aesthetic Integrity
기능에 맞도록 앱을 디자인.
중요한 일을 하는 앱은 미묘하고 과하지않은 그래픽, 표준화된 버튼 등이 포인트고, 게임은 즐거움을 표현하는, 사람들의 눈을 끄는 디자인이 필요.

2. Consistency
시스템이 제공하는 인터페이스 요소들을 사용해야함.
사람들이 기대하는 대로 동작하는 앱이 되어야!

3. Direct Manipulation
content에 대한 직접 조작은 사람들이 참여하도록 만듦.
화면 전환이나 gesture를 사용하는 경우가 있겠음.

4. Feedback
피드백은 사람들이 방금 뭐했는지 알려주고, 결과를 보여줘 유저들이 자신의 행동의 결과를 알게하는 걸 말함.
iOS는 기본적으로 모든 유저 액션에 대해서 인지할수있는 피드백을 포함함.
tap했을때 잠시 highlight된다든가!

5. Metaphor
실제 세계든 디지털세계든, 은유적인 액션으로 화면을 구성하면 더 잘이해함.
e-book을 넘긴다든가, 스위치를 토글한다든가.

6. User Control
앱이 결정권을 갖는게 아니라 유저가 결정권을 가진다.
유저에게 자유도를 높이면서 원하지않는 결과는 안나오도록 균형을 잡는게 중요함.
상호작용할 수 있는 요소들을 친근하고 예측 가능하게 만들고, 파괴적인 액션을 승인할수있게하고, 취소 기능을 쉽게 만들어라!

## Interface Essentials
UIKit는 자주 쓰이는 인터페이스 요소를 모아놓은 프로그래밍 프레임워크.
시스템 전반에 쓰이기때문에 일관성을 유지하는데 좋고, 커스텀도 쉽다.
UIKit은 크게 3가지 분류로 나뉜다.

1. Bars
사람들이 앱의 어느 부분에 있는지 알려줌.
2.  Views
주로 앱에서 보는 컨텐츠 부분이 있음.
3. Controls
액션을 시작함. 버튼 / 스위치/ 텍스트 필드 / 프로그레스 표시 등이 해당함.


### 3D Touch
터치 기반 상호작용에 또다른 차원을 더함. 지원되는 기기에서는 터치스크린을 누르는 압력을 조절해서 추가적인 기능을 하게 할 수 있음.


#### Peek and Pop

* Peek : 살짝 눌렀을 때, 해당 아이템의 미리보기가 뜨는 것. 손을 떼면 사라진다.
* Pop: 더 꾹누르면 컨텐츠가 보임.

preview를 디자인할때는 컨텐츠가 풍부하게 하고, 손가락이 가리지않을만큼 그게 디자인하고, peek / pop을 적용했다면 다른 곳에서도 잘 적용할 것.
모든 peek이 pop될 수 있도록할 것.
peek view에서는 버튼 처럼 보이는 걸 지양할 것.
peeking과 edit 메뉴를 같은 아이템에 적용하지 말것
peek할땐 open버튼 을 넣지 말것
peek이 item action의 유일한 방법이 되게 하지 말 것

### Accessibility

시각- 청각 등 장애가 있는 사용자들에게 접근성을 제공하기
1. 이미지/ 아이콘 / 인터페이스을 못쓸 경우의 대안으로 텍스트 label제공
2. accessbility option을 잘 충족하는지 체크하기.
3. closed captions와 audio description을 추가하기. 청각/시각 장애가 있는 사람들에게 유용

### Audio
소리가 앱의 주요 요소이든 아니든 어떻게 사용자들이 받아들이는지는 알아야함.

유저들은 볼륨버튼, 무음 스위치, 헤드폰의 조정버튼과 스크린의 볼륨 조절 슬라이더를 사용함.

* Slience
사람들은 방해받기 싫어서 무음모드를 사용함. 만약 기계가 무음모드라면, 명백한 소리만 나야함.(음악 재생 중의 오디오라든가)
* Volume
사람들은 볼륨이 시스템 전체로 변화하기를 기대함.
시스템 볼륨을 줄이면 앱 볼륨도 줄도록 기대한다는 뜻
* Headphones
사람들은 손을 편하게 쓰려고 헤드폰을 씀. 헤드폰을 연결하면 사운드가 헤드폰으로 자동으로 연결되어야함.

1. 자동으로 볼륨을 조절하지만, 전체 볼륨을 아님
2. 적절한 시기에 사운드가 re-routing되도록 설정하기
3. 시스템이 제공한 볼륨 뷰를 사용
4. 짧은 소리나 진동을 하려면 시스템의 사운드 서비스를 사용
5. 앱에 주요한 부분이 소리라면 분류를 나누기.
6. 중간에 방해가 있다면, 기다린 후에 그 이벤트가 끝나면 다시 재생하기
7. 다른 앱들로 하여금 당신 앱이 잠시 오디오를 재생중이라는 걸 알게하기
8. 오디오 컨트롤을 재정의해서 쓰지 말기


### Authentication

* 로그인을 최대한 늦추기
* 인증의 장점을 설명하고 서비스에 가입하도록 유도하기
* 적절한 키보드를 보여줘서 데이터 입력을 최소화하기.

### Data Entry

* 가능한 옵션과 현재 옵션을 표시하기
* 가능하다면 시스템으로부터 필요한 정보를 얻어서 사람들이 입력하지 않아도되게하기
* 합리적인 기본 값을 설정하기
* 필요한 값을 수집한 이후에만 next 버튼등을 활성화하기
* 동적으로 필드값을 검사하기. 엄청 긴 폼을 채우고 다시 돌아가지 않도록 바로바로
* 값을 고르는게 편하도록 하기. 값들을 분류하거나 합리적인 방식으로 놓아서.
* 텍스트필드에 힌트를 보여주기.

### Drag and drop

* 모든 선택가능하고 편집되는 컨텐츠에 drag & drop이 되도로가기
* 컨텐츠가 컨트롤에 떨어지도록하기
* 기본 textview와 textfields를 사용하자
* 여러 아이템에 대한 지원을 고려해보자

.. Beta이므로 생략하고 싶다


### Feedback

* status와 다른 피드백들을 잘 interface에 녹여내기.
* 필요없는 alert를 피하기


### File 다루기
* 만약 지워지거나 삭제되지 않았다면 작업이 보존되도록하기
* local- only 파일을 만드는 옵션을 만들지 말기
* 직관적인 그래픽 파일 브라우징 인터페이스 적용하기
* 앱을 떠나지 않고 파일 미리보기가 가능하게 하기
* 다른 앱들과 적절하게 파일 공유가 가능하게 하기


### 첫 launch(screen) 경험
* 런칭 스크린을 제공해라. 앱이 시작할때 뜨는 게 런치스크린이고, 최초 컨텐츠가 로딩되는 동안 떠서 앱이 빠르다는 인상을 줄 수 있음.
* 적절한 방향으로 런칭을 해라. 만약 앱이 가로 세로를 다 지원한다면 현재 기기의 방향에서 런칭하는게 옳다.
* 액션을 빨리 제공해라. 앱을 쓰는 데 시간이 걸리게 하는 스플래시 스크린이나 메뉴 등을 없애라.
* 도움에 대한 필요를 예측해라. 팁을 줘라.
* 튜토리얼에서는 필요한것만 줘라.
* 앱을 배우는 과정이 즐겁게하라
* 맨처음에 설정 정보를 묻지마라. 나중에 변경가능하게 하든지.
* 앱 내 라이센스 동의등을 보여주는 걸 자제해라
* 앱이 다시 시작할 때 이전 상태를 복원해라
* 너무 빠르게 혹은 자주 별점 달라고 요청하지 마라
* 리부트 하라고 하지마라 


### Gesture
* 일반적이고 스탠다드인 gesture 사용해라
* 시스템 전반에 있는 제스처를 막지마라
* 스탠다드가 아닌 액션에 스탠다드 gesture쓰지마라
* 단축키를 제공해라
* 일부앱에서는 손가락 여러개를 쓰는 제스쳐 사용
