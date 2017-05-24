# Stack 

**먼저 들어간 것이 나중에 나온다! LIFO(Last In, First Out) **

## ADT 

```
void StackInit(Stack *pstack);
# 스택 초기화

int SIsEmpty(Stack * pstack);
# 스택이 빈 경우 1, 아닌 경우 0 

void SPush(Stack * pstack, Data data);
# 스택에 데이터를 저장한다.

Data SPop(Stack * pstack);
# 마지막에 저장된 요소를 삭제하고 반환한다. (데이터가 하나 이상 존재해야함)

Data SPeek(Stack *pstack);
# 마지막 요소를 반환하되 삭제하지 않는다. (상동)
```

## 배열로 할 것인가, 연결 리스트로 할 것인가?

### 배열로 할 때 수도 코드 

```
스택 길이 만큼의 배열과 topIndex가 필요하다

아무것도 없을땐 topIndex가 -1 이라고 가정하자.

push를 하면 순서대로 0부터 차례차례 채워지고 topIndex++, pop을하면 topIndex(저장된게 있는 마지막 인덱스)--

당연히 isEmpty는 topIndex만 보고 판단하믄 되징
```

### 연결 리스트로 할 때 수도 코드 (head에만 붙이는 단순 연결 리스트랑 동일)
```
node 구조체에는 당연히 data랑 다음 가리키는 것. 

stack 구조체에는 node * head; 

이 head는 초기화할때 null이 된다 ~.~ empty일때도 당연히 null이구. 
push하면 걔가 head가 되고, pop하면 head가 튀어나온다.

push 할때는 새 노드를 만들고, 데이터를 넣고, 새 노드의 다음 노드를 현재 head로 설정함! 
그다음에 head 포인터를 새로운 노드로 만들어준다. 

pop 할때는 isEmpty를 검사하구 
현재 head인 data를 반환하고! next 로 설정되어있던 애를 head로 해줌! 
즉 삭제할 데이터는 pstack -> head -> data 이고 
삭제할 노드는 pstack->head
따로 저장해준 다음 
pstack->head 를 pstack->head->next로 바꿔줌 ! 

```
