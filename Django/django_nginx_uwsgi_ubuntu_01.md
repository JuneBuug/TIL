# Django + Postgresql + Nginx + uwsgi + Ubuntu 16.04 + Amazon ec2 설정하기 1편


###  참고

[Nginx, uwsgi 배포](https://wikidocs.net/6611)
[Nginx, wsgi 배포: python3 / nginx / uwsgi](http://blog.leop0ld.org/posts/use-python3-django-uwsgi-nginx/)


## Nginx와 uwsgi 란

[참고자료](http://technerd.tistory.com/55?category=629332)

Nginx는 웹서버. 정적인 부분을 담당하고 html,css,js, images와 같은 부분을 유저에게 전달해준다.

uWSGI는 웹 어플리케이션 서버. 동적인 부분을 처리해준다.

유저의 request를 python 요청으로 바꿔서 django 서버에게 일임하고, 다시 python 결과를 바꿔서 돌려보내주는 역할을한다.

uWSGI만으로도 서비스가 가능하지만,
static한 부분은 Nginx가 처리해줌으로서 서버에 들어가는 load를 줄일수 있다고 한다.

## 배포에 필요한 Django project 준비

[Django project문서](https://docs.djangoproject.com/en/2.0/howto/deployment/checklist/)를 보면 다음과 같이 deploy 준비를 권한다.

```bash
python3 manage.py check --deploy
# deploy 준비가 됐는지 안됐는지 검사해준다.
```

기본 개발과정에서 이걸 돌리면 오류가 엄청나게 나온다.

일단 Django Project를 배포하려면 <프로젝트>/settings.py를 분기해서 설정해야한다.

사람마다 production과 development, common 이라는 이름 혹은
deploy와 development, base 파일로 나누곤하는데

여기서는 전자를 선택하겠다.

[Django 배포준비](https://jyhwng.github.io/pythondjango/2017/02/14/django-settings-for-deploy.html)를 참고한다.
파일 구성은 다음과 같다.
```
<django-project이름>
├── envs.json
├── manage.py
├── <app이름>
│   ├── __init__.py
│   ├── admin.py
│   ├── apps.py
│   ├── authentication.py
│   ├── migrations
│   ├── models.py
│   ├── serializer.py
│   ├── social.py
│   ├── tests.py
│   └── views.py
├── requirements.txt
└── <django-project이름>
    ├── __init__.py
    ├── settings
    │   ├── __init__.py
    │   ├── common.py
    │   ├── dev.py
    │   └── prod.py
    ├── settings.py
    ├── urls.py
    └── wsgi.py
```

여기에 json파일로 envs.json을 만들어서 SECRET_KEY 및 DATABASE_NAME등을 빼고 공개 repo의 경우에는 json 파일을 올리지 않는다.

이 과정은 beomi 블로그나 milooy 블로그 참고.

## Amazon EC2 (선택사항)

VPC(Virtual Private Cloud)에서 public 과 private subnet을 나누어 설정하는데 이때

VPC CIDR IP addr 설정은 대개 10.X.0.0/16 으로 하고, subnet을 10.X.1.0/24 / 10.X.11.0/24 등의 방식으로 나눈다.
(subnet이 많이 증가될 경우를 대비하여 이렇게 설정. subnet을 더 많이 써야하는 회사의 경우 11.0이 아니라 61.0 부터 시작하기도 한다.)

하나의 subnet은 바깥과 연결된(public) subnet이고, 다른 하나는 이 public subnet을 통해서만 접근할 수 있는 private subnet이다. (DB나 중요한 정보들)

같은 region내에서 AZ가 두개씩 있기때문에, 혹시 모를 재난 발생을 대비하여 다른 AZ로 설정해줄 수 있다.

public subnet의 경우는 routing table에서 0.0.0.0/0을 설정해주면 된다.
이러면 인터넷 연결이 가능하고 -> 누구든지 들어올 수 있음. (API 요청)

Django API 서버는 public subnet에, PostgreSQL DB 는 private subnet에 위치시키려고한다.

이제 먼저 public subnet에 Django API 서버를 설정해보도록하자.


### public subnet에 ec2를 설정하기

ec2 instance를 만들어준다.

* VPC :  위에서 설정한 public subnet에 해당하도록 설정해준다.
* OS : 무난한 ubuntu 16.04 LTS 를 선택
* key : pem키는 잃어버리지 않도록한다. 한번 받으면 다시 받을 수 없고, 남에게 전달할 때는 암호화 압축해서 전달하는 게 정석임
* port : 80포트와 ssh 포트, django 포트(8000) 를 열어준다

## 접속과 ubuntu 기본 설정

```bash
# OS X
chmod 400 <pem키경로>
# chmod 400 ~/pems/junekim.pem
ssh -i <pem키경로> ubuntu@<publicIP주소>
# ssh -i ~pems/junekim.pem ubuntu@13.13.13.13

```


```bash
# ubuntu 접속 후  
sudo apt-get update
sudo apt-get install python3-pip
# python3 을 설치한다.
sudo pip3 install virtualenv virtualenvwrapper
# 가상환경 관리를 위한 패키치를 설치

```

(bash 사용기준) 설치한 virtualenvwrapper 에서 사용할 python3 설정을 넣어주어야한다.

```bash
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3"
echo "export WORKON_HOME=~/.virtualenvs" >> ~/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
source ~/.bashrc
```

가상환경 생성 후 django project 땡겨오기
```bash
# mkvirtualenv <가상환경이름>

git clone <git저장소>
cd <프로젝트>
python3 -m virtualenv <가상환경이름>
# 가상환경 생성.
pip3 install -r requirements.txt
pip3 install Django uwsgi
# django 프로젝트 내에 pip3 freeze > requirements.txt 로 의존성을 빼주었었을 경우
./manage.py makemigrations --settings=<프로젝트>.settings.prod
# prod.py에 설정이 있다
./manage.py migrate --settings=<프로젝트>.settings.prod
./manage.py collectstatic --settings=<프로젝트>.settings.prod

```

이때 collectstatic 시점에서 prod.py에는 다음 코드가 있어야한다.

```python
import os
from .common import *
'''
common.py를 모두 포함하는데, 여기에 BASE_DIR가 정의 되어있다.
settings 폴더에 들어갔기때문에 일반 BASE_DIR와는 한단계 깊게 설정하여
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname((os.path.abspath(__file__)))))
'''
STATIC_ROOT = os.path.join(BASE_DIR, "static/")
```


```bash
./manage.py createsuperuser --settings=<프로젝트>.settings.prod
./manage.py runserver --settings=<프로젝트>.settings.prod 0.0.0.0:8000
# aws에서 8000번 포트가 열려있어야함 (Django 용, TCP)
```

이 시점에서 django가 기본으로 지원하는 테스트 서버가 잘뜨는지 확인해본다.


## uWSGI 설정

```bash
uwsgi --http :8000 --home /home/<유저이름>/<프로젝트>/<가상환경이름> --chdir /home/<유저이름>/<프로젝트> --module <django프로젝트>.wsgi
```

마찬가지로 8000번 포트에서 잘 뜨는지 확인한 후
```bash
deactivate
```
하여 가상환경을 나온다.

### uWSGI 옵션파일

```bash
sudo vi /home/<유저이름>/<프로젝트이름>/run/uwsgi.ini
```
하여 옵션파일을 만든다. run이 예약어인 디렉토리인지는 불분명하다. 그냥 만들던데.
저렇게 해서 vi를 연 후 다음 내용을 붙여 넣기한다.

```shell
[uwsgi]
uid = <유저이름>
base = /home/%(uid)/<프로젝트이름>

home = %(base)/<가상환경이름>
chdir = %(base)
module = <장고프로젝트>.wsgi:application
env = DJANGO_SETTINGS_MODULE=<장고프로젝트>.settings.<세팅파일>

master = true
processes = 5

socket = %(base)/run/uwsgi.sock
chown-socket = %(uid):www-data
chmod-socket = 660
vacuum = true
```

<프로젝트> 디렉토리까지 cd 명령어로 이동한 후 권한을 바꿔준다.
```bash
# 홈에서
cd <프로젝트이름>
sudo chown <유저이름>:www-data run
# run 폴더의 권한을 바꿔준다.
```

### 서비스 등록 스크립트 생성

```bash
cd
```
하여 홈디렉토리로 간 후

```bash
sudo vi /etc/systemd/system/uwsgi.service
```
해서 스크립트 파일을 연다.

다음 내용을 적절히 변경하여 붙여 넣는다.
```shell
[Unit]
Description=uWSGI Emperor service

[Service]
ExecStart=/home/<유저이름>/<프로젝트>/<가상환경이름>/bin/uwsgi \
        --emperor /home/<유저이름>/<프로젝트>/run
User=<유저이름>
Group=www-data
Restart=on-failure
KillSignal=SIGQUIT
Type=notify
NotifyAccess=all
StandardError=syslog

[Install]
WantedBy=multi-user.target
```

### uWSGI 서비스 등록 및 구동 확인

```bash
sudo systemctl start uwsgi
sudo systemctl enable uwsgi
# 등록 - 구동
sudo systemctl status uwsgi
# 구동 확인. 이 시점에서 running이 아니면 문제가 있는 거니 위의 설정을 꼼꼼히 확인하자.
```

## nginx 설치하기
```bash
sudo apt-get install nginx
```

## nginx 설정

```bash
sudo vi /etc/nginx/sites-available/<프로젝트>
```
로 파일을 생성한다.

내용은 다음과 같다.
```shell
upstream django {
    server unix:/home/<유저이름>/<프로젝트>/run/uwsgi.sock;
}

server {
        listen 80;
        server_name <서버아이피-http나/는없어도된다>;

        location = /favicon.ico { access_log off; log_not_found off; }

        location /static/ {
                root /home/<유저이름>/<프로젝트>;
        }

        location / {
            include         /etc/nginx/uwsgi_params;
            uwsgi_pass      django;
        }
}
```
이렇게 만든 파일은 `sites-available`에 등록되고, `sudo ln` 명령어로 `sites-enabled`에 링크된다.

```bash
sudo ln -s /etc/nginx/sites-available/<프로젝트> /etc/nginx/sites-enabled
```

혹시 이 파일을 잘못만들고 링크하면 링크한 파일을 지워줘야한다.

링크한 파일만 지우는 방법은 다음과 같다.
```bash
sudo rm -f /etc/nginx/sites-enabled/<프로젝트>
# rm -rf하면 원본파일이(available에 있던) 지워진다. 주의
```

### nginx 문법 검사 및 재가동

```bash
sudo nginx -t
# test를 통과하면 다음과 같이 뜬다.
# nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
# nginx: configuration file /etc/nginx/nginx.conf test is successful
sudo systemctl restart nginx
```

### 언제 uwsgi재시작을 할건가

`sudo systemctl restart uwsgi` 는 언제 할까

1. git pull을 했을 때
당연히 Django 앱의 내용이 달라졌기때문에 그 내용이 적용되려면 python 명령을 해석해주는 친구가 다시 바뀐걸 알아채도록 재시작

### ec2 정지->시작 으로 publicIP가 달라졌을 때
ec2 일시정지 이후 시작을 다시 하면 publicIP가 달라지는 경우가 있다.
이때 다음 파일들도 같이 설정해줘야한다.

```
sudo vi /etc/nginx/sites-available/<프로젝트>
# 열리는 파일에서 서버 ip 변경
sudo rm -f /etc/nginx/sites-enabled/<프로젝트>
sudo ln -s /etc/nginx/sites-available/<프로젝트> /etc/nginx/sites-enabled/<프로젝트>
# 변경된 서버 ip 가 적용된 파일을 다시 링크해준다.

django에서 사용되는 setting 파일의 ALLOWED_HOSTS
# ALLOWED_HOSTS에 변경된 서버 ip를 넣어준다.
```

### cf) 전역 uWSGI 설치

```bash
sudo apt-get install python3-dev python3-pip python3-setuptools
sudo -H pip3 install uwsgi
```
