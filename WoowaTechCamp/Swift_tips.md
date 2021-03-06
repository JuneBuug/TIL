# 초보 스위프트러의 꿀팁모으기
swift as coursing river!


1. 모델 만들 때 변수 설정

`public private(set) var caption: String` 라는 식으로 모델 내 변수를 정하면 getter는 자동으로 만들어지지만 setter는 없는 변수가 된다. 어메이징!

2. 모델 만들때 dictionary에서 초기화.
```
convenience init(dictionary: NSDictionary) {
    let caption = dictionary["Caption"] as? String
    let comment = dictionary["Comment"] as? String
    let photo = dictionary["Photo"] as? String
    let image = UIImage(named: photo!)?.decompressedImage
    // 작은 이미지를 만들수있게 그 크기로 딱잘라주는 extension
    self.init(caption: caption!, comment: comment!, image: image!)
  }
```
받아와서 넣어주면 됨!


3. 유용한 함수 모음


```
let rect = NSString(string: comment).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
# string의 길이에 따라서 그에 맞는 사각형을 리턴해주는 함수 `boundingRect`
# 한글인 경우 잘 안될수있고 비싼 함수임
# 셀이 많은 경우(몇만개이상) 굉장히 느려질 수 있음

```


4. Transport Security has blocked HTTP

http 통신을 할 때 info.plist에 추가해줘야할 것들이 있다.
이게 추가가 안되서 뜨는 에러로,
다음 링크를 참조해보자.
[StackOverflow답변](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)

그러면
```
<key>NSAppTransportSecurity</key>
<dict>
  <!--Include to allow all connections (DANGER)-->
  <key>NSAllowsArbitraryLoads</key>
      <true/>
</dict>
```

라는 코드를 info.plist에 추가해야한다는 사실을 알 수 있다.

1. info.plist 의 source code를 연다.

![info_plist_source](screenshots/screenshot_plist.png)


2. info.plist 하단에 위의 코드를 추가한다.

![info_plist_source](screenshots/screenshot_plist2.png)
