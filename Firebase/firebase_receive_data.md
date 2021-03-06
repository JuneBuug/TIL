# 파이어베이스 DB 로직에서 데이터 받아오기

## 파이어베이스 콘솔

```
# 이 상위는 프로젝트 이름
{
  "internship" : {
    "one" : {
      "endDate" : "2017-08-31",
      "title" : "우아한 형제들 테크캠프"
    }
  }
}
```

와 같이 되어있는 트리가 있다.

테스트용으로 쓸 때는

```
{
  "rules": {

    ".read": true,
    ".write": true
  }
}
```
로 두고, 인증 없이도 자유롭게 읽고 쓰기가 가능하도록 하자.


## 안드로이드 코드

1. manifest에 인터넷 권한을 추가하자.

```
  <uses-permission android:name="android.permission.INTERNET" />
```

2. **FirebaseDatabase를 불러온 다음 DataReference를 불러오자.**

```
# 그냥 myRef 를 FirebaseDatabase.getInstance().getRef 하면 어째선지 안됐다.
FirebaseDatabase db = FirebaseDatabase.getInstance();
myRef = db.getReference("internship").child("one");
```

3. Listener를 달아준다.

```

myRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                // Get Post object and use the values to update the UI
                Internship internship = dataSnapshot.getValue(Internship.class);
                # 받아줘야할만한 데이터 모델 java 파일로 받아준다.
                # 여기에서 데이터를 UI에 넣는 처리.ㅜ정
                // [START_EXCLUDE]
                dummys.add(internship);

                // [END_EXCLUDE]
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Getting Post failed, log a message
                Log.w(TAG, "loadPost:onCancelled", databaseError.toException());
                // [START_EXCLUDE]
                Toast.makeText(getActivity(), "Failed to load post.",
                        Toast.LENGTH_SHORT).show();
                // [END_EXCLUDE]
            }
        });
```

### 주의할 점

List로 받아주고 싶을 땐 이렇게 한다.

```
myRef = db.getReference("internship");
// 이 디렉토리 하위의 one, two 등의 자식들을 전부 받아주고싶다.
```

```

myRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {

                //
                for(DataSnapshot snapshot: dataSnapshot.getchildren()){
                  Internship Internship = snapshot.getValue(Internship.class);
                }

                // [END_EXCLUDE]
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Getting Post failed, log a message
                Log.w(TAG, "loadPost:onCancelled", databaseError.toException());
                // [START_EXCLUDE]
                Toast.makeText(getActivity(), "Failed to load post.",
                        Toast.LENGTH_SHORT).show();
                // [END_EXCLUDE]
            }
        });
```

즉, dataSnapshot에 getchildren을 호출하면
children을 하나하나 돈다.
children에 해당하는 데이터 모델 클래스를 만들어(여기서는 Internship)
호출해주면 끝!


### dataSnapshot 이란?
침착하게 API 문서를 보자.

ref: https://firebase.google.com/docs/reference/android/com/google/firebase/database/DataSnapshot

DataSnapshot의 인스턴스는, Firebase의 데이터가 위치한 곳에서 받아온 데이터를 포함한다. 즉, 언제든지 파이어베이스에서 데이터를 받아오면 datasnapshot의 형태로 받아온다.

datasnapshot은 변경이 불가능한, 원격 데이터베이스의 복사본이다. datasnapshot은 편집할 수 없고, 변하지도 않는다. 현 위치의 데이터를 변경하기 위해서는 `DatabaseReference` 의 `setValue(Object)` 와 같은 메소드를 사용한다. 

이 datasnapshot은, 리스너의 메소드 안에서 받아올 수 있다.
쓸 수 있는 리스너는 다음과 같다.


```
public ChildEventListener addChildEventListener (ChildEventListener listener)

이 (데이터베이스의) 위치 기준으로, 하위(child) event들에 대해서 리스너를 단다.
만약 (이 위치 기준) 하위 항목이 추가,삭제,변경, 이동될 경우, 이 리스너가 작동한다.


public void addListenerForSingleValueEvent (ValueEventListener listener)

이 (데이터베이스의) 위치에서 데이터의 변경을 1회만 보는 리스너를 단다. 이 위치에서의 데이터의 값을 한번만 본다.


public ValueEventListener addValueEventListener (ValueEventListener listener)

이 위치에 있는 데이터에 대한 리스너를 단다. 데이터가 변할 때마다, 이 리스너가 호출되어 변경할 수 없는 datasnapshot을 가져온다.

```
