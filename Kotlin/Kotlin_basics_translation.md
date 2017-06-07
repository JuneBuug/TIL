원 출처 : https://news.realm.io/news/droidcon-michael-pardo-kotlin/

위 영상 / 스크립트는 Droidcon NYC에서 Michael Pardo가 Kotlin 코틀린을 설명하는 영상입니다. 



코틀린은 정적체계의 JVM 언어입니다. 

JetBrains에서 나왔구요.

람다, 클래스 확장, null 처리 등의 특징이 있고, 

간결하고 표현력있고, 정보교환이 매우 잘되는 걸 목적으로 합니다. 

안드로이드 툴들 중 강력한 물건이 될 겁니다! 



## Kotlin 코틀린 ( 0: 00 ) 

﻿안녕하세요, Michael Pardo 입니다. 오늘은 코틀린, 그리고 코틀린이 어떻게 더 행복하고 생산적인 안드로이드 개발자가 되게 해주는지에 대해 말해볼까해요.

코틀린은 JVM을 타겟으로 한 정적체계의 언어입니다.  Android Studio와 IntelliJ를 만들었던 JetBrains이 만들고 지원했습니다.



코틀린이 목적으로 하는 바가 몇가지 있습니다. (~세들어산다는 표현을 썼음) 

1. 간결한 Concise, 어떤 걸 만들기 위해 드는 코드의 양을 줄이는 것. 

2. 가독성있는 Expressive,  코드를 더 읽을만 하게,이해할 수 있도록 하는 것. 

3. 안전한 Safe, 에러를 만들 가능성을 없애는 것. 

4. 다용도의 Versatile, JVM과 javascript를 타겟으로 하여 여러가지 구동환경(장소)에도 돌아가게 하는 것.

5. 상호정보교환의 Interoperable, 코틀린에서 자바를 호출할 수 있고, 자바에서 코틀린 코드를 호출할 수 있고, 100% 호환이 되는 걸 목적으로 합니다. 



하지만 왜 JAVA 8을 기다리지 않는 걸까요? ( 기다리지 않고 코틀린을 쓰자고 하는 걸까요? ) 



## 자바와 안드로이드 : 그 역사  ( 1: 11 ) 

﻿﻿﻿자바와 안드로이드의 관계와 역사를 살펴봅시다. 2006년에, 자바 6이 나왔습니다.  몇년 뒤에, 안드로이드 1 이 알파버전으로 나왔고, (지금으로부터) 4년 전에 자바 7이 나왔죠. ﻿﻿﻿﻿ 안드로이드가 그로부터 2년 후에 자바 7를 지원하기 시작했고, 작년에 자바 8이 나왔습니다. 

우리가 자바8을 실질적으로 쓰게 될 때가 언제라고 생각하세요? 꽤 걸리겠죠. 몇년 간 자바 8 에 대한 지원을 받을 수 있다고 해도 모든 사람이 자바 8를 채택하는 데는 더 많은 시간이 걸릴 겁니다. 안드로이드의 지원상황(adoption)은 현재 매우 나뉘어있어서,  자바 7은 API 19 이상만 지원합니다. 자바 7 앱을 사용할 수 있는 사용자는 겨우 반을 넘기는 수준이고요. 이건 좋지않죠. 만약 우리가 모든 기기에 100% 호환되는  자바 8을 지금 당장  쓸 수 있다고 해도, 언어 그 자체가 문제가 좀 있습니다. 문제를 한번 짚어볼게요. 



## 자바의 문제점 ( 2: 22 ) 


* Null 참조 Null references , 만들 땐 작았지만 십억달러가 넘는 실수가 되어버린 부분.  코드를 방어적으로 쓸 수 있지만,  Null Pointer Exception 문제는 모든 사람의 코드에 스며들 수 있습니다. 그냥 자바의 자료체계가 안전하지않기 때문입니다. 

