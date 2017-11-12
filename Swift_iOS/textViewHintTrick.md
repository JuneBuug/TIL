[출처](https://stackoverflow.com/questions/27652227/text-view-placeholder-swift)


## TextView에서 hint 문구 작성하기

Label과 달리 TextView에는 hint문구를 Storyboard에서 직접 편집할 수 없다.

그래서 textview delegate을 통해 해결할 방법을 찾던 중,

위의 링크를 보게 되었다.

도움말, hint, placeholder 등의 키워드로 찾으면 나온다.


### 과정

크게 고려할 점은 다음과 같다.

1. ViewController Class에서 UITextViewDelegate를 상속한다.

2. viewDidLoad() 함수에서 textView가 스스로의 delegate를 사용하도록한다.

3. placeholderLabel 변수를 UILabel로 만든다.

4. viewDidLoad에서 placeholderLabel에 원하는 힌트 문구를 적고, textView에 addsubview한다.

5. placeholderLabel의 isHidden 값을 textView에 text가 있는 경우엔 true로 둔다.

6. UITextViewDelegate 중 textViewDidChange에 5번 내용을 다시 한번 적는다.

```swift

class WriteViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    var placeholderLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()


        textView.delegate = self
        textView.becomeFirstResponder()

        placeholderLabel = UILabel()
        placeholderLabel.text = "@로 사람을 태그하고, 메모를 적어주세요 :)"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
    }


    // 편집 중일 때
        func textViewDidChange(_ textView: UITextView){
            placeholderLabel.isHidden = !textView.text.isEmpty
             // 나머지 code...
          }
```
