# # Django로 REST API 서버 구축 튜토리얼 따라가기 2편
이 포스트는 [장고걸스튜토리얼](https://tutorial.djangogirls.org/ko/) 정도의 Django 이해도를 가진 상태의 사람(=저)를 대상으로 합니다. 
환경
* OS X 10.12.5,
* pycharm Professional 2017.2 
* python 3.4
* django 1.11.4 

또한 기본적으로 [PyCharm과 함께 DJango와 RestFramework를 활용한 웹 사이트 구축하기 – DevIssue](https://devissue.wordpress.com/2015/02/01/pycharm%EA%B3%BC-%ED%95%A8%EA%BB%98-django%EC%99%80-restframework%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EC%9B%B9-%EC%82%AC%EC%9D%B4%ED%8A%B8-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0/) 다음 포스트 글을 따라하며 생긴 오류들을 정리합니다.
- - - -


## 앱과 모델 만들기 
전 편을 잘 따라오셨다면 이제 실제 보내줄 데이터 구조를 만들어줄 차례입니다.
먼저 다음과 같은 명령어를 입력해서 앱을 만들어봅시다.

```
$ python manage.py startapp <앱이름>
# python manage.py startapp cs 와 같이 쓴다.
```

짜잔! 앱이 만들어졌습니다. 
저는 여기서 cs라는 이름의 앱을 만들었습니다.
이제 models.py를 볼까요. 

저는 postgreSQL을 사용했기때문에, JSONfield를 사용할 수 있습니다.
다음과 같이 상품 모델을 만들어줄게요. 

```
# cs/models.py
from django.db import models
from django.contrib.postgres.fields import JSONField

# 앱 모델 만들기
# Product RDB로 구성



class Product(models.Model) :
    name = models.CharField(max_length=256)  # 상품이름
    img_url = models.CharField(max_length=2048)  # 상품 이미지 url
    brand = models.CharField(max_length=128)  # 브랜드 이름
    category = models.CharField(max_length=128)  # 카테고리이름
    data = JSONField()  # event 정보

```

JSONField가 보이시나요?
다른 항목들은 모두 장고의 기본 데이터베이스인 sqlite 가 지원하는 필드입니다.
하지만 Jsonfield는 그렇지 않아요. 
그래서 postgreSQL를 써주었죠.
data항목에는 이벤트 정보를 적어줄것인데,
```
{
 	"event":	"1+1"
}
```
이라는 정보가 들어갈거에요. 나중에 확장 가능성이 있어서 json을 선택했습니다.

이제 만들어진 앱(여기서는 cs)를 등록해볼까요.
다시 프로젝트 하위 폴더의 settings.py로 갑니다.

```
# 프로젝트명 / settings.py
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
이렇게 INSTALLED_APPS 항목의 마지막에 
```
# 프로젝트명 / settings.py
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

    # 편리해 앱

    'cs',

]
```
만든 앱이름을 추가해줍니다.

이제 만든 모델을 실제 장고에 적용할 시간입니다. 
언제나 모델을 장고에 적용할 때는 두가지 명령어가 필요합니다.
`makemigrations` 와 `migrate` 입니다. 
models.py의 구조가 변경되면 다시 적용해야하는 명령어에요.
```
# 터미널에 친다.
python manage.py makemigrations
python manage.py migrate
```

makemigrations는 현재 모델이 어떻게 생겼는지 스냅샷을 찍는 과정이고,
migrate는 그 스냅샷을 실제로 적용하는 과정정도로 보면 될것같아요.

별 문제가 없다면 Ok가 뜨고 종료됩니다. 
다음 명령어를 적용해서 Product모델이 만들어졌는지 확인해보죠.

```
# 터미널에 친다.
python manage.py shell

$ from cs.models import Product
$ Product.objects.all() # 빈 리스트가 반환됨
$ Product.objects.create(name="곡물우유",data={ "event" : "1+1"})
# Product object하나가 반환됨.
```

이렇게 하면 모델 만들기는 성공입니다!

## 만든 모델을 가지고 API View 페이지 만들기 
기본적으로 views.py는 컨트롤러 역할을 하는 파일입니다.
기본적인 view만들기는 이 글에서 참고하고 있는 링크에서 따라해보세요.
바로 api 페이지 만들기로 넘어가겠습니다.

프로젝트의 urls.py로 이동합니다.
api/product/라는 url로 이동하면 모든 Product를 출력하는 예제를 만들거에요.

```
# 프로젝트 /urls.py

from django.conf.urls import url,include
from django.contrib import admin
from cs.views import product_api
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^rest-api/', include('rest_framework.urls')),
    url(r'^rest-swagger/', include('rest_framework_swagger.urls')),

    # REST API
    url(r'^api/product/',product_api.as_view()),
]