* 원천 타입 문제 Raw types , 우리는 이전 기종들과 호환하기 위해서 (backwards compatible ) 계속해서 raw types에 시달려왔습니다.  그리고 어떻게  raw type을 쓰지말아야하는지 알아야합니다. 하지만 원천 타입은 언어 자체에 포함되어있어 안전하지 않고 잘못 이끄는 경향이 있습니다.
**역주 : [원천타입을 쓰지 말아야하는 이유﻿﻿]( http://ojava.tistory.com/27)**


* 함께 변하는 배열들 Covariant Arrays , 자바에서는 String 배열과 Object배열을만들고 Object 배열에 String 배열을 할당할 수 있습니다.  컴파일은 잘 되겠지만, 실제 런타입에서 그 String 배열에 숫자를 할당하려고 하면 exception이 발생하게 됩니다. 

* 자바 8 은 고위 언어이지만, SAM types이 적용되어있습니다. SAM은 Single abstract method 의 약자입니다. 모든 함수의 타입은 그에 관련된 인터페이스가 있어야합니다.  만약 존재하지 않거나 함수 타입이 없는 람다 함수를 만들고 싶다면 함수의 타입을 먼저 인터페이스로 만들어줘야하는 점을 말합니다
 

이제 코틀린이 어떻게 이런 문제를 해결하는 지 봅시다. 



## 코틀린이 구해주리라!  ( 4: 24) 



우리가 방금 본 이슈들에 대해서, 코틀린은 그런 특징들을 없애버렸습니다. 그리고 이런  좋은 것들을 추가했습니다. 

* Lambdas 
* Data classes 
* Function literals & inline functions 
* Extension functions 
* Null safety 
* Smart casts 
* String templates
* Properties
* Primary constructors
* Class delegation
* Type inference
* Singletons
* Declaration-site variance
* Range expressions


이 글에서는 이 중 대부분에 대해 다뤄볼겁니다. 코틀린은  제약이 없어서, JVM 생태계와 함께 계속 나아가고 있습니다. 코틀린은 바로 JVM 바이트코드로 컴파일되고, 그 말은 오버헤드가 없다는 뜻이죠. JVM에겐 코틀린은 다른 JVM 언어와 똑같이 보입니다. 사실, IntelliJ나 안드로이드 스튜디오에서 지원하는 코틀린 플러그인을 사용하면, 헤더에 있는 각 메소드에 대해 생성된 JVM 바이트코드를 보여주는 바이트코드 뷰어가 있습니다. 


## 안녕, 코틀린 ( 5: 19 ) 

기본 문법을 좀 보죠. 여기에 Hello World 예제가 있네요. 

```
fun main(args: Array<String>): Unit {
  println("Hello, World!")
}
```

이건 그냥 함수고 출력 구문입니다. 패키지 선언이 아니고요. 임포트도 필요없습니다. 이게 코틀린 Hello World를 찍기 위해서 필요한 전부입니다. 함수는  `fun`  키워드만 있으면 됩니다. 그 뒤에 함수이름이 붙고,  괄호에는 자바처럼 필요한 인자들이 들어갑니다. 

하지만 코틀린에서는,  인자 이름을 먼저 써주고, `:` 으로 구분한 뒤 , 그 다음에 자료형을 써줍니다.  반환형은 마지막에 옵니다. (자바가 처음에 써주는 거랑은 다르게요. ) 함수가 딱히 반환할 자료형이 없으면, `Unit` 을 자료형으로 써줍니다. 그러니 `Unit` 을 쓰면 자연스럽게 반환형을 생략한다고 추론해볼 수 있고요. 그 다음에 우리는 Hello World를 출력합니다. 이는 자바의 `System.out.println` 을 호출하는, 코틀린 표준 라이브러리의 표준 함수입니다. 

```
fun main(args: Array<String>) {
	println("Hello, World!")
}
```

그 다음에는 “World”라는 String 부분을 떼어서 변수로 만들어볼까요. `var`  키워드 다음에 변수 이름을 붙이면 됩니다. 그리고 코틀린 역시 String Interpolation(보간법) 을 지원하기 때문에, 따로 붙이는 과정을 안거치고도 그 변수를 바로 String안에 넣어도 됩니다.  변수 이름앞에 달러 사인을 붙여서 넣기만 하면 됩니다. 

```
fun main(args: Array<String>){
 var name =" World"
 println("Hello, $name!")
}
```

그 다음,  우리가 넘겨준 인자에 String이 있는지 없는 지 검사해보도록 합시다.  만약 이 String array가 비지 않았다면, 첫번째 String을 가져와서 name이라는 변수에 할당해줄거에요.  이 코드에서는 자바의 예약어인 final과 비슷한 `val` 이라는 키워드도 있습니다. 이 친구는 상수를 만들어줍니다. 

```
fun main(args : Arrag<String>){
 val name = "World"
 if(args.isNotEmpty()){
	 name = args[0]
	}
	
 println("Hello, $name!")
}
``` 

그리고 우리는  위의 코드를 컴파일하는데 문제가 있다는 걸 알게됩니다. 왜냐하면 이 상수에는 값을 다시 할당할 수 없기때문이죠. 문제를 해결하는 방법 중 하나는 inline한 if - else 코드를 쓰는 겁니다. 코틀린에서의 많은 코드는 값을 반환할 수 있습니다. 여기서는 if 구문을 실행하고 만약 비지 않았다면 arg[0]을 반환하도록 했네요. 비었다면 , “World”를 반환하고, 이 반환된 값 ( arg[0] 나 “World” 겠죠 ) 을 name이라는 변수에 바로 때려넣습니다.  이를 **조건 할당 블럭**이라고 합니다. 

```
fun main(args: Array<String>) {
  val name = if (args.isNotEmpty()) {
    args[0]
  } else {
    "World"
  }
  println("Hello, $name!")
}
```

우리는 이걸 한 줄로 줄여 삼항 연산자처럼 보이게도 할 수 있습니다. 괄호를 없애서 깔끔하게, 자바의 삼항 연산자 처럼 만들어봅시다. 
`val name = if (args.isNotEmpty()) args[0] else "World"`

## Class 문법 ( 5: 19) 
클래스를 살펴볼까요. 자바에서처럼 `class` 라는 키워드로 class를 정의 할 수 있습니다. 그 뒤에는 class name이 붙구요. Kotlin은 주 생성자가 있고,  생성자를 클래스 헤더에 넣을 수 있습니다.  생성자에는 인자들을 정의할 수 있고요. 생성자들의 특성을 `var` 나 `val` 로 정의해서 선언할 수도 있습니다. 

```
class Person(var name: String) 
```

전의 예제를 사용해봅시다. 우리의 이름 할당 로직을 가져와서 , Person class의 인스턴스로 바꿔볼 겁니다. 코틀린에서 인스턴스를 생성할 때는 `new` 키워드를 사용하지 않습니다. 그냥 자료형을 참조해서 새로운 인스턴스를 만듭니다.

```
class Person(var name: String)

fun main(args : Array<String>){
 val person = Person("JuneKim")
 print("Hello, $name!")
}
```

이제는 우리의  String interpolation이 틀렸네요. 여전히 name을 참조하고 있으니까요. 이걸 고치려면, String interpolated experssion을 써야합니다. 바로 달러 표시와 중괄호로요. 
```
class Person(var name: String)

fun main(args : Array<String>){
 val person = Person("JuneKim")
 print("Hello, ${person.name}!")
}
```

아래는 `enum` 클래스입니다. enum은 자바의 enum과 대부분 같아서 비슷하게 보입니다. 

```
enum class Language(val greeting : String){
 EN("Hello") , ES("Hola"), FR("Bonjour")
}
```

역주 : [개발이 하고 싶어요 :: JAVA 열거타입 enum](http://hyeonstorage.tistory.com/174) 참고 

우리 Person class에 언어의 특성을 추가해 봅시다. 

`class Person(var name:String, var lang: Language =  Language.EN)`

코틀린에서는 기본 인자들을 가질 수 있습니다. 여기서 인자의 default 값은 `Language.EN` 이네요. 그리고 우리는 그 값(디폴트값) 을 인스턴스 생성 때 생략할 수 있스빈다. 계속 쓰고 있는 예제를 더 객체 지향적으로 만들고, person 클래스에 greet라는 함수를 만들고, language (클래스의) greeting 을 가져와서 name을 붙여봅시다. 

```
enum class Language(val greeting: String) {
  EN("Hello"), ES("Hola"), FR("Bonjour")
}

class Person(var name: String, var lang: Language = Language.EN) {
  fun greet() = println("${lang.greeting}, $name!")
}

fun main(args: Array<String>) {
  val person = Person("JuneKim")
  person.greet()
}
```

이제  (이전 예제에서) main 함수에서 한 줄을 지우고, person.greet()만 적어도 같은 결과가 나옵니다.