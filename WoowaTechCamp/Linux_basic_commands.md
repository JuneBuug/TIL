# 리눅스를 알아보고 기본 커맨드를 적용해보자!

## 리눅스 역사

* 1969년 켄 톰슨과 데니스리치가 유닉스 OS를 만들다!
이분들은 C를 만든 사람이기도 해서 C로 유닉스를 만들었고, 이식성(portability)가 뛰어났다.

* 1991년 라이너스 토발즈가 Linux 커널을 만들다!
386 컴퓨터에 만들고 수만명의 사람들이 참여한 오픈소스.

## 리눅스 배포판

* Debian
* Ubuntu : Debian을 쉽게 만든 버전. [Ubuntu](www.ubuntu.org)
* Redhat Enterprize Linux : 서버용으로 제일 좋음. Fedora오류보고를 기반으로 개선, 회사에 파는 유료 리눅스.
* Fedora : Redhat에서 만든 리눅스.
* Cent : Redhat을 무료로 만든 버전.
* Mint Linux : 예쁜 리눅스.
* (참고) [Elementary OS](https://elementary.io/ko/) : 거의 맥처럼 예쁨.
* Gentoo : geek스러운 리눅스. 일일히 컴파일해서 소스에서 설치해야함. 설치가 일주일 걸림.
* Arch Linux
* Open SUSE : 초보자용으로 좋다고함.

#### 리눅스 소스관리를 하려고 만든게 git이다.

## 우분투 설정하기
```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install language-pack-ko
# 한글팩 설치하기
```

### 우분투에 한글팩 설정하기 (오류나 알림 등이 한글로 나옴)
#### $HOME/.bashrc
`$ vi ~/.bashrc` 를 통해 .bashrc파일을 열고 다음을 추가한다.

```
LANG="ko_KR.UTF-8"
LANUGAGE="ko_KR:ko:en_US:en"
```

`esc + :wq  나 shift + z*2 ` 로 저장한다음 bash에서
```
$ source ~/.bashrc
# bash를 켜면 자동으로 실행되는 파일 중 하나가 bashrc임. 따라서 실행시에 자동으로 셋팅해주고 싶은 것이 있으면, 이 파일에 추가를 하면 됨.
$ locale
$ env
```

## Shell 이란!

커널에 대치되는 개념. OS의 핵심은 커널이라구 하고, OS와 대화하는 껍데기는 shell(쉘)이라고 함.
* OS와 대화하는 프로그램
* 여러가지가 있음
* 맥은 zsh를 사용하는 것도 좋다. (oh-my-zsh). 미묘하게 더 좋은 커맨드가 있다. 디렉토리 이동시 ../../가 아니라 ... 를 사용하면 상위 2개를 한번에 이동할 수 있다던지!


## 기본 Linux commmand

### pwd
현재 디렉토리를 확인

### tree
트리 모양으로 표시. 패키지 인스톨 필요.
```
# 리눅스
$ sudo  apt-get install tree

# OS X (homebrew를 먼저 깔아야한다.)
$ brew install tree
```

#### [Homebrew](https://brew.sh/index_ko.html)
맥에서의 패키지 관리 프로그램.
간단하게 터미널에서의 관리를 통해서 해결할 수 있음.

### mkdir
새로운 디렉토리 생성

### cd
디렉토리 이동

### ls
List Directory, 디렉토리 내용을 보여줌
```
$ ls -l
$ ls -al
$ ll
```

### cat 파일이름
파일 내용 표시
```
$ cat hello.txt
```

### history
명령어 이력 표시
```
$ history
$ !명령어번호
# 해당 명령어를 다시 실행할 수 있음
$ history | tail
# 최근의 명령어 이력만 보여줄 수 있음.
```

### cp, mv, rm
cp는 copy, mv는 move, rm는 삭제.
```
$ls -R
# 디렉토리 하위내용까지 나옴
$ cp 원본파일 복사할파일명
# 원본파일을 복사할 파일에 복사
$ mv 디렉토리 없는디렉토리
# 디렉토리의 이름을 바꿈
$ rm -rf dir1
# 디렉토리 삭제
```

### find 디렉토리 -name "파일이름"
지정한 디렉토리 하위에서 해당 파일 검색

### touch 파일이름
0바이트 파일생성

### man / alias
도움말 보기 / 단축 명령 등록.
```
$ alias 단축명령='원래 명령어'
# 위의 코드를 bashrc에 추가해주면 bash에서 자동으로 등록해준다.
```

#### tmux
bash 여러개를 한 shell에 띄우게 해주는 프로그램. 네트워크가 끊겨도 프로그램을 돌아가게 해주는게 킬링 포인트.
