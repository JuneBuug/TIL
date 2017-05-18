# Django Template에서 같은 이름의 form을 view에서 list로 받는 법 

```
a = Request.Post.getlist['이름'] 
```

이 먹히지 않을 때! 방법이다. 어떻게해도 form에서 마지막 것만 가져오던때 
스택오버플로우를 돌아다니며 해결법을 찾아보았다 ㅎ,ㅎ

### templates / html 파일 

```
<tbody>
	<tr v-for="(row,index) in rows" v-bind:key="row.id" v-on:remove="rows.splice(index, 1)">
		<td><input v-model="row.skill" type="text" name="skill" class="form-control" id="skill" placeholder="추가하고 싶은 기술 스택을 적어주세요."></td>
		<td><input v-model="row.degree" input class="form-control" type="number" value="0" name ="skill_degree" id="skill_degree"/></td>
 		<td><button class="btn btn-primary" @click="remove(row,index)" >Remove</button></td>
	</tr>
</tbody>
```

vue.js가 적용되어있어 조금 어지럽긴한데, 어쨌든 각각 skill, skill_degree라는 이름으로 input이 있고, 
추가 버튼을 누를때마다 동일한 row가 작성된다. 
따라서 skill이라는 이름을 가진 input이 1, 2, 3 .. 개 , skill_degree를 가진 input이 1, 2, 3.. 개 가 생긴다. 

### views.py 파일

```
sk = dict(request.POST)['skill']
degree = dict(request.POST)['skill_degree']
#dictionary 타입으로 값을 받는다.
number =0
for s in sk  :
	skill = Skill.objects.create(devstack=s,person= person,degree=degree[number])
  skill.save()
  number+=1

return HttpResponseRedirect(reverse('resume:detail', args=(person.id,)))
```

`dict(request.POST)['form에서 name값']`
이 핵심이다. 

나는 동일한 person 객체를 공유하면서 skill을 세이브 해줘야하는 상황 ( ex ) 김준영이라는 사람이 안드로이드와 장고 개발 스킬을 둘다 가지는  1:N 구조 ) 이었기때문에 
for문을 돌리고 , 반복문이 돌아가는 수를 세어서 스킬에 해당하는 스킬 능숙도도 알맞게 들어가도록했다. 
