# Node.js 기본


## [Node.js](https://nodejs.org/ko/) 란?

Node.js는 Chrome V8 JavaScript 엔진으로 빌드된 javascript **런타임** 이다. 즉 터미널에서 실행할 수 있는 자바스크립트 실행기라는 뜻이고,
이걸 이용해서 웹서버를 만들기 시작했을 뿐이다.
이벤트 기반이여서 엄청 많은 사용자를 커버하기 쉽고,
npm이라는 패키지 매니저를 통해서 쉽게 프로그램을 추가할 수 있다.

* 웹서버 프레임워크 아님 !
* 비동기 프레임워크 아님 !

## 설치 방법
로컬과 서버에 설치하자.
[설치링크](https://nodejs.org/ko/download/package-manager/)
```
$ node
> console.log("hello, node");
# node라고 치면 javascript를 칠 수 있다.
```

## MEAN
이게 바로 웹서버 프레임워크.
MEAN = MongoDB + Express + Angular + Node
MoogoDB는 쉬운 디비이고, Express가 웹 프레임워크!
Spring / Django같은건 full-framework여서, 사용하기만 하면 됨.
반면 Express / flask는 가벼워서 되어있는게 없고 , 커스텀이 가능함.
롤 이벤트 페이지! 같은 건 동접자는 많고 하니 MEAN으로 만들어짐.
요즘은 MERN도 인기 (Angular => React)


## express 설치하기
```
$ mkdir 디렉토리
# 디렉토리를 하나 만든다
$ cd 디렉토리
# 디렉토리로 이동
$ npm init
# package.json파일 만드는 과정
$ npm install express --save
# express를 만들고 save함
```

## index.js
`npm install express --save`
하는 과정에서 디폴트가 index.js로 되어있다.
여기서 url과 뿌려줄 화면 등을 연결하고, 몇번 포트를 열건지,
어떤 프레임워크를 사용할 건지 결정하는 듯함. (향후 추가+보완)

index.js
```
var express = require('express');
var app = express();

app.get('/', function(req,res){
  res.send('Hello World!');
});

app.listen(3000,function(){
      console.log('3000번 포트 열어놨음!');
  });

```
### 실행하기

`$ node index.js`


## 정적페이지를 만들고 올리기.
html / css / js/ image 같은 정적 파일들은 별도로 관리한다.
그 정적 파일들은 static이라는 폴더에 넣기로하는데,
원하는 디렉토리를 static 폴더로서 사용할 수 있다.

이 [url](http://expressjs.com/ko/starter/static‐files.html)을 참조하면 다음과 같이 index.html을 뿌려주는 index.js 파일을 작성할 수 있다.

```
var express = require('express');
var app = express();

app.use('/static', express.static(__dirname + '/public'));
# static 폴더를, 현재 디렉토리 아래에 있는 public폴더로 삼는다.

var path = require('path');

app.get('/', function (req, res) {
 res.sendFile(path.join(__dirname + '/public/index.html'));
});

# '/' 라는 주소를 만났을때 public 폴더 아래에 있는 index.html을 보내준다.

app.listen(3000, function () {
console.log('Example app listening on port 3000!');

# 3000번 포트를 사용한다.
});
```

### AWS 서버에서 결과물 올리기

1. ec2 인스턴스에서 해당 코드를 pull 받는다.
2. AWS 해당 인스턴스 보안그룹에서 TCP 3000번 포트를 열어준다.
3. `node index.js` 를 통해 실행시킨다.

### 서버에 node index.js로 띄워놓았고 , 그 node서버를 내리고 싶을 때
node process를 찾아서 그걸 kill 한다!
어떻게 ?

```
sudo netstat -lpn |grep :'3000'
# 3000번 포트를 잡는다
kill -9 죽여야하는pid
# node 프로세스에 해당하는 pid를 찾아서 닫는다.
```
