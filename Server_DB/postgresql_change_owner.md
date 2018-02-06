# Postgresql owner 권한 양도하기

## 문제 상황

그동안 DB에 접근하던 test계정을 실제 DB를 관리할 계정으로 바꾸었다.
```bash
GRANT ALL PRIVILEGES ON DATEABASE <db이름> TO <실제role>
```

을 했음에도 불구하고 DB가 접근이 안됐다.

psql로 포스트그레스큐엘에 접속해보니 정작 relation의 owner 가 변경 되지 않았다.

## 해결방법

기존 owner가 가지고 있는 권리를 모두 양도해주는 커맨드를 찾았다.

```bash
REASSIGN OWNED BY <이전role> [, ...] TO <새로운role>
```

아마 [] 괄호 안에 있는 걸 정해주면 그 오브젝트만 재할당해주는 것 같고,

실제 커맨드로
```bash
REASSIGN OWNED BY old_role TO new_role
```

라고 쓰니 모든 권한이 양도되었다. 해결 끝! 
