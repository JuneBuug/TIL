# GDG Seoul Google I/O extended 2017 

## The age of Open Development 
키노트 넘넘 이쁘다 

### Open 
* **open source** 
* 구글은 git / gc / python / linux 등에 관심 오래 가져옴
* 작년 기준 28만개 커밋 / 1만5천개 이상의 프로젝트들 / 2500 의 이벤트 
* tensorflow 다야한 기능들이 커뮤니티에서 같이 개발되고있음
* 텐서플로우도 오픈소스 머신러닝 라이브러리 중에서는 깃헙에서 가장 많이 참여함
* **open access** 의 관점 
* youtube 8M
* Open Images Dataset
* +음성
* 이걸 가지고 tnesorflow 사용해서 쓰면 됨 ㅇㅇ 
* **open community**
* GDG가 전세계적으로 500개 이상있음

계속해서 커뮤니티에 참여를했음년 좋겟다 

KLDP(1996~) 깃헙같은 개념 / 스택오버플로우 개념도 있었음 
THE NORM for sw dev 

## Architecture Component by 김상일

구글 I/O 2017에서 처음 공개됨 
안드로이드 아키텍쳐 가이드를 제시하는 세션이었음
총 4개의 컴포넌트 

* Lifecycle 다루는 방법
* LiveDate
* ..
* .

```
supportlib로 들어갈 예정이라고함 
```

### Lifecycle 다루는 방법

```
기존에는 onStart등 생명주기에 관한 함수들을 override해줬어야함

#LifeCylce
# .. Owner
# .. observer
```

* 액티비티 코드에서 lifecycleActivity상속
* getLifeCycle()함수를 통해서 리스너에 넘겨줌
* OnLifeCycleEvent라는 어노테이션이 따로 생김
* 옵저버를 달면 라이프사이클 상황이 발생할때마다 어노테이션 달린게 실행됨
* listener 할 때 addObserver붙이고 clean할때 remove해줘야함 
* Lifecycle…owner를 implement하면 커스텀에서도 쓸 수 있음

기존에는 event를 따로 추적해서 만들어줬어야하는데 
lifecycle component를 사용하면 바로바로 알 수 있음 


```
Utils.checkUserStatus( state -> {
	if(state.equals("ok"){
		testListener.start();
	}
}

#만약 이게 너무 길면 
.. memory leak => 배터리소모 
```


바뀐 코드

```
Utils.checkUserStatus( state -> {
	if(state.equals("ok") && getLifeCycle()
							  .getCurrentState()
								.isAtLeast(Lifecycle.onSTART) ? 
{
		testListener.start();
	}
}
 
#필요할때만 코드를 타게 함 
```


### LiveData

* Observable data holder
* lifecycle aware
* .. 

```
LiveData<String> stateDate = new MutableLiveData<>();
#LD는 인스턴스임
#setValue로 값지정(UiThread에서만 사용. 아닐땐 postvalue사용

#LD를 상속하면 onActive와 onInActive를 구현해야함.
전자는 active한 observer가 생길 때 (라이프사이클이 started나 resumed일때)
후자는 active한 observer가 사라질때 
```


### ViewModel 

data를 가져오는 코드 
화면이 회전되서 액티비티 재생성시 
fetchData를 두번하는 경우 ! 
그러면 데이터를 두번 불러오게되면서 불필요한 리소스를 소모하는 무넺가 있음

그러니 액티비티 회수 되어서 재생성되어도 데이터 유지할 필요가 있ㅇ므 
=> VM쓰세욤

```
public class UserViewModel extends ViewModel

#ViewModel이나 AndroidViewModel(어플리케이션인자를 받을 수 있음) 상속
```


* 뷰를 참조하면 안됨
* ActivityContext참조하면 안됨
* Resource들도 참조하면 안됨 

```
# 가져오는 법 
UserViewmodel viewModel = 
ViewModelProviders.of(this).get(UserViewModel.class);

# 이전에 만들어진 적이 있다면 내부 viewmodel 스토어에서 가져오고 아니면 새로 만든다.
```


### Room 

sqliteORM임
sqlite를 ORM형태로 바꿔줌
* Entity
table개념. 
```
@Entity
public class User{
@PrimaryKey(autoGenerate=true)

@ColumnInfo(name="created_time"); 이름을 바꿀수있음

@Ignore (객체를 쓰다보면 DB에 저장할 필요가 없는 필드) 
Bitmap 처럼! 
}
```

* DAO
쿼리문을 작성할 수 있는 class

```
@Dao 

public interface UserDao{

@Query("SELECT * from user where id in (userIds)")
List<User>  ... 
}
```

쿼리의 결과를 여러가지로 받을 수 있게됨
리턴타입만 명시하면 사용할 수 있음 

* Database 
오픈헬퍼라고 생각하면됨
만들어주는 클래스 
필요한 테이블만 선택할수있음
DB파일에 class 접근자만 선언하면됨 

```
@Database(entities = {User.class, Book.class},version =1 ) 
public abstract class AppDatabase .. 
```

…
entity type converter 

* Entity - Relation 
```
@Entity
엮일 부모키를 정해두면 됨 

```

room으로 생성된 코드는 inpl이라는 postpix가 붙어서 생성됨 
room에서 잘못된 테이블 참조같은건 compile time에서 잡아줌 
pk가 auto-generation인데 string인 경우 또한 compile time에서 잡아줌 


### VCNC에서의 적용

`RxJava에서 옮겨올 필요는 없음 , 새로 만들거나 Rx의 러닝커브를 하기 어려운 사람 `

Room / greenDAO / Realm 

특히 쿼리 사용하는 경우 
room은 low query
greenDAO 와 realm는 query
Realm 은 필드명 직접작성 

Room에서는 relation할 때 두 객체를 불러올수있는 있는데 
wrapping class가 있어야함 

greenDAO
다른 DB에 대한 리스트를 가짐. @ToMany를 사용하면 relation을 정의할수있음

Realm
relation 처리시 가장 용이 
필드 객체로 바로 접근
group을 한번에 insert지원



