# gitignore이 적용되지 않는 문제 

## gitignore만들기 
* .gitignore파일을 만든다.
* github에 올라가지 않았으면 하는 파일들을 적어준다.
ex) 
```
db.sqlite3
manage.py
.env
```
* git push 한다.

## 이 과정을 거쳤는데 적용되지 않을 때 
다음의 코드를 차분히 입력한다 
```
git rm -r --cached .
#cached된 파일들을 모두 삭제하는 코드로 보임
git add .
# 해당 디렉토리의 파일을 모두 추가 
git commit -m "추적 안된 파일들 변경/추가"
# 커밋한다. 
git push
# 푸시한다. 그러면 적용 끝! 
```