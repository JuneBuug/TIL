# Heap(힙)
완전 이진트리에 있는 노드 중에서 키 값이 가장 큰 노드나 키 값이 가장 작은 노드를 찾기 위해 만든 자료구조.


* 완전 이진 트리여야함.
최대 힙(Max Heap)의 경우
* 모든 노드에 저장된 값은 자식 노드에 저장된 값보다 크거나 같아야한다.
* 루트노트가 가장 커야한다.

## 힙에 추가 시 교환 방법

1. 마지막 자리에 추가한다.
2. 바로 위의 부모와 비교하고, 부모보다 크다면 부모와 자리를 바꾼다
3. 루트 노드까지 반복.

## 힙 삭제 시 교환 방법

1. 삭제할 땐 루트 노트가 삭제된다. 그러면 루트 노트가 빈 상태가 됨.
2. 마지막 자리에 있는 노드를 루트로 가져오고, 자식 노드와의 비교를 통해 바꿔줌
3. 제자리를 찾아갈때까지 반복한다.


# 우선순위 큐

일종의 큐임.
하지만 우선순위 높은 놈이 먼저 나감! (삭제 시)
스택은 마지막에 들어온 놈,
큐는 처음 들어온 놈,
우선순위 큐는 우선순위가 가장 높은 놈을 삭제.

뭐길래 힙소트를 그렇게 쉽게 구현할 수 있는거야?


```
# 추가 O(log N)
offer()

# 제거 O(log N)
poll()

# 제거 없이 읽기 O(1)
peek()

# 크기 O(1)
size()
```


## PriorityQueue 로 heap sort 구현하기

heap sort는 heap에 데이터를 N개를 넣고 작은 것부터 나오면 ..
하나씩 꺼내서 쭉 나열

N개를 꺼내니까 Nlog(N)이 됨

```
import java.util.PriorityQueue;

public class HeapSort(){
  public static void sort(int[] a){
    PriorityQueue<Integer> q = new PriorityQueue<Integer>();

    for(int e: a){ //O(nlogN)
      q.add(e); // 큐에 모든걸 넣음
    }

    for(int k=0;k<a.length;k++){ //O(nlogN)
      a[k] = q.poll();
    }

  }

}
```

## 매우 많은 수에서 top 10을 구하기
입력받는 수가 n개 일 때 O(n)로 구현하라.

```
import java.util.PriorityQueue;

public class Top10{
  private PriorityQueue<Integer> q = new PriorityQueue<Integer>();

  public void read(int n){
    if(q.size()<10){
        q.offer(n);  // 입력받는 수가 10개 보다 작으면 당연히 그냥 넣어줌.
    } else{
      int tenth = q.peek(); // 10번째를 꺼내서 비교한다.

      if(n > tenth){
         q.poll();
         q.offer(n); // 10등보다는 크지만 얘의 등수는 중요하지 않음
      }


    }
  }

  public int[] getTop10(){
      int[] ret = new int[q.size()];

      for(int i = q.size()-1; i>=0; i--){
          ret[i]= q.poll();
      }

      return ret;
  }
}
```


### 출처

http://blog.naver.com/PostView.nhn?blogId=redwave102&logNo=80074139499
