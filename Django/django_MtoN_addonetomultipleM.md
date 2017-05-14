# Django M:N 모델에서 N개쪽 하나의 object를 M개에 모두 할당하기 
예시 : lalaland라는 태그를 “la la”가 포함된 video에 모두 붙여주기 
django_tube 앱 기준 

```
source (가상환경이름)/bin/activate
# 침착하게 가상환경 활성화 
python manage.py shell 
# shell 활성화 ,QuerySet으로 CRUD 가능하도록 준비 
from video.models import Video, Tag 
# video앱의 모델에서 Video / Tag 임포트 
v= Video.objects.filter(title__icontains="la la") 
# "la la"라는 스트링을 포함한 title을 가진 video만 골라내기 
t= Tag.objects.get(name='lalaland') 
# 주의할점은 v는 list로 뽑아야하지만 t는 object 하나로만 뽑아야함 
t.video_set.add(*v)
# t.video_set은 t라는 태그가 달린 모든 video_set. 거기에 *v라고 넣어서 추가 
t.video_set.all()
# 이걸 호출해서 확인해본다. 
```

featured by 갓명서님 