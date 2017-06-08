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


## Collections 와 Iteration (반복) (11:32) 

```
val people = listOf(
  Person("Michael"),
  Person("Miguel", Language.SP),
  Person("Michelle", Language.FR)
)
```

표준 라이브러리 함수인 `listOf` 라는 메소드를 사용하면 `person` 의 리스트를 만들 수 있습니다. `for-in` 문법을 사용하면 person list 으로 반복문을 만들 수 있습니다. 

```
for( person in people) {
	person.greet()
}
```

각 반복 때마다 `person.greet()`  을 호출합니다. 아니면 더 나아가서, 확장 함수를 이 person collection에 대해서 호출하고 반복을 위해 람다를 넘겨줄 수 있겠네요. 위의 코드를 가장 단순화해봅시다. 명시적으로 나와있는 value 값을 제거하고, `it` 이라는  미리 지정된 값을 써서요. 

```
people.forEach { it.greet() }
```

아예  우리가 선언한 people이라는 value를 없앨 수도 있습니다.  아래 예제를 보면, 그런 식으로 코드를 짜서 조금 더 낫게 만들었습니다. 또한, 각 언어에 대해서 서브 class를 생성할 수 있습니다. 이를 위해 person class 를  `open`  으로 만듭니다. 이는 non-final이라는 뜻입니다. 코틀린에서는 class가 final로 되는게 기본 값이기때문입니다. 

```
enum class Language(val greeting: String) {
  EN("Hello"), ES("Hola"), FR("Bonjour")
}

open class Person(var name: String, var lang: Language = Language.EN) {
  fun greet() = println("${lang.greeting}, $name!")
}

class Hispanophone(name: String) : Person(name, Language.ES)
class Francophone(name: String) : Person(name, Language.FR)

fun main(args: Array<String>) {
  listOf(
    Person("Michael"),
    Hispanophone("Miguel"),
    Francophone("Michelle")
  ).forEach { it.greet() }
}

```


## 코틀린이 자바에 추가한 것 ( 13 : 11 ) 
코틀린이 자바에 추가한 것과, 그걸 사용해서 뭘 얻을 수 있는지에 대해서 알아봅시다. 

### Type Inference 자료형 추론 ( 13: 18) 
다른 프로그래밍 언어에서 type inference를 몇번 본 적 있을 겁니다. 자바에서는, 우리는 자료형을 정의하고, (변수) 이름을 정하고 , 그다음에 값을 정합니다. 코틀린에서는, 약간 반대입니다. 이름을 정의하고, 자료형을 정의하고, 값을 할당하죠. 하지만 대부분의 경우에는 자료형을 정의할 필요가 없습니다. 문자열 리터럴은 문자열이라는 자료형을 추론하기에 충분하죠. character나 integer, longs, floats, doubles, Booleans 에 있어서도 마찬가지 입니다. 

```
var string: String = ""
var string = ""
var char = ' '

var int = 1
var long = 0L
var float = 0F
var double = 0.0

var boolean = true

var foo = MyFooType()
```

Kotlin이 추론할 수 있는 한 어떤 자료형에도 적용되는 룰입니다. 대개 local 변수라면, value나 변수를 선언할 때  자료형을 적어주지 않아도 됩니다. 추론하기 어려운 경우라면, 완전한 문법으로 변수를 정의해야합니다. `var 변수명 : 자료형 = 값 ` 이런 식으로요. 

### Null Safety Null 값 보호 ( 14:22) 
Kotlin의 강력한 기능 중 하나는 null - safety 입니다. 예제를 볼까요. 

```
String a  = null;
System.out.println(a.length());
```

여기 자바문법으로, String이 있습니다. 이 string에 null을 할당했죠. 우리가 그 String의 길이를 출력하려고 한다면, 런타임에서 문제가 생기고, null point error exception 이 뜨게 됩니다. 우리가 null 값에 접근하려고 했기때문이죠. 
여기, 코틀린으로 쓰인 같은 코드가 있습니다.

`val a:String = null`

null String을 정의했습니다. 그러나 더 가기도 전에, 컴파일러에서 에러를 알려줍니다. 
문제는 null 타입이 아닌 자료형에 null 값을 할당했다는 것이죠. 자료형 구조에는  null 자료형과 non- null 자료형이 있습니다.  그리고 자료형 구조가 non-null 타입임을 알아보고 컴파일 시 non-nullable이 되는 것을 막은 거죠. 어떤 자료형을 nullable하게 만들려면,  **물음표**를 끝에 붙이고 null을 할당하면 됩니다. 

