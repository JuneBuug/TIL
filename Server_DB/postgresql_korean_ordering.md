# Postgresql 한글 정렬


## 참고
[postgresql 을 재설치하고 재설정 하는 방법](https://ansuchan.com/postgresql-korean-order/)


## postgresql를 삭제하지 않고 노가다로 해결하는 방법

기본적으로 PostgreSQL의 collate를 "C" 로 바꿔주면 가능한데

테이블이나 Database 자체의 collate 를 바꾸는 방법은 공식 문서에 나와있지 않고,

칼럼의 collate를 바꾸는 것은 가능하다.

```bash
ALTER TABLE <테이블이름> ALTER COLUMN <칼럼이름> SET DATA type <칼럼의 데이터 타입> COLLATE "C";
```
