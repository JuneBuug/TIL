# Django와 Vue에서 템플릿변수 delimiter가 겹치는 문제
django와 Vue에서는 기본 템플릿변수를 표현할때 
{{ var }} 라는 구조를 사용한다. 
따라서 나같이 vue.js를 멋도 모르고 장고에 넣어보려는 사람은 매우 당황할 수도 있다. 
장고가 {{ message }} 라고 된, vue에 사용될 delimiter도 자신의 것으로 해석해버리기때문이다.

이에 두 가지 해결법을 적어보고자한다. 

### Vue에서 delimiter를 설정해주는 방법 [권장, not tested]
[Vue.js](https://vuejs.org/v2/api/#delimiters)

### Django에서 예외처리를 해주는 방법 
{% verbatim   %} 
   {{ message }}
    {% endverbatim  %}
위와 같이 {% verbatim %} 문법 사이에 vue 태그를 넣으면 잘 인식하게 된다. 
하지만 vue를 사용하게 될 태그가 얼마나 있을지도 의문인 기획단계에서 저런식으로 예외처리를 해주는 것은 코드 낭비일것이라구 생각된다. 