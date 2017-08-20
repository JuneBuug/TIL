# Django로 REST API 서버 구축 튜토리얼 따라가기 1편
이 포스트는 [장고걸스튜토리얼](https://tutorial.djangogirls.org/ko/) 정도의 Django 이해도를 가진 상태의 사람(=저)를 대상으로 합니다. 
환경
* OS X 10.12.5,
* pycharm Professional 2017.2 
* python 3.4
* django 1.11.4 

또한 기본적으로 [PyCharm과 함께 DJango와 RestFramework를 활용한 웹 사이트 구축하기 – DevIssue](https://devissue.wordpress.com/2015/02/01/pycharm%EA%B3%BC-%ED%95%A8%EA%BB%98-django%EC%99%80-restframework%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EC%9B%B9-%EC%82%AC%EC%9D%B4%ED%8A%B8-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0/) 다음 포스트 글을 따라하며 생긴 오류들을 정리합니다.
- - - -


## 들어가며 
준개입니다. 
우아한 테크캠프 프로젝트에서 Firebase를 백단으로 사용습니다.
하지만 Firebase는 상당히 느리죠. 체감할 정도로 속도에 이슈가 생겼습니다.
마침 다른 조를 보니 rails로 서버를 세팅하는데 10시간 정도 걸렸다고 하더군요.
해서 rails에서 django로 갈아탄 저는 
바로 코드스쿼드 마스터 호눅스님께 여쭤보아 튜토리얼을 추천받았습니다. 

이 글에서는 
* 튜토리얼 내용을 요약합니다
* JsonField를 사용하기위해서 postgreSQL을 django에 적용합니다.
* 튜토리얼 과정에서의 오류를 정리합니다.
* 사용자의 요청에 따라 모델을 filter를 해서 보내줍니다.

##  RESTAPI
일단, API는 무엇일까요?
간단히 말해서 API는 어떤 응용프로그램에서 다른 프로그램(OS든, 또다른 응용프로그램이든)을 잘 이용할 수 있도록 만들어놓은 약속입니다. 

이 포스트에서의 `API`는 클라이언트가 요청을 보내면 서버에서 요청에 맞는 ‘데이터’를 보내주는 API를 말합니다.

그러면 REST API는 뭘까요?
제가 이해한 REST API는, **메소드와 자원을 분리해서 적어주는 API**를 말합니다.

예를 들어 어떤 앱에 1번 상품을 가져와야하는 요청을 하는  API를 만든다고 생각해봅시다. 
```
/getProduct/1 
# RESTFUL 하지 않다고 말한다.

GET  /product/1
# RESTFUL 하다고 말한다.
```

즉 HTTP의 기본 메소드인 GET / POST / PUT / DELETE를  사용하여, 
CRUD를 표현하고, URI에는 그 대상이 되는 **자원**을 말해주는 것이죠. 

더 알고싶다면 [여기](http://meetup.toast.com/posts/92)를 참고하세요.


## Django Rest API 서버 튜토리얼  

### Django Rest API 준비 
Django로 Rest API를 만들기 위해서는 다음 두 가지 패키지를 설치해야합니니다.

* djangorestframework
* django-rest-swagger
* django 

다만 2017년 8월 19일 기준으로 
djangorestframework(3.6.3) 는 튜토리얼 상 진행에 문제가 없는데, 
django-rest-swagger(2.1.2) 버전이 깔리면서 문제가 생깁니다. 
2.0 버전 이후로 swagger가 urls를 지원하지 않기 때문입니다. 

조급하게 2.1.2버전을 까셨다면 이렇게 해보세요.

```
# 터미널 혹은 iTerm2에 다음 커맨드를 친다.
pip3 uninstall django-rest-swagger
pip3 install django-rest-swagger==0.3.10
# 0.3.10 버전을 설치한다. 참고로 1.x버전들은 없습니다. 
```

잘 설치됐다면 django와 restframework도 깔아줍시다.

```
pip3 install djangorestframework
# djangorestframework 도 깔아준다. 

pip3 install django
# django 설치 
```

이제 추가로 설정을 하러 갑시다. 

### 프로젝트명/Settings.py

settings.py 의 INSTALLED_APPS에 rest_framework와 rest_framework_swagger을 적용합니다. 

```
# settings.py
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # REST framework
    'rest_framework',

    # REST framework Swagger
    'rest_framework_swagger',
]
```


### 프로젝트명 / urls.py
그리고 urls.py에 각각 rest-api, rest-swagger라는 이름의 url에 대한 설정을 해줍니다.

```
from django.conf.urls import url,include
from django.contrib import admin

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^rest-api/', include('rest_framework.urls')),
    url(r'^rest-swagger/', include('rest_framework_swagger.urls')),
]
```

이 부분에서 rest_framework_swagger 버전이 2.0이 넘는다면 실행되지 않을 수 있습니다.
장고 1.8부터는 patterns를  import할 필요가 없이 바로 쓸 수 있다고하네요. 

### 서버 실행해보기 

```
# 콘솔창에 다음을 입력한다.
python manage.py runserver
```

localhost:8000/ 에 들어가면 page not found가 뜹니다. 
침착하게 localhost:8000/rest-swagger/api-docs를 쳐봅니다. 
이상한 json데이터 가 보이면 성공입니다.

### PostgreSQL을 적용하기

django의 기본 데이터베이스는  sqllite입니다. 
하지만 sqllite로는 django와 Postgre에서 지원하는 [JSONField](https://docs.djangoproject.com/ko/1.11/ref/contrib/postgres/fields/)를 쓸 수가 없습니다.

파이어베이스에서 이전해오는 것이기때문에,
복잡한 json형식의 칼럼들은 그대로 jsonfield를 써서 지원하고 싶었습니다.

모델을 만들러 가기전에 postgreSQL로 갈아끼워봅시다. 
이 [장고걸스 튜토리얼](https://jinpark-dg.gitbooks.io/django-girls-extended-tutorial-korean/content/optional_postgresql_installation/index.html) 을 보면 쉽게 postgreSQL을 설치할 수 있습니다. 
시행착오는 있었지만요. 역시 장고걸스 만만세!

설치 했다면 다음 과정을 따라합니다.

```
# 콘솔에 다음 명령어를 친다. 
psql

# database를 만들자.
CREATE DATABASE mydb;
# CREATE DATABASE <DB이름> 의 포맷

# 접속을 맡을 user를 만들자.
CREATE USER junekim WITH PASSWORD 'password';
# CREATE USER <유저명> WITH PASSWORD <비밀번호> 의 포맷. 

# 인코딩과 Transaction option을 read committed로, UTC-9의 시간대 설정.
ALTER ROLE <유저명> SET client_encoding TO 'utf8';ALTER ROLE <유저명> SET default_transaction_isolation TO 'read committed';ALTER ROLE <유저명> SET timezone TO 'UTC-9';

# 그리고 만든 유저에 모든 권한을 준다. 
GRANT ALL PRIVILEGES ON DATABASE <DB이름> TO <유저명>;

```

여기까지가 PostgreSQL의 설정입니다. 

이제 django에서 쓸 수 있도록 추가 설정을 해봅시다 .

```
# 콘솔을 켜서 설치한다. 
pip3 install psycopg2
# django 에서 postgreSQL을 사용하도록해주는 패키지 
```

이제 프로젝트의 Settings.py를 가서 마지막 설정을 해주어야합니다.

### 프로젝트명/settings.py

settings.py에서 
```
DATABASES = {
    'default': {
         'ENGINE': 'django.db.backends.sqlite3',
         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
     }
 }
```

이렇게 되어있는 부분을 

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': '<DB이름>',
        'USER': '<user이름>',
        'PASSWORD': '<비밀번호>',
        'HOST': 'localhost',
        'PORT': '',
    }
}
```

로 바꿔줍니다. 


