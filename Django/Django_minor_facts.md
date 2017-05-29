# Django 사소한 facts

### DateField와 form의 type=date 일때
모델에서 datetimefield로 하면 변환 엄청 많이 해줘야한다.
시간 쓸거 아니라면, 맘 편히 datefield로 쓰자.
그러면 form tag 쪽에서 type=date로 했을 때 바로 받아진다. timezone 상관없이!

### Files가 있는지 없는지 체크하는 방법
 이미지 업로드가 없을 때 와 있을 때 분기를 치는 방법이다.

```
# 기존 코드
profile = request.FILES['profile_image']
# files에 profile_image를 받아와서 저장한다. 하지만 profile_image로 넘어온게 없다면 안됨.

#개선된 코드
if 'profile_image' in request.FILES :
            profile = request.FILES['profile_image']
            person = Person.objects.create(person_name=name,position=position,profile_image=profile,person_desc=intro,person_oneline=oneline)
            person.save()
# profile_image라는 항목이 request.FILES에 있는지 검사한다. 그리고 분기를 쳐서 있으면 저장, 없으면 저장하지않는다.
        else :
            person = Person.objects.create(person_name=name,position=position,person_desc=intro,person_oneline=oneline)
            person.save()
```


### 'RelatedManager' object is not iterable 에러

침착하게 for 문에서 ~.all()을 붙였는지 확인해봐라.
