# postgreSQL backup 하는 법

backup파일을 만드는 명령어는 공통적으로 `pg_dump`이다.

```bash
pg_dump -h <host주소> -U <db유저네임> -d <db이름> > <export할 파일이름>
```

이때 -W 옵션을 다음과 같이 추가하여 쓰면

```bash
pg_dump -h <host주소> -U <db유저네임> -W -d <db이름> > <export할 파일이름>
```

```bash
Password :  
```

라고 비밀번호를 요구한다. 이 비밀번호는 db유저의 비밀번호이다.


그런데 backup에는 두가지 방법이 있다.

-Fc 옵션을 쓰는 것과 안쓰는 것.

1. -Fc 옵션을 쓰지않을 경우

```bash
pg_dump -h <host주소> -U <db유저네임> -W -d <db이름> > <export할 백업 파일이름>
```

위에서 사용한 예와 같이 사용하는 것을 말한다.

이 경우 default로 -Fp가 실행이 되며 백업파일이 plain-text SQL script file로 저장이 된다.
`psql` 명령어가 읽을 수 있는 형태가 된다.

나중에 restore할 때 (내가 아는 한) psql로는 내용만 덮어쓸 수가 없다.
해당 db를
```bash
# db 서버에서
DROP DATABASE <db이름>;
CREATE DATABASE <db이름>;
```
과정을 거쳐야지만 psql로 restore할 수 있다.

psql로 restore하는 명령어는

```bash
psql -h <host주소> -U <db유저네임> -W -d <db이름> < <import할 백업파일이름>
```


2. -Fc 옵션을 쓸 경우

```bash
pg_dump -h <host주소> -U <db유저네임> -W -d <db이름> > <export할 백업 파일이름>
```

와 같이 쓰는 것을 말한다. 이 경우 -Fc(File의 형태가 custom이 된다는 뜻) 이므로, 파일이 non-text file이 되고
`pg_restore` 명령어가 읽을 수 있는 형태가 된다.

pg_restore 역시 psql과 동일하게 restore를 하지만, 특정 옵션을 주면 스키마 재생성 과정 없이 내용만 덮어쓸 수있다.
백업 파일과 같은 스키마를 가졌다는 가정하에

```bash
pg_restore -h <host주소> -U <db유저네임>-Wa -d <db이름> < <import할 백업 파일이름>
```

하면 백업파일의 내용만 `overwrite` 할 수 있다.
