# iOS에서 Firebase 이중 필터하기 
파이어베이스에서 데이터를 받아오려면 일단 Event와 Query에 대한 이해가 필요하다.
Event는 기본적으로 `어떤 시점에` 데이터를 받아올 지에 관한 것이고,
Query는 그 시점에 `무슨 데이터를`  보내줄 지에 관한 이야기다.

## Event 종류 

* FIRDataEventTypeValue
경로의 전체 내용에 대한 변경을 읽고 수신대기한다…
즉 그냥 아래 나올 모든 이벤트가 일어나면, 그 이벤트를 감지하고 반응하는 이벤트.
물론 그냥 최초 한번도 불린다. 
코드로는 
```
let localRef = ref.child("product")
localRef.observe(DataEventType.value, with: { (snapshot) in
	   # 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

로 쓴다.  ( Xcode 8.3.3, Swift 3, iOS 10.0 deployment 기준) .

* FIRDataEventTypeChildAdded	
해당 경로에서 **항목이 추가** 되면  이벤트를 감지한다. 
코드로는 
```
let localRef = ref.child("product")
localRef.observe(DataEventType.childAdded, with: { (snapshot) in
		# 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

로 쓴다.  ( Xcode 8.3.3, Swift 3, iOS 10.0 deployment 기준) .

* FIRDataEventTypeChildChanged	
해당 경로에서 **항목의 변화** 가 일어나면 이벤트를 감지한다. 
코드로는 
```
let localRef = ref.child("product")
localRef.observe(DataEventType.childChanged, with: { (snapshot) in
		# 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

로 쓴다.  ( Xcode 8.3.3, Swift 3, iOS 10.0 deployment 기준) .

* FIRDataEventTypeChildRemoved	
해당 경로에서 **항목이 삭제**  되면 이벤트를 감지한다. 
코드로는 
```
let localRef = ref.child("product")
localRef.observe(DataEventType.childRemoved, with: { (snapshot) in
		# 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

로 쓴다.  ( Xcode 8.3.3, Swift 3, iOS 10.0 deployment 기준) .


* FIRDataEventTypeChildMoved	
해당 경로에서 (순서가 orderbyChild 등으로 생긴 경우)  **항목의 순서가**  변경되면 이벤트를 감지한다. 
코드로는 
```
let localRef = ref.child("product")
localRef.observe(DataEventType.childMoved, with: { (snapshot) in
		# 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

로 쓴다.  ( Xcode 8.3.3, Swift 3, iOS 10.0 deployment 기준) .
순서가 변경됐다는 건 어쨌든 하위 항목이 변경(Moved) 됐다는 뜻이므로 
`DataEventType.childChanged` 다음에 온다고 한다.

* Single Event  + Value 
위와 같은 이벤트를 수신하지 않고, 최초 한번만 불러오기.
코드로는 
```
localRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
		# 이 시점에서의 스냅샷(데이터)로 하고 싶은 일
 })
```

## Query의 종류 

파이어베이스는 단순히 그 경로의 목록만 불러오는 게 아니라 
**간단한 정렬이나 필터링** 을 거쳐서 불러 올 수 있다. 
이걸 가능하게 하는 게 파이어베이스의 Query다.

Firebase의 쿼리는 다양한 종류가 있다.
[iOS에서 데이터 검색  |  Firebase](https://firebase.google.com/docs/database/ios/retrieve-data) 를 참고해보자. 

url 누르기도 귀찮아서 아래에 다시 정리해놓았다.

### 정렬 Query  종류 

* queryOrderedByKey	
하위 키에 따라 결과를 정렬합니다.
코드로는 
```
let localRef = ref.child("product")
let q = localRef.queryOrderedByKey()
q.observe(DataEventType.value, with : { (snapshot) in 
	# 걸러진 결과로 하고 싶은 일
})
```
와 같이 쓴다.
* queryOrderedByValue	
코드로는 
```
let localRef = ref.child("product")
let q = localRef.queryOrderedByValue()
q.observe(DataEventType.value, with : { (snapshot) in 
	# 걸러진 결과로 하고 싶은 일
})
```
와 같이 쓴다.

* queryOrderedByChild	
지정된 하위 키의 값에 따라 결과를 정렬합니다.
코드로는 
```
let localRef = ref.child("product")
let q = let query = localRef.queryOrdered(byChild: "grade_avg")
q.observe(DataEventType.value, with : { (snapshot) in 
	# 걸러진 결과로 하고 싶은 일
})
```
와 같이 쓴다.

위의 코드는 localRef 기준, 한단계 아래 항목인 grade_avg로 정렬을 하겠다는 뜻이다. 


### 정렬 기준
아니, 오름차순으로 정렬이여 내림차순으로 정렬이여?;; 하는 물음엔,

1. 지정된 하위 키의 값이 nil인 하위 항목이 맨 처음에 옵니다.
2. 지정된 하위 키의 값이 false인 하위 항목이 그 다음에 옵니다. 값이 false인 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
3. 지정된 하위 키의 값이 true인 하위 항목이 그 다음에 옵니다. 값이 true인 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
4. 숫자 값을 갖는 하위 항목이 다음에 나오며 오름차순으로 정렬됩니다. 지정된 하위 노드의 숫자 값이 동일한 하위 항목이 여러 개이면 키에 따라 정렬됩니다.
5. 숫자 다음에는 문자열이 나오며 사전순, 오름차순으로 정렬됩니다. 지정된 하위 노드의 값이 동일한 하위 항목이 여러 개이면 키에 따라 사전순으로 정렬됩니다.
6. 마지막으로 개체가 나오며 키에 따라 사전순, 오름차순으로 정렬됩니다.

이라고 적혀있다. 

nil > false > 숫자(오름차순) > 문자(사전순_오름차순) > 개체 

를 기억해두면 편하겠다. 

### 주의할 점 
이 정렬에 관한 쿼리는 한번밖에 적용이 안된다. 
만약 편의점 상품 하위 항목에 gs25 등의브랜드와 이 상품 점수라는 카테고리가 있다고 해보자.
나는 브랜드별, 점수별로 정렬을 해서 받고 싶지만 그런 기능은 Firebase가 지원하지 않는다.
이중으로 queryOrdered를 사용하면, 오류를 뿜으면서 쿼리 여러개 쓰면 안돼요! 한다.
이걸 해결하기 위해서 구글 공식 Youtube의 가이드에서는 어이없는 방법을 내놓았는데,
맨 아래에서 소개하도록하겠다. 


### 필터링 Query 종류 

* queryLimitedToFirst	
정렬이 된 리스트에서, 처음 몇개를 뽑아서 보내줄건지 결정해줌.

코드로는 이런 식으로 쓴다.
```
let localRef = ref.child("product")
        let query = localRef.queryOrdered(byChild: "grade_avg").queryLimited(toFirst: 3)
        
        query.observe(DataEventType.value, with: { (snapshot) in
            var productList : [Product] = []
            for childSnapshot in snapshot.children {
                let product = Product.init(snapshot: childSnapshot as! DataSnapshot)
                productList.append(product)
            }
            completion(productList)
        })

```
* queryLimitedToLast	
정렬이 된 리스트에서, 뒤쪽 몇개를 뽑아서 보내줄건지 결정해줌. 
코드로는 이런 식으로 쓴다.
```
let localRef = ref.child("product")
        let query = localRef.queryOrdered(byChild: "grade_avg").queryLimited(toLast: 3)
        
        query.observe(DataEventType.value, with: { (snapshot) in
            var productList : [Product] = []
            for childSnapshot in snapshot.children {
                let product = Product.init(snapshot: childSnapshot as! DataSnapshot)
                productList.append(product)
            }
            completion(productList)
        })

```

* queryStartingAtValue	
정렬된 리스트에서,  (값) >= (정해준 값) 인 데이터를 반환해줌.
```
let localRef = ref.child("product")
        let query = localRef.queryStarting(atValue: "gs25")
        query.observe(DataEventType.value, with: { (snapshot) in
            var productList : [Product] = []
            for childSnapshot in snapshot.children {
                let product = Product.init(snapshot: childSnapshot as! DataSnapshot)
                productList.append(product)
            }
            completion(productList)
        })
```

* queryEndingAtValue	
정렬된 리스트에서,  (값) <= (정해준 값) 인 데이터를 반환해줌.

```
let localRef = ref.child("product")
        let query = localRef.queryEnding(atValue: "gs25")
        query.observe(DataEventType.value, with: { (snapshot) in
            var productList : [Product] = []
            for childSnapshot in snapshot.children {
                let product = Product.init(snapshot: childSnapshot as! DataSnapshot)
                productList.append(product)
            }
            completion(productList)
        })
```

* queryEqualToValue	
정렬된 리스트에서 (값) == (정해준 값) 인 데이터를 반환해줌.
```
  let localRef = ref.child("review")
        let query = localRef.queryOrdered(byChild: "brand").queryEqual(toValue: brand)
        query.observe(DataEventType.value, with: { (snapshot) in
			# 해야하는 것 
        })
```


## 다중 필터링 / 정렬 하는 방법

 `브랜드로 정렬한 뒤 원하는 브랜드를 골라낸다`  를 달성하기 위해서는
brand라는 child로 정렬을 한 뒤 여기에 queryEqualToValue 함수를 붙여쓰곤 한다. 

`점수순으로 정렬한 뒤 상위 3개를 골라낸다.`
점수라는 child로 정렬을 한뒤 여기에 queryLimitedToLast (오름차순이므로 뒤가 제일 점수가 큼) 3 을 붙여 쓰곤 한다. 

하지만 
`선택한 브랜드와 카테고리의 항목만 골라낸 뒤 그 점수로 정렬한다.` 라는 기능은 지원하지 않는다.

[Firebase 데이터베이스에서 일반적인 SQL 쿼리 변환하기 - SQL 개발자를 위한  Firebase 데이터베이스 #4 - YouTube](https://www.youtube.com/watch?v=sKFLI5FOOHs&t=567s)
라는 비디오에서는 해결법을 이렇게 제시한다.

```
product : {
		brand : "gs25",
		category : "도시락",
		grade : 10
}
```

으로 되어있는 데이터 구조를 
```
product : {
		brand : "gs25",
		category : "도시락",
		grade : 10
		brand_category : "gs25_도시락"
}
```

다음과 같이 brand_category라는 항목을 추가하여 값을 찾으라는 거다. 
…….?
이렇게 하면, 기존의 데이터 구조를 다 바꿔야 할 뿐더러, 
brand_category로 정렬도 어렵다. 
실제로 해당 비디오에는 잔뜩 욕이 달렸다. 

결론부터 말하자면, 현재로써는 여러 쿼리를 적용할 수 있는 방법은 없다. 
그래서 기기에서 정렬과 필터링을 추가로 해주는 방법을 선택했다. 
예시 코드는 다음과 같다. 
```
static func getTopProductBy(brand : String, category : String, completion: @escaping ([Product]) -> ()) {
        let localRef = ref.child("product")
        let query = localRef.queryOrdered(byChild: "category").queryEqual(toValue: category)
        // 카테고리로 정렬한 뒤 원하는 카테고리만 뽑는다.
        query.observe(DataEventType.value, with: { (snapshot) in
            var productList : [Product] = []
            for childSnapshot in snapshot.children {
                let product = Product.init(snapshot: childSnapshot as! DataSnapshot)
                if product.brand == brand { // 브랜드로 필터링한다.
                    productList.append(product)
                }
                
            }
            // 가져온 상품를 평점 순으로 뿌려준다.
            productList.sorted(by: { $0.grade_avg > $1.grade_avg})
            completion(productList)
        })
    }
```

