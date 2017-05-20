# Django Template문법의 한계-args가 있는 문법 
장고 템플릿 안에서 order_by(‘모델필드’) 를 하다가 다음과 같은 사실을 발견했다. 

The template language only supports calling methods without 
arguments, and in that case the () aren't needed. 
즉, 템플릿 문법 내에서는 인자가 있는 메소드를 부를 수 없다는 것이다. 

### 문제 상황 
person 라는 객체 안에 1:N으로 매핑된 experience_set을 불러와, 그 안의 startDate라는 날짜 기준으로 desc하게 정렬해서 받고싶었다. 

첫번째 시도는 다음과 같았다. 
```
#resume_detail.py
<% for ex in person.experience_set.order_by('-startDate')%>
#그냥 'startDate'라고 쓰면 asc, '-startDate'하면 desc 하게 정렬된다.
#중략 
<% endfor%>
```

여기에서 order_by는 **인자가 있는** 메소드이기 때문에 호출이 불가능하고, 따라서 
**Could not parse the remainder** 에러를 뿜게 된다. 

### 해결법
그래서 결국 애초에 views.py에서 던져주는 객체를 하나 더 두기로 했다. 
```
#views.py
def resume_detail(request,resume_id):
    person = Person.objects.get(id=resume_id)
    experience = person.experience_set.order_by('-startDate')
    return render(request,'resume_prac/resume_detail.html',{'person':person,'experience':experience})
```

해결!