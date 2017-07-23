# AWS에 mysql 설치하기

이 포스팅은 `AWS EC2 instance, 운영체제는 Ubuntu LTS` 에서 진행합니다.


## mysql 설치하기 
우분투 셋팅을 마친 후에, mysql을 다음 코드로 설치하자.
```
$ sudo apt install mysql-server
# mysql 서버를 설치한다.
```

이때 root 사용자의 password를 설정하게 된다. 
만약 무심코 그냥 엔터를 눌러 아무것도 없는 password가 들어가면 접속이 안되니 주의하자. 
그런 상황이 온다면 침착하게 인스턴스를 새로 만드는게 좋다. 

mysql 다운로드가 끝났다면 다음 코드로 mysql 프로세스의 상태를 확인하자. 
```
$ sudo systemctl status mysql
```

잘 설치되었다면 현재 mysql이 실행되어있는 경우가 대부분이다. 
만약 실행이 되지 않았다면 
```
$ sudo service mysql start
```
로 mysql을 실행하자.

## mysql 에 접속하기 / 나오기 
다음 코드를 입력하자.
```
$ mysql -u root -p
# 아직 root 사용자 밖에 만들지 않아서 root로 접속
# 일반 코드는 mysql -u <사용자id> -p 후 패스워드 입력
```

처음에 설정해줬던 비밀번호를 입력하며 된다.
콘솔창에서 비밀번호를 입력할때는 입력 중에 내용이 보이지않으니 당황하지 말자 

접속이 완료됐다. 
나가고 싶으면 콘솔에 `exit` 을 입력하면 된다. 


## mysql 언어 설정을  latin1에서 utf-8로 바꾸기 
latin1이라는 언어 설정은 유럽사람들에게만 편한 설정이다.
한글을 지원하도록하기위해 침착하게 utf-8로 바꾸자.

mysql에 접속한 상태에서 
`mysql> status` 를 입력하자.

그러면 default-chracter-set이라는 항목들이 latin1로 설정되어있는 걸 볼 수 있다.
이걸 바꿔주기 위해 다음과 같은 커맨드를 입력한다.

```
$ sudo -i 
# root 사용자로 전환한다. 
$ cat /etc/mysql/my.cnf
# /etc/mysql/my.cnf의 내용을 본다.
```

원래는 my.cnf에서 설정을 바꿔주면 됐었는데, 이제는 다른 곳에서 설정을 바꿔주어야한다.
다음 커맨드는  utf-8로 바꿔주는 내용을 `/etc/mysql/mysql.conf.d/utf8.cnf` 라는 파일에 넣는 커맨드이다.

```
$ cat << 'EOF' > /etc/mysql/mysql.conf.d/utf8.cnf
# for utf8 characterset
[client]
default-character-set = utf8

[mysqld]
init_connect = SET collation_connection = utf8_general_ci
init_connect = SET NAMES utf8
character-set-server = utf8
collation-server = utf8_general_ci

[mysqldump]
default-character-set = utf8

[mysql]
default-character-set = utf8
EOF
```
이후
```
$ cat /etc/mysql/mysql.conf.d/utf8.cnf
# /etc/mysql/mysql.conf.d/utf8.cnf 파일의 내용을 확인한다.
# ctrl + d 로 root 로그아웃, 일반 사용자로 돌아온다.
$ sudo systemctl restart mysql 
# mysql를 재부팅한다.
```

재부팅 한 뒤에 
```
$ status 
# 현재 상태를 확인
```
해서 utf-8로 잘 변경되었는지 확인하자. 