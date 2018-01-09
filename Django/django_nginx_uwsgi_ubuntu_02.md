# Django + Postgresql + Nginx + uwsgi + Ubuntu 16.04 + Amazon ec2 설정하기 2편



## 다른 ec2-instance에 PostgreSQL를 설치해서 연결하기

먼저 Django 어플리케이션이 있는 instance를 inst-Django라고 하자.

PostgreSQL 가 있는 instance 를 inst-Postgre 라고 하자.

inst-Postgre는 인터넷에서 접근할 수 없어야한다. 누구나 접근한다면 DB의 보안이 보장되지 않기 때문이다.

오직 inst-Django를 통해서만 데이터를 받을 수 있어야한다.

그러므로 inst-Postgre는 PostgreSQL의 전용포트인 5432포트와 ssh 접속 포트만 열어두기로 한다.

5432는 inst-Django의 privateIP 혹은 inst-Django가 포함된 보안 그룹에만 열려있어야한다.

ssh는 일단 0.0.0.0/0 에 대해서 열어둔다.

###  inst-Django에서의 설정


```python
# prod.py
import os
path = os.path.join(BASE_DIR, 'envs.json')

with open(path) as f :
  dict = json.load(f)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': dict["DB_NAME"],
        'USER': dict["DB_USER_NAME"],
        'PASSWORD': dict["DB_PASSWORD"],
        'HOST': dict["DB_HOST"],
        'PORT': '5432',
    }
}
```

```
# envs.json
{
  "DB_NAME" : "<DB이름>",
  "DB_USER_NAME" : "<DBuser이름>",
  "DB_PASSWORD" : "<DB비밀번호>",
  "DB_HOST": "<DB가설치된서버PrivateIP주소>"
}

```

inst-Django와 inst-Postgre는 일단 같은 subnet 내에 있다.

그래서 privateIP로 서로 접근이 가능하고, inst-Postgre가 인터넷 포트를 열지않고 inst-Django의 요청을 받을 수 있다 (5432포트로)

그런데 나는 `DB_HOST` 값을 inst-Postgre의 public ip로 설정했다.

publicIP로 설정할 경우, inst-Postgre의 보안그룹 inbound 규칙을 5432 - 0.0.0.0/0 으로 설정하지 않으면 DB 접근이 불가능했다.

privateIP 설정할 경우 inst-Postgre의 보안그룹 inbound 규칙을 5432 - inst-Django의 보안그룹 OR inst-Django의 privateIP (혹은 CIDR) 으로 설정하여 제한할 수 있고, 보안이 강화된다.


### inst-Postgre에서의 설정

추가적인 설정이 필요하다.

```bash
sudo vi /etc/postgresql/<postgresql버전>/main/pg_hba.conf
```

을 열고 마지막에

```bash
host all all 0.0.0.0/0 md5
```
를 추가한다.


```bash
sudo vi /etc/postgresql/<postgresql버전>/main/postgresql.conf
```
를 열고 connection settings 부분에

```bash
listen_addresses = '*'
```
를 추가한다.


### 이렇게 갈아끼우고 나면

```
sudo systemctl restart uwsgi.service
# uwsgi를 재시작한다
```

이렇게 해야 DB설정이 제대로 된다.
