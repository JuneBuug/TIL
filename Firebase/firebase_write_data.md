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
