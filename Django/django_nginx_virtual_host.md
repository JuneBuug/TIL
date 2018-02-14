# Nginx Virtual Host로 같은 public ip 인스턴스에 서로 다른 도메인 - 장고 앱 연결하기


###  참고
[How To Set Up Nginx Server Blocks (Virtual Hosts) on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04)


[How To Serve Django Applications with uWSGI and Nginx on Ubuntu 16.04 | DigitalOcean](https://www.digitalocean.com/community/tutorials/how-to-serve-django-applications-with-uwsgi-and-nginx-on-ubuntu-16-04)



### 문제상황
기존에는 하나의 인스턴스에서 하나의 django app만 돌리고 있었는데, django app 두개를 하나의 인스턴스에서 배포하고, 각각의 앱은 다른 도메인으로 접근해야하는 일이 생겼다.
여기서는 API 서버 앱을 api.junekim.net 으로, 서비스 서버 앱을 service.junekim.net 으로 배포하는 방법을 소개한다.
<첫번째도메인> 을 api.junekim.net으로, <두번째도메인>을 service.junekim.net으로 생각해주면 된다.


## Nginx Virtual Host 설정

환경은 ubuntu 16.04, AWS ec2이다.
[Django Nginx와 uwsgi로 ubuntu에서 배포하기](https://github.com/JuneBuug/TIL/blob/master/Django/django_nginx_uwsgi_ubuntu_01.md)에서 처럼
Nginx를 설치했다고 가정하겠다.

### 기본 html 폴더 만들기

다음 명령어로 nginx virtual host에 필요한 default html 폴더를 만든다.
```bash
sudo mkdir -p /var/www/<첫번째도메인>/html
sudo mkdir -p /var/www/<두번째도메인>/html
```

이제 만든 html 폴더에 권한을 변경한다. 현재 접속한 유저가 변경할 수있도록 권한을 준다.

```bash
sudo chown -R <유저이름>:<유저이름> /var/www/<첫번째도메인>/html
sudo chown -R <유저이름>:<유저이름> /var/www/<두번째도메인>/html
```

또한 웹 루트 권한을 한번 더 준다.

```bash
sudo chmod -R 755 /var/www
```

### 기본 html 만들기

```bash
vi /var/www/<첫번째도메인>/html/index.html
```

위의 명령어로 기본 index페이지를 만들어준다.
nginx가 나왔을 때 유저가 봤으면 하는 index page를 넣어준다.

나는 다음 샘플을 붙여넣기했다.
```html
<html>
    <head>
	<meta charset='utf-8'>
        <title>[넣고 싶은 제목]</title>
    </head>
    <body>
        <h1><첫번째도메인> 기본 페이지 입니다. </h1>
    </body>
</html>
```

vi를 사용하고 있으므로 esc 연타 후 :wq 로 저장하고 나온다.

같은 방법으로
```bash
vi /var/www/<두번째도메인>/html/index.html
```
에 비슷한 index page를 만들어준다.

### sites-available에 각 서버 블록 파일 만들기

```bash
sudo vi /etc/nginx/sites-available/<첫번째도메인>
```
을 입력한다.

vi 창이 뜨면 다음 스크립트를 입력한다.

```bash
upstream django {
    server unix:/home/<유저명>/<프로젝트명>/run/uwsgi.sock;
}

server {
        listen 80;
        server_name <첫번째도메인> www.<첫번째도메인>;

	      root /var/www/<첫번째도메인>/html;
        location = /favicon.ico { access_log off; log_not_found off; }

        location /static/ {
                root /home/<유저명>/<프로젝트명>;
        }

        location / {
            include         /etc/nginx/uwsgi_params;
            uwsgi_pass      django;
        }
}
```

여기서 프로젝트는, 첫번째 도메인에서 접속하고 싶은 django 앱이 들어있는 프로젝트 폴더를 의미한다.
만약 프로젝트가 /home/<유저명>에 있지 않다면 해당하는 위치를 적어준다.

같은 방법으로

```bash
sudo vi /etc/nginx/sites-available/<두번째도메인>
```
을 입력한다.

vi 창이 뜨면 다음 스크립트를 입력한다.

```bash
upstream django2 {
    server unix:/home/<유저명>/<프로젝트명>/run/uwsgi.sock;
}

server {
        listen 80;
        server_name <두번째도메인> www.<두번째도메인>;

	      root /var/www/<두번째도메인>/html;
        location = /favicon.ico { access_log off; log_not_found off; }

        location /static/ {
                root /home/<유저명>/<프로젝트명>;
        }

        location / {
            include         /etc/nginx/uwsgi_params;
            uwsgi_pass      django2;
        }
}
```

여기서 django는 이전에 한 것과 겹치므로 upstream의 이름을 django2로 바꿔주었다.


이제 site-available에 만든 파일을 site-enabled 폴더에 다음 커맨드로 링크해준다.

```bash
sudo ln -s /etc/nginx/sites-available/<첫번째도메인> /etc/nginx/site-enabled
sudo ln -s /etc/nginx/sites-available/<두번째도메인> /etc/nginx/site-enabled

```

### nginx.conf 설정해주기

```bash
sudo vi /etc/nginx/nginx.conf
```

로 파일을 열고

```bash
http {
    . . .

    server_names_hash_bucket_size 64;

    . . .
}
```

server_names_hash_bucket_size 64; 앞에 있는 주석표시 # 를 지워준다.
`esc + :wq` 로 저장하고 닫기.
