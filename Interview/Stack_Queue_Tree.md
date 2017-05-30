## Stack

```
push()
# 푸시(넣기)

peek()
# 안빼고 맨 위에것을 조회

pop()
# 팝(빼기)

empty()
# 비었는지 검사하기

```

### 배열로 stack 구현하기

```
public class MyArrayStack{
  private int[] data = new int[100];
  private int topIndex = -1;

  public void push(int i){

    if(data.length == topIndex-1){
      int[] oldData = data;
      data = new int[data.length*2];
      System.arraycopy(oldData,0,data,0,oldData.length);
      //시스템 함수, 아니면  forloop
    }
     topIndex++;
     data[topIndex] = i;
  }

  public int pop(){
    if(topIndex<0)
      throw RuntimeException("반환할게 없습니당");
    return data[topIndex--];
  }
}
```


### ArrayList로 stack 구현하기

```
import java.util.ArrayList;
import java.util.List;

public class MyListStack<T>{
  private List<T> list;

  public MyListStack(){
    list = new ArrayList();
  }

  public void push(T i){
    list.add(i);
  }

  public T pop(){
    return list.remove(list.size()-1);
  }
}

```

### Stack으로 회문 판단하기
너무 많이 출제됨
길이 절반을 넣고 pop하면서 비교

```
import java.util.Stack;

public class PandlindromChecker {

  public static boolean isPanlindrome(String s){
    Stack<Character> stack = new Stack<Character>();
    int len = s.length();

    for(int i=0;i<len/2;i++){
       stack.push(s.charAt(i));  // 굳이 toCharArray 안써도 될듯
    }

    //홀수 정수 처리 한번에 !
    for(int i=(len+1)/2; i<len; i++){
      if(stack.pop().equals(s.charAt(i)){
         contiue;
      }else{
        return false;
      }
    }

    return true;
  }
}

```

### Stack min함수 O(1)에 구현하기

```
import java.util.Stack;

public class MyStack{
  private Stack<Integer> stack;
  private Stack<Integer> minStack;

  public MyStack() {
		// Todo
		stack = new Stack<Integer>();
		minStack = new Stack<Integer>();
	}

	public void push(int newVal) {
	    // ToDo

      if(minStack.empty()|| newVal<=minStack.peek()){
        //위 부등호를 안넣어주면 안됨
        minStack.push(newVal);
      }

	    stack.push(newVal);

	}

	public int pop() {
		// ToDo
		int val = stack.pop();

    if(!minStack.isEmpty() && val == minStack.peek()){
        minStack.pop(); //최솟값이 여러개가 같을수있음
    }
	}

	public int min() {
	    // ToDo
      if (minStack.empty())
        return Integer.maxValue();
      else
	     return minStack.peek();
	}
}
```


## Queue

* 자바 유틸에 있는 Queue는 class가 아니고 interface임

```
add()
# 추가

offer()
# 추가 실패할때 false던져줌

remove()
# 반환

poll ()
# 반환 실패시 null 던져줌

element()
# 제거 없이 읽기

peek()
# 제거없이 읽기 실패시 null 던져줌

```

* 인터페이스기때문에 Queue q = new LinkedList(); (대표적인 구현체)
* 선입선출


### 스택으로 큐 순서 뒤집기

```
import java.util.Queue;
import java.util.Stack;

public class ReverseQueue<T> {
    public Queue reverse(Queue<T> q){
        // ToDo

        Stack<T> stack = new Stack<T>();
        while(q.peek()!=null){
            stack.push(q.poll());
        }

        while(!stack.isEmpty()){
            q.add(stack.pop());
        }

        return q;
    }
}
```

* 비어있을 때 예외처리 안해줬음 .


### 두개의 스택으로 큐 구현하기
```
import java.util.Stack;

public class MyQueue<T>{

  Stack<T> s1;
  Stack<T> s2;

  public MyQueue(){
      s1 = new Stack<T>();
      s2 = new Stack<T>();
  }

  public void offer(T.element){
    s1.push(element);
  }

  public T poll(){

    if(s2.isEmpty()){
      while(!s1.isEmpty())
        s2.push(s1.pop());
    }
    return s2.pop();
  }

  public int size(){
    return s1.size() + s2.size();
  }

}

```
size() 함수 쓸 수 있는걸 몰랐음



## Tree와 Graph

BinaryTree와 일반트리
binary는 자식이 두개 뿐 / 나머지는 List로 가질수있겠음

```
Class BinaryTreeNode{
  int data;
  BinaryTreeNode leftChild;
  BinaryTreeNode rightChild;
}

Class TreeNode{
  int data;
  List<TreeNode> children;
}

```

* 이진트리이면 이진 탐색 트리인지 확인하자
이진 탐색 트리는 왼쪽 자식 노드가 부모 노드보다 작고, 오른쪽 자식 노드가 부모노드보다 큰 트리임.
* BFS, DFS 정도는 알아두자
* Tree balance 맞춰주는건 출제 빈도가 낮다
* 균형잡힌 트리인 경우 검색은 O(log n)


그래프.
Graph와 Tree의 차이점?
Tree는 Graph인데 cycle이 허용되지 않는 것임.


### BinaryTree에서 최대값 찾기
전혀 모르겠어서 걍 넘겼음
```
public class BinaryTreeHandler(){

  //recursive하게 해도될거같음. 왼쪽 트리 오른쪽트리해서
  public static int getMax(Node root){
    if(root==null){
        return Integer.MIN_VALUE;
    }

    int leftMax = getMax(root.left);
    int rightMax = getMax(root.right);
    int childMax = Math.max(leftMax,rightMax);

    return Math.max(childMax,root);
  }
}

```

### BinaryTree Balance가 맞는지?
(모든 자식들의 높이 차이 1허용, 2안됨)

```
 public class BinaryTreeHandler(){
  public static boolean isBalanced(Node root){
      return isBalancedHelper(root) != -1;
  }

  private static int isBalancedHelper(Node n){
    if(n==null){
      return 0;
    }

    int l = isBalancedHelper(n.left);
    if(l==-1){
      return -1;
    }
    int r = isBalancedHelper(n.right);
    if(r==-1){
      return -1;
    }

    int diff = Math.abs(r-1);

    if(diff>1){
      return -1;
    }
    return Math.max(l,r) + 1;
  }
 }

```


### 오름차순 정렬된 배열을 BinarySearchTree로 바꿔야함

```
public class BSTBuilder(){
  public static Node build(int[] a){
     // 반을 쪼개서 가운데는 루트로. 재귀 호출 너무 좋음. 범위가 있고.
      return buildRec(a,0,a.length-1);
  }

  private static Node buildRec(int[] a, int l, int h){
      if(l>h){
        return null;
      }
      int m = (l+h)/2;
      Node left = buildRec(a,l,m-1);
      Node right = buildRec(a,m+1,h);

      return new Node(a[m],left,right);
  }
}
```

### BinarySearchTree 만족하는지 판별
자식들이 아니고 자식!

```
public class TreeHandler{
    public static boolean isBst(Node root){
      return isBstRec(root,Integer.MIN_VALUE,Integer.MAX_VALUE);
    }

    // min < node.data <=max
    private static boolean isBstRec(Node node, int min, int max){
        if(node==null){
          return true;
        }
        if(node.data <= min || node.data > max){
          return false;
        }

        boolean leftBst = isBstRec(node.left,min,node.data);
        boolean rightBst = isBstRec(node.right,node.data,max);
        //
        return leftBst && rightBst;
    }
}
```
