# Swift horizontal ScrollView 내부를 Autolayout으로 바꿀 때 오류 해결 

준개입니다. 
프로젝트 막바지에 부랴부랴 autolayout을 적용하고 있습니다. 
일생 팁 : 처음에 view짜면서부터 autolayout을 하자. 
이전에 안드로이드를 할 때는 고정값으로만 주고, 
태블릿은 제대로 지원하지도 않았었기때문에 새로이 겪어보는 괴로움입니다. 

-
그러던 와중 Horizontal scrollview를 뜯어 고치게 되었는데요. 
기존에는 iPhone 7 에 scrollview가 고정폭 / 높이로 넣어져있던 상태였습니다.

또한 해당 scrollview가 포함된 상태의 view Controller에서 for문을 돌면서, 
3개의 항목을 가로로 추가시켜 scrollview의 content size를 지정해주는 형식이었습니다. 

즉 아래와 같은 코드 형식을 유지하고 있었죠. 
```
  if self.reviewScrollView != nil {
                let imageViewWidth = self.reviewScrollView.frame.size.width;
                let imageViewHeight = self.reviewScrollView.frame.size.height;
                var xPosition:CGFloat = 0;
                var scrollViewSize:CGFloat=0;
                var cnt = 0
                let scrollViewImageNum = 3
                
                for review in self.reviewList {
                    if cnt >= scrollViewImageNum {
                        break;
                    }
                    
                    let url = URL(string: review.p_image)
                    let myImageView:UIImageView = UIImageView()
                    let blackLayerView : UIView = UIView()
                    let barLabel : UILabel = UILabel()
                    let brandLabel : UILabel = UILabel()
                    let nameLabel : UILabel = UILabel()
                    let reviewLabel : UILabel = UILabel()
                    let moreLabel : UILabel = UILabel()
                    let hotReviewLabel : UILabel = UILabel()
                    let selectedCountLabel : UILabel = UILabel()
                    let totalCountLabel : UILabel = UILabel()
                    let starImageView : UIImageView = UIImageView()
                
                    
					  // 이 부분에서는 sub뷰 위치와 크기를 작업해준다.
                    self.reviewImageView.addSubview(myImageView)
                   // 기타 필요한 뷰들을 추가로 addSubview해준다.
                 
                    xPosition += imageViewWidth
                    scrollViewSize += imageViewWidth
                    cnt = cnt + 1
                };
    
                self.reviewScrollView.contentSize = CGSize(width: scrollViewSize, height: 0.8);
                
            }
```

하지만 scrollview만 autolayout으로 바꾼다고해서, 안에 있는 요소들도 저절로 바뀌는 것은 아니었습니다.
즉 위의 코드에서 myImageview들을 비롯해 **코드로 추가해줬던 뷰** 들의 레이아웃을 바꾸어야했죠. 
이전, `// 이 부분에서는 sub뷰 위치와 크기를 작업해준다.`  라고 적혀있는 곳에 
픽셀 단위로 지정이 되어 있는 부분을 변경해야합니다. 

이에 따라 **xib로 scrollview의 subview** 를 새로 만들어야했습니다.

## Xib 파일 만들기 

View만 따로 사용할 일이 있다면, Xib파일을 만드는 게 맞습니다. 
스토리보드에 직접 만들지 말고요!
프로젝트 아무 곳에서나 새 파일을 만듭니다. xib 파일만 모아놓는 폴더에서 만드는게 좋겠죠?

`New file - User Interface - View` 를 선택합니다. 

그러면 빈 뷰가 하나 있는 xib가 뜹니다. 
1. 스토리보드에 필요한 뷰를 그려놓은 상태라면 
스토리보드에서 해당 뷰를 모두 선택하고 복사합니다. 
xib 파일에 붙여넣기합니다. 

2. 스토리보드에서 하듯, 뷰를 지정해줍니다. 

그 다음에는 이 뷰들 간의 관계를 이용해서 auto layout을 지정해줍니다. 


## View 파일에 연결하기 

이제 `New file - Cocoa touch - UIView를 상속한 swift파일 생성`  합니다. 
이름은 Custom View라고 하겠습니다.
그리고 다시 만들었던 xib파일로 갑니다.
현재는 최상위 뷰가 UIView를 상속하고 있는데요.
이 부분을 방금 만든 Custom View파일로 바꿔줍니다. 

버튼을 눌러 outlet으로 최상위 뷰를 제외한 하위 뷰들을 view파일에 모두 연결해줍니다. 

**그런데!**
이렇게 만든 Custom View는 `CustomView()` 와 같이 인스턴스를 생성하면, 연결된 subview들이 텅 빈 상태로 초기화가 됩니다. 

**xib에서 view파일을 만들어내는 함수**가 따로 있어야합니다.

만들어준 View 파일 아래 다음 함수를 추가해줍니다.

```
# CustomView.swift
class func instanceFromNib() -> CustomView {
        return UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomView
    }
```

그러면 제가 만든 Custom View의 전체코드는 다음과 같이 됩니다. 

