# 프래그먼트 생명주기

기초를 안다고 생각했는데 개인 프로젝트를 하면서
제대로 모른다는 점을 알게 되었다!
프래그먼트를 엄청 많이 쓰면서도 생명주기를 잘 파악하지 못한다는 건 말이 안된다.

생명주기를 적어본다.


## 액티비티의 생명주기

프래그먼트와 액티비티의 생명주기는 뗄 수 가 없는 존재여서 액티비티의 생명주기를 다뤄본다.

```
@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // The activity is being created.
    }
# 1 반드시 구현해야함. 순서상 가장 먼저 액티비티 실행과 동시에 호출됨. 필요한 리소스 초기화. 아직 View는 만들어지지 않은 상태일 수 있음.

@Override
   protected void onStart() {
       super.onStart();
       // The activity is about to become visible.
   }
# 2 유저에게 액티비티가 곧 보이도록 단계. 짧음

@Override
   protected void onResume() {
       super.onResume();
       // The activity has become visible (it is now "resumed").
   }
# 3 이때 액티비티가 전면에 나와서 유저와 인터랙션을 시작. 액티비티가 소멸되지 않고 재시작 될 때 가장 먼저 이 액티비티로 돌아옴. 화면 포커스 관련 리소스(Camera 등)를 설정해주어야함.

액티비티 실행

@Override
    protected void onPause() {
        super.onPause();
        // Another activity is taking focus (this activity is about to be "paused").
    }
# 4 다른 액티비티로 이동 / 다른 앱이 인터럽트할 때 호출됨. 포커스가 없으면 사라짐. onResume에서 설정해준 값들을 해제해주는 것이 좋고, 시간이 모자랄 수 있음. 소멸되지 않아도 호출됨.

@Override
    protected void onStop() {
        super.onStop();
        // The activity is no longer visible (it is now "stopped")
    }
# 5 액티비티가 더이상 보이는 상태가 아님. onPause에서 시간이 모자라 해주지 못했던 것들을 처리해주는게 좋음. 여기서는 두가지 선택지가 있는데, 1) 유저가 onStop() 한다음 돌아오는 경우 onResume으로 감. 2) finish() 를 호출하면 onDestroy()를 호출하며 액티비티가 없어짐. onSaveInstanceState()을 이 메소드 전에 호출하며 이 값은 onCreate에서 복원된다고함. 즉 액티비티를 소멸 시킨다음에도 그 화면을 유지해주기 위해서 저장함.


@Override
   protected void onDestroy() {
       super.onDestroy();
       // The activity is about to be destroyed.
   }
# 6 액티비티가 파괴됨. 가로 => 세로화면 전환도 액티비티 파괴라고함.


```


## 프래그먼트, 그리고 생명주기
프래그먼트는 API 11부터 도입된 디자인 개념에 속함.
프래그먼트는 보통 액티비티의 일부이고, 자체적으로 유저와 상호작용함.

프래그먼트의 보통 생명주기는 다음과 같다.
```

@Override
  public void onAttach (Context context){
     super.onAttach(context);
  }
# 0 액티비티에 프래그먼트가 붙을 때 호출됨.

@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // The activity is being created.
    }
# 1 필수 구현. 프래그먼트 생성 시 호출됨. UI 초기화하면 안됨.

@Override
  public void onCreateView(){

  }
# 2 필수 구현. View 객체를 얻을 수 있는 곧임.

@Override
  public void onDestroyView(){

  }
# View가 제거 되는 단계.

@Override
  public void onDetach (Context context){
     super.onDetach(context);
  }
# 프래그먼트를 액티비티에서 분리

기타 onResume / onStart / onPause(필수)/ onStop 등은 액티비티와 유사하다.     
```

액티비티의 수명주기와 그에 붙어있는 프래그먼트의 생명주기는 밀접한 관련을 가진다.
onPause가 액티비티에서 호출되면, 붙어있는 프래그먼트는 각각 onPause를 받는다.
하지만 액티비티와 다른 상태들이 있으므로 주의해서 써야함!


## 참고
https://developer.android.com/guide/components/fragments.html
http://developer88.tistory.com/69
