# Vue Uncaught SyntaxError: Invalid shorthand property initializer

같은 코드를 복사해서 조금 바꿨을 뿐인데 콘솔에서 
Syntax 에러를 뿌렸다. 

```
#templates 의 html 파일

<script>
  window.onload = function(){
    var app  = new Vue({
    el: "#bpp",
    data: {
      rows: [
        { startDate: "2017-05-21",endDate: "2017-05-21",title= "경력",desc= "경력입니다" },
# 이 부분이 문제였다. :와 =를 혼용해서 쓴 것. 
      ]
    },
    methods:{
      addRow2: function(event){
        if(event) event.preventDefault();
        this.rows.push({startDate: "",endDate: "",title:"",desc:""});
      },
      remove2: function(row,index){
        if(event) event.preventDefault();
        this.rows.splice(index,1)
      },
    }
    });
}
</script>

```

새벽 코딩을 할 때는 문법을 혼용해서 쓰지않도록 유의하자. :와 = ! 
