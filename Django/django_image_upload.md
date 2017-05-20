# Django에서 파일업로드 받아서 저장하는 법

```
#views.py

profile = request.FILES['profile_image']
#파일을 받아올수있음
```

```
#resume_write.py
 <div class="form-group">
    <label for="profile_image">사진 업로드</label>
    <input id="profile_image" type="file" class="form-control" name="profile_image">
 </div>
```

아마도 여러개가 되면 dict로 돌리면 될 걸로 보인다. 