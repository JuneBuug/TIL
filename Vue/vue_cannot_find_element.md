# Vue.js cannot find element 문제
[Vue warn]: Cannot find element: foo 가 뜰때가 있다. 
이 문제는 타겟이 되는 DOM이 로딩되기 전에 스크립트가 실행되기때문이라고 한다. 
따라서 DOM 로딩 이후에 스크립트가 실행되도록해주면 되겠다.

### 이럴 때의 해결법 1
```
window.onload = function () {
	#Vue 코드를 넣는다 
}

#example

<script>
  window.onload = function(){
    var app  = new Vue({
    el: "#app",
    data: {
      rows: [
        {name: "James Bond",job: "spy"},
        {name: "Goldfinger", job: "villain"}
      ]
    },
    methods:{
      addRow: function(){
        this.rows.push({name:"",job:""});
      },
      removeRow: function(row){
        this.rows.$remove(row);
      },
    }
  });
  }
</script>

```