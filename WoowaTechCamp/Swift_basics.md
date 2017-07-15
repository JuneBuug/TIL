# Swift 기초!

프로그래밍 언어도 생각하는 방식의 기준이 되는 언어가 있다!
swift를 배우기 위해서는 swift-like로 생각하는 방식이 필요함.
swift는 등장한지 5년 밖에 안된 언어인 만큼,
패러다임이 다 섞여있어서, 객체지향이나 기타 특성을 다 흡수했음!
그러므로 오히려 swift만의 철학이 없다고도 말할 수 있음.


## Swift 교육 자료들

* The Swift Programming Language (Swift 4 Edition)
: swift는 언어 스펙이 매년 달라지기때문에 최근 스펙을 보려면 애플의 e-book을 보는 게 좋음!
3개월의 한번은 업데이트가 됨.

* App Development with Swift
: 교재처럼 설명 / 요약이 되어있음

* [raywnderlich](https://www.raywenderlich.com/119881/enums-structs-and-classes-in-swift) 예제를 제일 잘만들고 설명도 잘 되어 있음



## iOS 앱을 준비하기위한 개발환경

* Xcode : 개발 환경
* Swift : 언어
* Cocoa Touch : 앱을 만들기 위한 프레임워크.

## 스위프트 개발 환경

* REPL : 레플, 커맨드 라인 환경이 준비 되어있음. java도 9버전 부터는 REPL이 들어감.
단순히 shell에서 swift 라고 치면 간단한 swift문법을 실행해볼 수 있음. ctrl + D로 나가기.
* Xcode : 코드편집기 / 디버거 / 컴파일러
* Playground : 디버거가 없음. REPL을 비주얼 프로그래밍 가능한 형태로 바꾼것!
참고로 playgrounds는 아이패드용 playground 앱을 의미함.
* [IBM Swift Sandbox](https://swift.sandbox.bluemix.net/#/repl) : 웹에서 실행해 볼 수 있고, 다른 사람 컴퓨터에서 해봐야할 때 사용. 스위프트 여러 런타임을 사용할 수 있어서 테스트 할 때 좋음.


### 간접 참조 (Indirection)
값 자체보다 컨테이너, 연결, 별명 등을 사용해서 우회해서 참조하도록 하는 방식.
포인터, 함수, 변수, 객체, 데이터 구조 등도 크게는 그런 범주에 든다.

David Wheeler 가, 자주 부르는 코드를 다로 구분해놓고 간접 참조로 재활용할 수 있도록함.
subroutine이라는 함수의 개념을 만듦.


## Swift 문법

### 함수

```
func 함수이름 (매개변수명 : 변수타입) -> 리턴타입 {
  // 함수내용
}

# 예제

func checkPassWord(password : String) -> Bool{
  // 함수 내용
}
```

* **다른 언어와 달리** 함수에 들어온 인수는 상수처럼 씀!
* scope 내에 정의된 건 scope내에서만 쓸 수 있음.

함수 호출(사용)은 이렇게 한다!

```
func add(number1 : Int, number2 : Int) -> Int {
  let sum = number1+ number2
  return sum
}

var result1 = add(number1: 123, number:234)
# 앞에 있는 매개변수를 꼭 써줘야함.
# : (colon) 앞의 단어(keyword)는 값을 설명하는 용도로 많이 씀.

func add(_ number1: Int, num2 number2: Int) -> Int {
  let sum = number1 + number2
  return sum
}

# 매개변수가 두개 가능. 앞 매개변수 (여기서는 num2) 는 함수 호출시에 부르는 용도이고, 뒤에서는 함수 내에서 호출하는 용도.
# 호출시에 매개변수를 써주지 않으려면, 함수를 작성할 때 앞에 _(underbar)를 쓰면 된다.
# objective-c 와 언어적 호환성을 유지하기 위해서 이렇게 씀

```

### 자주 쓰는 표준 함수들

```
abs(변수)
# 변수에 있는 값의 절대값을 반환한다.

assert()
# debug모드에서만 사용. 조건이 충족됐을때, 개발자에게 바로 해당 이슈를 보고해주는 역할을 한다.
[참고](http://blog.krzyzanowskim.com/2015/03/09/swift-asserts-the-missing-manual/)

stride(from:to:by:) # to 뒤의 경계값 포함 X
stride(from:through:by:) # through뒤의 경계값포함

# 예제
for a in stride(from:10.0, to:20.0, by:0.2) { print(a) }
for a in stride(from:5.0, through:0.0, by:-0.5) { print(a) }

zip
# 두 array를 같이 쓸 수 있게 해주는 함수.

# 예제

let words = ["one", "two", "three", "four"]
let numbers = 1...4

for (word, number) in zip(words, numbers) {
    print("\(word): \(number)")
}
// Prints "one: 1"
// Prints "two: 2
// Prints "three: 3"
// Prints "four: 4"


print(_:separator:terminator:)
# 예제
print(12,99,3,14,separator: ",", terminator: "----")

```

### 변수와 상수
변수 표현은 `var <변수이름> = <값>`
상수 표현은 `let <상수이름 = <값>`
* 변수와 상수이름은 유니코드, 알파벳, _ ,$ 만 가능.
* 소문자로 시작을 권장하고, CamelCase를 지켜주자.

### 복합 데이터 구조

1. tuples
**여러값을 한번에**
여러 개의 변수를 한번에 넘길 때, 변수를 묶어서 넘길 수 있음.
```
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")

 let (statusCode, statusMessage) = http404Error
 print("The status code is \(statusCode)")
 // Prints "The status code is 404"

# \(변수명)하면 변수 값으로 대체됨.

 print("The status message is \(statusMessage)")
 // Prints "The status message is Not Found"
 print("The status code is \(http404Error.0)")
 // Prints "The status code is 404"
 print("The status message is \(http404Error.1)")
 // Prints "The status message is Not Found"

 let http200Status = (statusCode: 200, description: "OK")
 # 명시적으로 넣어 줄 수 있음.

 typealias PersonTuple = (name : String, age : Int)
 let eric : PersonTuple = (“eric", 150)
 # typealias를 써서 type으로 선언해서 쓸 수도 있음.

```

2. enum
**연관된 항목들을 묶어주자!**
정의한 항목 값 중에 선택하는 타입
제한된 선택지를 주고 싶을 때!

```
enum CompassPoint{
  case north
  case south
  case east
  case west
}

# 보통형은 이렇게 써주고

# 연관값은 이렇게 넣어준다.

enum Barcode{
    case upc(Int, Int,Int,Int)
    case qrCode(String)
}

# upc와 qrCode가 받아야할 인자 값을 정해준다.

var productBarcode : Barcode = .upc(8, 85909, 51226, 3)
# 형이 Barcode 인 productBarcode 를 만들고 그 안의 upc를 정의해준다.
//productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
# enum으로 정의한 것들의 값을 뽑아주고 싶으면 switch-case문을 써서 뽑는다.

```

3. 배열 array
**동일한 데이터 타입, 순서 O**
```
var ageArray = [10,20,30]
print (ageArray[0])
# index로 접근 가능함

ageArray.append(40)
# append로 추가 가능함
# zero-base
```

4. 사전 dictionary
**동일 데이터타입을 키값으로 담아놓기**

```
var gradeDic = ["a": 90, "b": 80]
print(gradeDic["a"] ?? 0)
# ??는 , 없는 값을 참조 할 수 있기때문에 에러를 보완하는 표현임.
```

5. 집합 Set
**동일 데이터타입, 순서 X**
```
var aSet : Set = [11,12,13]
aSet.contains(12)
```

### 옵셔널 Optional
모든 타입에 optional 을 붙일 수 있음
값이 있느냐 없느냐!를 명시 할 수 있는 개념

```
Int?
# Integer타입의 optional. boxing했다는 표현도 씀
# 정작 Int가 안들어있는 상태도 쓸 수 있다.
```

#### 예제
```
let possibleNum = "123"
let convertedNumber = Int(possibleNum)
# 강제로 바꾸려구함! 값의 내용에 따라서 값이 달라지는 애들은 Int의 optional이 되어버림.

if convertedNumber != nil {
   print("\(convertedNumber!)")
   # !를 붙이려면 nil이 아닐때만 써야함. 값이 있는지 아닌지 명확하게 알 수 있을 때만 써야함.
}


# Optional Binding 값이 있으면 풀어서 쓸 수 있게 해주는 기능

if let actualNum = Int(possibleNum) {
   print("\(actualNum)"")
}else{
  print("integer로 못바꿈")
}

# 즉, if let으로 시작하면, optional 변수가 unbox된 상태로 들어간 거임. 이 형태를 많이 권장.

```


### 범위 연산자

```
A...B
# (A~B(포함))

A..<B
# A~B(제외))
```

### switch-case는 복잡한 조건 비교 가능!
예제
```
let somePoint = (1, 1)
 switch somePoint {
 case (0, 0):
     print("(0, 0) is at the origin")
 case (_, 0):
     print("(\(somePoint.0), 0) is on the x-axis")
 case (0, _):
     print("(0, \(somePoint.1)) is on the y-axis")
 case (-2...2, -2...2):
     print("(\(somePoint.0), \(somePoint.1)) is inside the box")
 default:
     print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
 }
 // Prints "(1, 1) is inside the box"

 # 언더바를 쓰면 만족하든 안하든 상관없음! 이라는 뜻.
 # break가 기본이라, 위에서부터 걸러지기 때문에, 위에서는 딱 들어맞는 작은 조건들을 하고,
 아래에는 제일 넓은 case를 비교하면 됨
```

### for문

```
for index in 1...5{
   # 1부터 5까지
}

for index in stride(from: 5, through: 1, by: -1){
  # 5부터 1까지 -1씩 하면서 반복
}

for _ in 1...power{
  # 변수명을 안쓸거라면 _를 써도 됨
}

let names=["junekim","Taeyang","Tomlee"]
for name in names{
   print("Hello, master \(name)!")
}
```

### Error 처리
원래는 do 예약어가 repeat에 붙어있었는데 바뀌었음.

1. error가 있을 함수에는 `throws` 를 붙여준다.
2. do { try } catch 를 한다.


### 클로저 Closure

모든 함수는 클로저. 클로저는 함수이거나 아닐 수도있다.
함수보다 큰 개념임. 대신 닫히는 성질을 갖고있음.

```
let closure1 : (Int) -> Int = { n in return n * n}
# 무조건  in 앞이 매개변수, 뒤가 구현부.
let closure2 = { (n:Int) -> Int in return n * n}

# 클로저는 람다계산식(프로그래밍 구현 방식 중 하나) 구현체
# 이름 없는 함수로 작성가능
# 선언된 범위 변수를 캡처해서 저장하고 닫힘
# 하지만 스위프트 클로저는 캡처해서 닫지않고 참조를 함.
```

### 클로저 표현식

```
let numberArray = [2, 8, 1, 3, 5]
let resultArray = numberArray.map(squared) // 결과 값은 [4, 64, 1, 9, 25]
let result1 = numberArray.map({ (n : Int) -> Int in return n*n })
let result2 = numberArray.map({ (n : Int) -> Int in n*n })
let result3 = numberArray.map({ n in return n*n })
let result4 = numberArray.map({ n in n*n })
let result5 = numberArray.map({ $0 * $0 })
let result6 = numberArray.map() { $0 * $0 }
let result7 = numberArray.map { $0 * $0 }
```
* 클로저는 함수로 선언하지않아도되고,인자값 대신에 그자리에 바로 선언할수있다.
* 한 줄 표현 클로저에서는 return 구문을 생략해도 된다.
* 클로저에서 사용하는 변수 타입은 생략할 수 있고, 배열에 있는 변수 타입으로 추정이 가능하다. in 지시어를 사용해서 변수를 명시할 수 있다.
* 위의 경우와 마찬가지로 return 구문은 생략이 가능하다.
* 클로저 내부에서는 축약변수를 인자값순서에 따라서 $0부터사용할수있다.
* 함수 인자 중에서 마지막 인자 값이 클로저인 경우는 후행(trailing) 클로저로 판단하고 함수 괄호 다음에 빼서 선언할 수 있다.
* 함수에 대한 인자값이 없는경우 괄호는생략할수있다.

### 고차함수 High - order function

함수 혹은 클로저를 인자, 리턴값으로 사용하는 함수

```
let names = ["Apple","JuneKim", "David", "Baemin"]
let reversedNames = names.sorted(by : {
  (s1 : String, s2: String) -> Bool in
    return s1 > s2
}
)

# sorted의 by라는 인자에 문자의 순서를 정하는 클로저를 넘겨줬다.

let numbers = [1,2,3]
let strings = numbers.map ( { element in String(element)})
# map 다음에 함수(f(x))를 넘겨주면 f(e1), f(e2) 로 변환할 수 있다.
```

#### 자주 쓰는 고차함수
```
# filter

let numbers = [1,2,3,4,5,10,33]
let filtered = numbers.filter({$0 > 10})
# 인자가 10 이 넘는 것만 골라줘

# reduce
let reduced = numbers.reduce(0, {$0 + $1})
# 1차원 배열 => 상수, 2차원 배열 => 1차원 배열로 만들때 많이 씀.
# 0이 $0이 되고, $1이 numbers의 요소를 돌아가면서 더한다는 뜻인듯

# map
optional도 가능

# flatmap
무조건 값을 꺼내줌

```


#### 예약어 (차후 추가)

```
func
# 함수예약어

let
# 상수를 만드는 예약어

try - catch
# 에러 핸들링에 쓰는 예약어

switch - case
# 일반적인 switch - case문과 같지만, break문을 안써도 된다. 기본이 break가 걸려있고, break없이 계속 진행하게 하려면 fallthrough라는 예약어를 쓴다.
```
