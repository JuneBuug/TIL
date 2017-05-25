#Django 템플릿으로 모듈화 하기 

## header 파일 만들고 import 하기 

장고걸스 튜토리얼에도 나와있는 내용이다. 하지만 완성하는데 급급했던 나머지 나는 그냥 넘기구 말았던 것이구 재 검색... 

```
{% load staticfiles %}

<html>
<head>
    <title>ResumeList</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
  <script src="https://unpkg.com/vue"></script>

</head>

<nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse fixed-top">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <a class="navbar-brand" href="/resume">MYR</a>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/resume">전체보기 <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link btn btn-outline-success my-2 my-sm-0" href="/resume/write">추가하기</a>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0" action="{% url 'resume:search' %}" method="get" accept-charset="utf-8">
       <input class="form-control mr-sm-2 searchfield" id="searchbox" name="q" type="text" placeholder="이름으로 검색하세요">
       <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
     </form>
      </div>
    </nav>

    <div class="container" style="margin-top:100px">
      <div class="starter-template">
        {% for resume in resume_list %}
            <a href="/resume/{{resume.id}}">
                <h5 style="margin-top:20px"> <span class="badge badge-primary">{{resume.position}}</span> {{ resume.person_name }}의 Resume</h5>
            </a>
        {% endfor %}
      </div>
    </div>


</body>
</html>

```

위의 코드에서 <nav></nav> 에 해당하는 파일이 4개의 html에 공통적으로 들어가 있었고, 이것을 빼내 보기로 한다. 

header.html 이라는 이름으로 해당 코드를 작성한다. 

```
{% load staticfiles %}


<head>
  {% block title %}{% endblock %}
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="{% static "resume_prac/detail.css" %}">
  <script src="https://unpkg.com/vue"></script>
  <script src="https://use.fontawesome.com/b508397298.js"></script>
</head>


<body>
<nav class="navbar navbar-toggleable-md navbar-inverse bg-inverse fixed-top">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <a class="navbar-brand" href="/resume">MYR</a>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="/resume">전체보기 <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link btn btn-outline-success my-2 my-sm-0" href="/resume/write">추가하기</a>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0" action="{% url 'resume:search' %}" method="get" accept-charset="utf-8">
       <input class="form-control mr-sm-2 searchfield" id="searchbox" name="q" type="text" placeholder="이름으로 검색하세요">
       <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
     </form>
      </div>
    </nav>
{% block content %}
{% endblock %}

</body>

```

```
{% block content%} 
{% endblock %}

```
이라는 커맨드를 기준으로 위는 헤더로, 아래는 footer로 들어간다. 

또한 {% block title %} 이라는 커맨드를 사용하면 default title도 설정해 줄 수 있다. 


그러면 이 header가 들어가야 할 html 에는 

```
{% extends "resume_prac/header.html" %}
# 최상단 

{% block content %}
# 헤더를 제외한 html 내용이 들어간다 
{% endblock %}
```

## 주의할 점 
* header.html 를 extend 해서 그런지 head 부분에 있는 js나 부트스트랩, css 임포트 부분이 적용되지 않는다. 사용할꺼면 일단 header.html에 다 넣어주도록 하자. 

* 각 페이지마다 타이틀을 설정하는 것도 다르다. 해당 페이지에 아래 코드를 넣어주면 각 페이지마다 타이틀을 다르게 설정 가능

```
{% block title %} <title>{{ person.person_name }} </title> {% endblock %}
# person.person_name 대신 어떤게 들어가도 좋다. 
```

