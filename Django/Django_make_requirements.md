# Virtualenv 에서 requirements.txt 만들기
```
source myvenv/bin/activate
# 가상환경을 실행시킨다.

pip freeze > requirements.txt
#가상환경에 설치된 package 등의 리스트를 requirements.txt라는 파일에 export한다.

# 새 컴퓨터에 새로운 가상환경을 설정하고 실행한다. 
# 이후 다음의 코드를 실행한다.
pip install -r requirements.txt

```

Reference : [Python in Real World: virtualenv를 사용하자 - 가상 개발환경 구축하기](http://pythoninreal.blogspot.kr/2013/12/virtualenv.html?m=1)