```
val a: String? = null
println(a.length())
```

자 이제 계속 해볼까요. 이제 자바로 쓴 예제와 같이, String의 길이를 출력해봅시다. 하지만 java와 같은 문제에 봉착했네요. 이 String은 null일 수 있습니다. 하지만 이 경우,  우리는 자료형 구조 덕분에 런타임이 아니라 컴파일 타임에 에러를 마주할 수 있습니다. 

컴파일러가 두번째 줄에서 멈추고, 고치기 위해서는 또 한번 물음표를 붙여야합니다.  이는 근본적으로, 어떤 값에 접근하기 전에 그게 null인지 알 수 있게 해줍니다. 

```
val a: String? = null
println(a?.length())
```

만약 값이 null이면 null을 반환합니다. null이 아니라면 실제 값을 반환합니다. 현재 코드에서는 값이 null 이기때문에, 출력문에 null 값이 전달되고,  null이 출력됩니다. 

### Ternary Null  삼항 null  (16: 19)

`int length = a !-null ? a.length() : -1 `

위와 같은 코드를 Java에서 보신 적 있을지도 모르겠네요. 삼항 연산자에서 값에 접근하려면, 값이 null이 아님을 검사하고 그다음 값을 사용해서 할당을 끝내야합니다. 만약 왼쪽에 있는 게 null check를 통과한다면 , 그때서야 접근할 수 있죠. 만약 오른쪽이 null이라면, 다른 걸 해야합니다. Kotlin에서는 정확히 똑같은 걸 할 수 있습니다.

`var length = if(a!=null) a.length() else -1 `

만약 a가 null이 아니라면, 접근할 수 있고, 아니면 default값을 출력해주면 됩니다. 
하지만, 위의 코드를 더 짧게 줄일수있습니다. `elvis operator`라는 걸 사용해서요.

`var length = a?.length() ? : -1`

물음표를 통해서 inline에서 null check를 할 수 있습니다. 위에서 말한대로, 이건 null인 경우 null을 출력합니다. 만약 왼쪽에서  `elvis` 로 검사를 했는데 null이라면, 오른쪽을 사용합니다. 그런 경우가 아니라면, 값 측정을 계속합니다. 

### Smart Casts (17:30) 
Kotlin에는 smart casting이라는 기능이 있습니다. 로컬 object가 자료형 검사를 통과하고 나면, casting을 명시적으로 해주지 않고도 그 object(변수)의 자료형으로  접근할 수 있습니다. 예제를 봅시다. 

```
if (x is String) {
  print(x.length())
}
```

x가 String인지 확인하고, 만약 그렇다면 길이를 출력하는 함수입니다. 이를 위해 `is` 라는 키워드를 사용했습니다. 자바의 `instanceOf` 와 비슷하구요, 검사를 통과하면 그 뒤에는 어디서든 string처럼 쓸 수 있습니다. 
```
if (x is String) {
  print(x.length())
}

print(x.size())
```

거꾸로도 작동합니다. 만약 string이 아닌지 검사했는데, String이 아니라면, 함수 밖으로 반환합니다. 하지만 만약 String이라면, 그 이후 어디든지 그걸 String 취급해주고 캐스팅을 할 필요가 없습니다. inline 로직에서도 적용됩니다. 

```
if(x !is String || x.size() == 0){
	return 
}
```

여기서 우리는 x가 String이 아닌지 검사하고 `or` 연산자를 사용했습니다. 이게 String이기 때문에, String으로 접근하고 코틀린에 의해서 cast될수 있었죠. 
`when` 구문에서도 마찬가지 입니다. `when` 구문은 향상된 `switch` 구문 같은 겁니다 .

```
when(x) {
	is Int -> print (x+1)
	is String -> print(x.size() + 1)
	is Array<Int> -> print (x.sum())
}
```

우리는 자료형 검사, 자동 캐스트, 자동 캐스트에 대한 자료형 검사, 그리고 스마트 캐스트를 마쳤습니다. 

## String Templates 문자열 템플릿 (19:07)
많은 프로그래밍 언어가 문자열 템플릿이나 문자열 보간법이 있습니다. Java를 사용하면 다음과 같이 될겁니다. 
```
val apples = 4 
println("I have " + apples + " apples.")
```