```

다음과 같이 api/product/ url을 등록해줍니다.

이제는 cs앱의 views.py로 이동합니다.
저기에 적힌 product_api라는 class를 만들어주어야해요.

```
# cs/views.py

from django.http import HttpResponse
from .models import Product
from rest_framework import serializers,mixins
from rest_framework.generics import GenericAPIView

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ('name','img_url','brand','category','data')

class product_api(GenericAPIView, mixins.ListModelMixin):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer

    def get(self,request,*args,**kwargs):
        return self.list(request,*args,**kwargs)
```

다음과 같이 추가해줍니다.
링크의 설명을 빌리겠습니다.
> GenericAPIView를 상속하면, 기본적인 API페이지가 나오는 뷰를 만들어줍니다. 또한 모델들의 List로 반환하기 위해서 mixins도 상속합니다.  
> 그 아래, queryset은 어떤 모델들을 보여줄 것인가를 알려줍니다.  
> Serializer 는 REST 로 데이터를 주고 받을 때, 모델을 어떻게 주고 받을 것인가를 정의하기 위한 클래스 입니다. 저희는 데이터 모델 그 자체를 주고 받을 것 이니, 기본적으로 모델 전체를 자동으로 변환해주는 ModelSerializer 에 힘을 빌릴겁니다.  

다만 튜토리얼과는 달리 Serializer의 설정이 바뀌어서
Meta설정에 fields 항목이 들어는데요.
fields안에는 Product를 설정할때 사용했던 필드들의 이름이 들어갑니다. 

class안에는 함수로 get요청에 대한 정의를 구현해줍니다.
다시 한번 링크 설명을 인용합니다.

> ListModelMixin은 GeneicAPIView에 queryset과 serializer_class를 기반으로 하여 데이터 List를 만들어주는 기능을 합니다. 먼저 get 을 정의해 봅시다. 기본적으로 REST Framework에서는 request, *args, **kwargs를 반드시 포함해서 처리하게 되어 있습니다. 기본적으로 온 요청에 대한 Parsing 작업을 하여 Request를 생성하고, 그 외에 여러 데이터는 *args와 **kwargs에 포함하여 오는 형태 입니다.  

즉, 클라이언트에서 product를 요청하면서 인자를 더 던져줄때가 있습니다. 
1번 Product만 주세요,
혹은 이런 이름의 Product를 주세요, 하는 식으로 번호나 이름을 줍니다.
그런 것들은 args와 kwargs에 담겨서 처리가 된다는 것입니다. 

get함수에서 self.list를 호출하면 queryset에서 설정해준 Product들이 list형태로 들어갑니다. 

이제 모두 끝났습니다. 

```
python manage.py runserver
```

를 실행해서 확인해봅시다. 

![rest_api](resapi.png)
잘 나오네요!

## 추가 : Admin페이지에서 models관리하기

위에 나온 정보들은 admin페이지에서 Product에 추가해준 정보들입니다.
매번 
```
Product.objects.create
```
를 사용할수는 없으니까요. 

admin페이지를 사용하려면, 

```
# 터미널을 사용한다.
python manage.py createsuperuser
```

를 통해서 super user를 생성합니다.

이제 cs/admin.py로 갑니다.

```
# cs/admin.py

from django.contrib import admin
from .models import Product
# Register your models here.

admin.site.register(Product)
```

다음 코드를 추가해서 admin페이지에서 Product모델을 관리해보도록합시다. 

이제 서버를 돌리고, /admin페이지로 가서 만들었던 super user로 로그인합니다.
그러면 Product모델을 편리하게 관리할 수 있습니다.