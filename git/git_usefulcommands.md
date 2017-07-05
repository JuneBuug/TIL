## 알아두면 유용한 깃 커맨드


```
git init
# 깃 저장소를 만듭니다.

git add .  / git add [폴더/파일이름]
# 모든 파일을 커밋예정본에 추가합니다. / 해당 파일이나 폴더만 커밋예정본에 추가합니다.

git remote add origin [깃저장소주소]
# remote를 해당 깃 저장소로 설정합니다.

git push origin master
# remote저장소에 처음 푸시할 때는 upstream이 없어서 이렇게 push해줘야합니다. origin의 master 브랜치에 푸시합니다.

git reset HEAD~1
# 한 단계 전 커밋으로 돌립니다. 이때 커밋한 작업 코드은 남겨둡니다.

git reset --hard HEAD~1
# 빡세게(?) 한 단계 전 커밋으로 돌립니다. 이때 커밋 코드를 남겨두지 않습니다.

git rm --cached <파일명>
# add한 파일을 되돌립니다.


# 다른 노트북을 쓰게 될 때 git 안깔고 author / mail 설정
# 다른 노트북을 쓰게 되면 해당 컴퓨터의 username으로 자동 설정된다. 그걸 바꾸는 방법

git config --global user.name "깃헙유저네임"
git config --global user.email 깃헙@이메일주소.com
# 이를 명시적으로 설정해준 뒤에
git commit --amend --reset-author
# 방금 전 커밋의 author를 바꿔준다.
```