```
import UIKit

class CustomView: UIView {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var blackLayerView : UIView!
    @IBOutlet weak var barLabel : UILabel!
    @IBOutlet weak var brandLabel : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var reviewLabel : UILabel!
    @IBOutlet weak var moreLabel : UILabel!
    @IBOutlet weak var hotReviewLabel : UILabel!
    @IBOutlet weak var selectedCountLabel : UILabel!
    @IBOutlet weak var totalCountLabel : UILabel!
    @IBOutlet weak var starImageView : UIImageView!
  
    class func instanceFromNib() -> CustomView {
        return UINib(nibName: "CustomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomView
    }
}

```

이 뷰를 ViewController에서 inflate할 때는 다음과 같이 코드를 써주면 됩니다. 

```
let customView = CustomView.instanceFromNib()
```


## Scrollview도 autoLayout으로 만들기 
또 하나, 고정 폭/높이였던 scrollview도 autolayout을 적용해주어야겠지요!
저는 스크롤 뷰의 부모뷰의 상단-leading-trailing을 맞춰주고 일정한 height을 주었습니다. 

## ScrollView 생성 코드를 바꿔보기 

이제 scrollview와 그 내부 view를 모두 autolayout으로 줬으니, 
잘되겠죠! 

기존의 
```
  if self.reviewScrollView != nil {
                let imageViewWidth = self.reviewScrollView.frame.size.width;
                let imageViewHeight = self.reviewScrollView.frame.size.height;
                var xPosition:CGFloat = 0;
                var scrollViewSize:CGFloat=0;
                var cnt = 0
                let scrollViewImageNum = 3
                
                for review in self.reviewList {
                    if cnt >= scrollViewImageNum {
                        break;
                    }
                    
                    let url = URL(string: review.p_image)
                    let myImageView:UIImageView = UIImageView()
                    let blackLayerView : UIView = UIView()
                    let barLabel : UILabel = UILabel()
                    let brandLabel : UILabel = UILabel()
                    let nameLabel : UILabel = UILabel()
                    let reviewLabel : UILabel = UILabel()
                    let moreLabel : UILabel = UILabel()
                    let hotReviewLabel : UILabel = UILabel()
                    let selectedCountLabel : UILabel = UILabel()
                    let totalCountLabel : UILabel = UILabel()
                    let starImageView : UIImageView = UIImageView()
                
                    
					  // 이 부분에서는 sub뷰 위치와 크기를 작업해준다.
                    self.reviewImageView.addSubview(myImageView)
                   // 기타 필요한 뷰들을 추가로 addSubview해준다.
                 
                    xPosition += imageViewWidth
                    scrollViewSize += imageViewWidth
                    cnt = cnt + 1
                };
    
                self.reviewScrollView.contentSize = CGSize(width: scrollViewSize, height: 0.8);
                
            }
```

라는 코드를,

```
  if self.reviewScrollView != nil {
                let imageViewWidth = self.reviewScrollView.frame.size.width;
                let imageViewHeight = self.reviewScrollView.frame.size.height;
                var xPosition:CGFloat = 0;
                var scrollViewSize:CGFloat=0;
                var cnt = 0
                let scrollViewImageNum = 3
                
                for review in self.reviewList {
                    if cnt >= scrollViewImageNum {
                        break;
                    }
                    
                    let url = URL(string: review.p_image)
                    let customView = CustomView.instanceFromNib()
                    
                    self.reviewImageView.addSubview(customView)
                 
                    xPosition += imageViewWidth
                    scrollViewSize += imageViewWidth
                    cnt = cnt + 1
                };
    
                self.reviewScrollView.contentSize = CGSize(width: scrollViewSize, height: 0.8);
                
            }
```
로 바꿔줍니다. 


## 에러 :  ??
하지만 다음과 같은 에러를 마주하게 됩니다. 
뜬금없이 x좌표와 y좌표가 0 이 아니라 -900정도로 잡히고,
scrollview 내부에 잘 들어있지도 않죠.

`그러면 frame을 다시 설정해주면 되지 뭐가 문제야!`
네, 안돼서 4시간 동안 붙잡고 있었습니다. 

문제는 autolayout이 설정된 뷰 안에 autolayout이 들어가서 인 것으로 보입니다. 
이를 해결해준 마법의 코드는 바로  아래의 코드입니다.
```
customView.translatesAutoresizingMaskIntoConstraints  = true 
# CustomView의 auto layout을 끕니다.
```

이 코드를 for문안에 넣으면 됩니다. 
autolayout을 끈다고 하지만, 실제로는 원하는 대로 잘 설정됩니다. 
대신 제멋대로인 크기와 원점 좌표를 잡아줍니다. 
저 옵션이 말하는 바가 굉장히 모호해, 이에 대해 좀더 찾아 보아야겠습니다.


엉엉….이것때문에 얼마나 마스터님을 괴롭혔는지 정말 죄송하네요.

언제나처럼, 고생하시는 분이 있다면 도움이 되었길 바랍니다. 