이 `apples` 라는 값을 그냥 문자열 중간에 끼워 붙여넣을 수 있습니다. 좀더 Kotlin 스럽게 한다면, 문자열 보간법을 할 땐 그냥 **$** 문자를 붙이고 String 중간에 넣습니다. 
```
val apples = 4
println("I have $apples apples.")
``` 

수식을 넣을 수도 있죠.
```
val apples = 4
val bananas = 3

println("I have $apples apples and " + (apples + bananas) + " fruits.") // Java-esque
println("I have $apples apples and ${apples+bananas} fruits.") // Kotlin
```

자바에서는 사과와 바나나 갯수를 더하고 string에 붙이는 일을 할 수 있지만,  코틀린에서는 그걸 String 한 가운데로 가져와 보간법을 적용했습니다. 우리는 중괄호로 감싸고 $ 를  앞에 붙이는 것만 하면 됩니다!

## Range Expressions 범위 표현 ( 20:00)

이걸 다른 프로그래밍 언어에서도 보신적 있으실 거에요.  코틀린의 특징 중 많은 부분이 다른 언어에서 왔다는 걸 아시게 될겁니다. 여기 수식이 하나 있습니다. 만약 `i` 가 1 이상이고 10 이하이면 출력해줄겁니다. i가 1과 10 사이에 있는지 검사해보겠습니다. 

```
if( 1<= i && i<=10){
	println(i)
}
```

위 코드 대신에 미리 만들어져있는, `intRange` 라는 걸 써보겠습니다. 1부터 10까지의 범위를 넣고, i가 그 범위 내에 있는지 확인하기 위해 `contains`  함수를 씁니다.  범위 내 있다면, i를 출력합니다. 

```
if (IntRange(1, 10).contains(i)) {
  println(i)
}
```

확장 함수들을 쓰면 다르게 쓸수도 있어요. 예를 들면 `1.rangeTo`  등을 써서. 그리고 `contains` 를 써서요. 
하지만 우리는 이 연산자를 쓰는 쪽을 선호합니다. 

`if (i in 1..10) { .. }`

이 연산자는 `rangeTo` 를 다르게 쓴 것입니다. 널 타입 시스템을 생각하면, 이에 대해서 알 수 있죠. Kotlin 에는 원시타입이라는 게 없습니다. `int` 는 integer이거나 원시 int고, 그게 null 인지 아닌지에 따라 타입시스템이 원시 int를 쓸지 integer를 쓸지 알게 됩니다.  당신의 경우에 최적화해서요.  당신이 맞는 타입을 쓰는 한, 타입 시스템은 자바에 존재하는 어떤 원시 타입이든 자동적으로 만들어줍니다. 

또한, 범위를 반복할 수도 있어요. 범위는 반복할 수 있으니까요. `step` 을 사용하면됩니다. 

`for (i in 1..4 step 2) { ... }`

반복을 거꾸로 할 수도 있고,  범위의 구조를 거꾸로 하고 반복을 할 수도 있죠. 

`for (i in 4 downTo 1 step 2) { ... }`

기본적으로, 많은 함수들을 조합해서 원하는 수식을 만들어 낼 수 있습니다.
어떤 자료 형이라도 반복할 수 있고 , String과 새로 만든 자료형 을 포함해 어떤 자료형이라도 범위를 만들수 있구요. 반복을 할 수 있는 로직이 있고 적용가능하기만 하다면요. step은 내부적으로 숫자로 정의되어있습니다. 

## Higher-Order Functions ( 22: 55) 
Java 8 이 그러하듯 여러 언어가 이런 함수를 지원합니다. 하지만 우리는 java 8을 쓸 수 없죠. 만약 6이나 7을 쓰고 있다면, filter function을 이렇게 적용해야할 거에요. 

```
public interface Function<T, R> {
  R call(T t);
}

public static <T> List<T> filter(Collection<T> items, Function<T, Boolean> f) {
  final List<T> filtered = new ArrayList<T>();
  for (T item : items) if (f.call(item)) filtered.add(item);
  return filtered;
}

filter(numbers, new Function<Integer, Boolean>() {
  @Override
  public Boolean call(Integer value) {
    return value % 2 == 0;
  }
});
```

먼저, 자료형 `T` 와 반환형  `R` 을 인자로 갖는 function 인터페이스를 만듭니다. 
우리의 method는 제공된 function을 사용해서 collection을 계속 반복합니다. 
그리고 새로운 arraylist를 만들죠. 