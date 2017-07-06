# 파이어베이스 DB 로직에서 데이터 저장하기

파이어베이스 콘솔이 로딩이 오래 걸려 파악하기 어려운 상황에서,
콘솔에서의 child 추가없이 데이터를 저장하고 원격 파이어베이스 DB에 올리는 작업을 해보았다.


```
# 데이터베이스에 write 작업을 할 activity나 fragment의 onCreate

private DatabaseReference mDataReference;
# 루트 디렉토리 정도로 생각

@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mDataReference = FirebaseDatabase.getInstance().getReference();

    }
#파이어베이스 데이터베이스에서 인스턴스를 가져오고, 그것의 레퍼런스를 가져온다.



```

이제 직접적으로 어디에, 어떻게 써줄 것인지 정하도록 하자.
나는 Spec이라는 data model을 만들어, 'spec'이라는 child 하위에
난수를 발생시켜서 번호를 매겨 넣어주려고한다.

즉,
root
    - spec  
          - (임의의 난수)
            #(아래는 Spec모델의 json형식)
            - spec_name
            - period
            - job_name
            - difficulty
            - learning
          - (임의의 난수)
            - (또다른 spec모델)

식으로 들어갔으면 좋겠다.

```
# writeSpec함수

private void writeSpec(){

        String spec_title = spec_name.getText().toString();
        String job = job_desc.getText().toString();
        String difficulty_point = difficulty.getText().toString();
        String learning_point = learning.getText().toString();


        if( spec_title.length() == 0 || spec_title == null || spec_title.isEmpty()){
            Toast.makeText(this,"스펙 이름을 입력해주세요.",Toast.LENGTH_SHORT);
            return;
        }


        if( job.length() == 0 || job == null || job.isEmpty()){
            Toast.makeText(this,"업무 내용을 입력해주세요.",Toast.LENGTH_SHORT);
            return;
        }


        if( difficulty_point.length() == 0 || difficulty_point == null || difficulty_point.isEmpty()){
            Toast.makeText(this,"어려웠던 점을 입력해주세요.",Toast.LENGTH_SHORT);
            return;
        }



        if( learning_point.length() == 0 || learning_point == null || learning_point.isEmpty()){
            Toast.makeText(this,"배운 점을 입력해주세요.",Toast.LENGTH_SHORT);
            return;
        }

        Spec spec = new Spec(spec_title,"4개월",job,difficulty_point,learning_point);

    }
```

위의 코드에서, edittext객체에서 값을 가져와 새로운 Spec인스턴스를 만든다.
그리고
```
String uuid = UUID.randomUUID().toString();
```
라는 코드를 통해서, 랜덤한 난수인 UUID (추가 설명 요) 를 String값으로 만든다.

이 UUID를
다음과 같이 데이터베이스 레퍼런스의 child로 넣어주고 마지막 값을 setValue로 마무리한다.

```
mDataReference.child("spec").child(uuid).setValue(spec);

finish();
```
write가 완료되면 작성하는 액티비티는 사라져 방금 쓴 내용이 나와야하니
finish()를 추가해주었다.

이에 따라 기존에 방금 쓴 내용이 나오도록, 파이어베이스 리스너를
single event가 아닌 걸로 바꿔주어야함.
