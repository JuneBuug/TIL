# iOS Firebase RealTimeDatabase 연동하기 
[iOS 프로젝트에 Firebase 추가](https://firebase.google.com/docs/ios/setup) 를 보고 따라했습니다.
[iOS에서 Firebase RealTimeDatabase연동하기](http://junebuuug.tistory.com/40)에서 편하게 볼 수 있다. 
## 세팅하기 
파이어베이스를 셋팅하는 건 증맬증맬 간단하다! 

1. 먼저 다음과 같이  firebase console에서 프로젝트를 하나 만든다. 
지역은  대한민국으로 설정한다.
2. 다음과 같이 iOS를 누르고 설정한다. 
3. Bundle identifier를 설정하라고 나오는데, 이는 xcode에서 프로젝트를 새로 만들 때 아래 그림의 빨간 네모친 곳에 나온다. 이걸 복사해서 넣어준다. 
4. 이름은 자신이 보기에 구별하기 쉬운 이름을 넣어주면된다. 
5. 그러면 설정파일이 잔뜩 들어있는 `google-services.plist` 가 나온다. 이걸 다운 받아서 그림처럼 프로젝트 파일 내에 복사해주자. 

6. 그러면 이제 cocoapod을 사용해서 firebase를 설치해주자. 
7. cocoapod이 없다면 침착하게 이 링크를 타고가서 설치하자. 
8. 터미널(혹은 iTerm)을 타고, [프로젝트명].xcodeproj가 있는 곳에서 
```
pod init
# Podfile을 생성한다.
open -a Xcode Podfile
# Xcode로 Podfile을 열고싶다. 
```

을 차례로 입력해주자. 

9. Podfile이 열렸다면, 다음 파일과 비슷하게  되어있을 것이다. 
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'firebaseprac' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for [프로젝트명]
  # 추가할 Pod들을 넣는다. 
  pod 'Firebase/Core'
  pod 'Firebase/Database'

  target 'firebasepracTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'firebasepracUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
```

use_frameworks! 하단에 추가하고 싶은 pod들을 넣는다. 
즉 위의 코드처럼, 
```
pod 'Firebase/Core'
pod 'Firebase/Database'
```

의 두줄을 추가해주는 게 핵심이다. 

10. 수정한 Podfile을 닫고, 터미널에서
```
pod install
```

을 친다. 

11. Podfile을 생성하고 나면, 기존에 사용했던 [프로젝트명].xcodeproj가 아니라 [프로젝트명].xcworkspace를 사용해야한다.  열어주자.

## App Delegate에 기본 설정하기 

1. Appdelegate 파일의 최상단에 
```
import Firebase
```

로 Firebase를 import한다. 

2. didFinishLaunchingWithOptions함수에 다음과 같이  FirebaseApp을 설정해준다.
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }
```

그러면 다음 사진처럼 된다. 

## ViewController에서 Database 사용해보기
1. 일단 다음과 같이 firebase console에서 json을 설정해줘본다. 기본으로 있는 아이템 아래 다음과 같이 내용을 추가했다. 목표는 item_name을 tableview에 뿌려주는 것이다. 
2. 이를 위해서 상단에 
```
import Firebase
import FirebaseDatabase
```
를 한다. FirebaseDatabase를 import하지 않으면 이후에 나오는 디비 관련 멤버들이 빌드는 되지만 에러라고 뜨는 기묘한 현상이 일어난다.  

3. 클래스에 DatabaseReference 타입 변수를 지정해준다. 
```
var ref : DatabaseReference! 
```

4. viewDidLoad() 에서 이 ref 라는 변수에 파이어베이스 레퍼런스를 연결해주고, 실제로 내용을 불러올 함수를 호출한다. 
```
self. ref = Database.database().reference()
getItemData()
# 파이어베이스의 내용을 불러올 함수 
```


5. 현재 ref는 최상위 노드의 위치에 있다고 보면된다.  이때 ref의 child인 “cs_item”, 그 cs_item의 child인 1로 들어가 그 상태의 데이터 스냅샷 값을 가져온다. 
가져온 값을 dict라는 변수에 할당한다. 
이제 dict에는 [ price: 1200, item_name: “덴마크시리얼우유”, … ] 가 들어간 상태다.
여기에서 item_name이라는 키 값으로 가져와 변수에 할당해준다.
그리고 테이블을 다시 로드한다. 

```
 func getItemData(){
        
ref.child("cs_item").child("1").observe(DataEventType.value, with: { (snapshot) in
            let dict = snapshot.value as?  [String : AnyObject] ?? [:]
            self.item_name = dict["item_name"] as? String ?? ""
            self.mainTable.reloadData()
        })
    
    }

```


6. 짜잔! 

7. 이 ViewController의 전체 코드는 여기에서 볼 수 있다. 