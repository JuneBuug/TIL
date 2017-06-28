# WebView

웹뷰는 말 그대로 앱 내에서 웹을 보게 해주는 방법이다.
유니브인포 앱을 만들면서 채용공고로 바로 이동해야하는 경우가 있어서 사용하게 되었다.

xml 파일에서는 다음과 같이 추가해준다.
```

<WebView
       android:id="@+id/webview"
       android:layout_below="@+id/upper_bar"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       >
   </WebView>

```

액티비티 혹은 프래그먼트 내에서는 이렇게 정해준다.

```
#ViewbyId를 해줬다고 가정한다.

webview.setWebViewClient(new WebViewClient());
# 웹뷰 클라이언트를 새로 만들지 않으면 아예 새창에서 뜬다고한다.
webview.loadUrl(url);

```


## 멀티터치와 줌 옵션 켜기 + 하지만 줌 아이콘은 없애기

참고: http://je2ct.tistory.com/68

```
# xml

<WebView
       android:id="@+id/webview"
       android:layout_below="@+id/upper_bar"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       android:focusable = "true"
       android:focusableInTouchMode = "true"
       >
   </WebView>


# java 혹은 kotlin 파일에 아래 파일 추가.

webview.getSettings().setBuiltInZoomControls(true);
webview.getSettings().setSupportZoom(true);
webview.getSettings.setDisplayZoomControls(false);
```


## 웹뷰 상단에 웹의 title 가져와서 셋팅하기

출처 : http://kanzler.tistory.com/126

```
webview.loadUrl([사용할url]);
   webview.setWebChromeClient(new WebChromeClient() {
                @Override
                public void onReceivedTitle(WebView view, String sTitle) {
                    super.onReceivedTitle(view, sTitle);
                    if (sTitle != null && sTitle.length() > 0) {
                        title.setText(sTitle);
                    } else {
                        title.setText("Web Page");
                    }
                }
            });

```

위의 코드는 title 로딩 시 바로 로딩 되게 하는 코드.
웹페이지를 모두 받아오는 걸 기다릴 필요가 없음.
