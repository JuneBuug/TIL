
**지금 작성하신 코드의 시간복잡도가 어떻게되죠?**

복잡도가 얼마나 좋아진건지, 어떻게 좋아질 수 있는건지 알아야함

## 시간복잡도

: 데이터 입력 갯수 에 따라서 수행시간이 얼마나 빨리 증가하냐

```
#for루프를 입력 전체에 대해서 1번 돌음
O(n)

#for 루프를 입력 전체에서 2번 돌음
O(n^2)

```


* BinarySearch : O(log n)
* Quick Sort : 평균 O(nlog n) / 최악 O(n^2)
* Bubble Sort / Insertion Sort : O(n^2)


## == / equals()

객체 비교시에 비교하는 방법이 두 개니까 조심할 것

```
String s1 = "june";
String s2 = s1 ;  // s1과 s2는 완전 같은 객체
String s3 = new String("june"); // s3는 값만 같지 s1와 s2과 다른 객체.

//값만 비교하려면 equals, 객체 자체만 비교하려면 ==
```


## 배열 선언하기

```
int[] array = new int[10];
char[] array2 = "Good".toCharArray();
```

## Collection 사용법

* ArrayList (선형 자료구조 )
* LinkedList (선형 자료구조 )
* HashMap
```
java.util.HashMap<K,V>에 있음

HashMap<K,V>
# 기본적으로 map 인터페이스에서 파생된 거임
# key와 value말하는 듯

put(K key,V value)
# 추가하기

get(Object Key)
# 검색하기

remove(Object Key)
# 제거하기

contains(Object Key)
# key가 있는지 검사

keySet()
# key목록 Set<K>. 반복할때 쓴다.

```
for( String key : map.keySet() ){
            System.out.println( String.format("키 : %s, 값 : %s", key, map.get(key)) );
        }
```

```
* Stack
* Queue
* HashSet
* PriorityQueue


## 문제 : 문자열
문자열 관련 함수

```
length()
# 문자열 길이 반환. 배열이면 걍 length

equals(String s)
# 다른 문자열과 (값이) 같은 지 비교

charAt(int i)
# i번째 글자

toCharArray()
# Char[]로 변환

substring(int 시작인덱스,int 끝 인덱스)
# 문자열 잘라오기 (시작~끝 인덱스)

toUppserCase()
# 모두 대문자로 변환

replaceAll(String 대상, String 변환될 문자열)
# 특정 문자열 모두 교체

split(String reg)
# 주어진 글자를 기준으로 잘라서 String[] 반환

trim()
# 문자열 앞뒤의 공백 문자를 제거

Integer.parseInt()
# 스트링을 int로 변경
```

### 1)번 문제 풀이
나는 그냥 parseInt()썼는데 ㅎㅎ..
```
public class StringToInt{
  public static int convert(String s){
    char[] ca = s.toCharArray();
    int num=0;
    // 착안
    // 123 이면
    // 1*10 + 2 = 12
    // 12*10 +3 = 123

    for(char c:ca){
       num *= 10;
       num += c - '0'; // 왜 많이 쓰는 기법인지 모르겠음 왜 쓰는거지??
    }
    return 0;
  }
}
```

### 2)번
HashSet에 착안
* HashSet은 순서 의미 없이, 중복을 포함할 수 없음.
HashSet의 특징
add() method : Data 삽입할 때 사용
next() method : Data 추출할 때 사용
remove() method : Data를 삭제할 때 사용
contains() method : Data의 포함여부를 알기 위해 사용
size() method : HashSet의 요소 개수를 얻어낼 때 사용

```
import java.util.HashSet;

public class UniqChar{
  public static boolean isUniq(String s){

    HashSet<Character> set = new HashSet<Character>();
    for(char c: s.toCharArray()){
        if(set.contains(c))
          return false;
        set.add(c);
    }

    return true;
  }
}
```

### 3) anagram 파악

public java.util.HashMap;

public class Anagram{
  public static boolean isAnagram(String s1,String s2){
    // 정렬하고 비교해야되나? 시간복잡도가 넘 많아짐.
    // 길이가 같고 같은 문자가 같은 횟수로
    if(s1.length()!=s2.length())
      return false;

    HashMap<Character,Integer> hm = new HashMap<Character,Integer>();
    //s1 과 s2에 대해서 갯수 비교. 간결하게하기위해서 s1에 대해서 +, s2는 -

    for(char c:s1.toCharArray){
      if(hm.containsKey(c))
        hm.put(c,hm.get(c)+1);
      else
        hm.put(c,1);
    }

    for(char c:s2.toCharArray){
      if(!hm.containsKey(c))
        return false;
      if(hm.get(c)==0)
        return false;
      hm.put(c.hm.get(c)-1);      
    }

  }
}


### 4) RunLengthCoding

내 답

```
import java.util.HashMap;

public class RunLengthCode {
    public static String coding(String s) {

        String result="";
        HashMap<Character,Integer> hm = new HashMap<Character,Integer>();

        for(char c:s.toCharArray()){
            if(hm.containsKey(c))
                hm.put(c,hm.get(c)+1);           
            else
                hm.put(c,1);
        }

        for(Character key:hm.keySet()){
           result +=key;
           result +=hm.get(key);
        }

		 return result;
	}
```

* 간과한점 (null이면 null임 )
* 문제 이해가 달랐음. 예를들어 abab 면 a2b2 가 아니라 a1b1a1b1인거같음

```
public class RunLengthCode{
  public static String coding(string s){
    if(s==null){
      return null;
    }

    char[] ca = s.toCharArray();
    String result="";

    //이미 루프를 돌았다고 가정하고 루프를 두번째글짜부터.
    int count = 1;
    char prev = ca[0];

    for(int i=1; i<ca.length;i++){
      //그대로 가는 경우와 바뀌는 경우
      if(prev==ca[i]){
        count++;
      }else{
        result += prev + count;
        count=1;
        prev=ca[i];
      }  
    }

    result + = prev + count;

    //루프 마지막에는 나오지 못했을 거기때문에


    return result;
  }
}
```

### 5) WordCount

내 답. 생성자 todo에 뭘 해야할지 모르겠고
자주 호출되어도 부담되지 않게끔

```
import java.util.HashMap;

public class WordCount {
    private HashMap<String, Integer> map;
    public WordCount(){
        //ToDo
        map = new HashMap<String,Integer>();
    }

    public void read(String[] doc) {
        //ToDo
        for(String word: doc){
            if(map.containsKey(word)){
                map.put(word,map.get(word)+1);
            }else{
                map.put(word,1);
            }
        }
    }

    public int getCount(String word) {
        // ToDo
        if(map.containsKey(word))
            return map.get(word);
        else
            return 0;
    }
}

```

## 재귀

초기조건은 그냥 바로 조건문으로 써버림

```
int fibonacci(int n){
  if(n==0)
    return 0;
  if(n==1)
    return 1;

  return fibonacci(n-1)+fibonacci(n-2);
}
```


### Dice



```

if(n<0)
  return 0;  
if(n==0)
  return 1;

return CountWays(n-1)+CountWays(n-2)+ CountWays(n-3)+
CountWays(n-4)+CountWays(n-5) + CountWays(n-6);


```

### Painter
문제이해가안됨
```
public class Painter {
    public static void paint(int[][] image, int x, int y, int newC) {

          paintRec(image,x,y,newC,image[y][x]);
    }

    private void paintRec(int[][] image,int x,int y,int newC,int targetC{

      //이미지 밖으로 나갔는지
      if(y<0||x<0||y>image.length||x>image[0].length){
        return ;
      }

      if(image[y][x]==newC || image[y][x]!=targetC){
        return;
      }

      image[y][x] = newC;

      paintRec(image,x+1,y,newC,targetC);
      paintRec(image,x-1,y,newC,targetC);
      paintRec(image,x,y+1,newC,targetC);
      paintRec(image,x,y-1,newC,targetC);

    }
}
```


### n비트 모든 경우의 수 출력

1비트  - 0,1
2비트 - 00,01,10,11

```
public static ArrayList<String> bitCombination(int n){
  return bitCombRec(n,"",new ArrayList<String>());
  // ""에 0과 1 을 계속 넣어서 완성시 list에 넣어줌
}

private static ArrayList<String> bitCombRec(int n,String s, ArrayList<string> list){

    if(n==s.length()){
        list.add(s);
        return list;
    }

     bitCombRec(n,s+"0",list);
     bitCombRec(n,s+"1",list);

     return list;
}
```


### 순열구하기

```
import java.util.List;
import java.util.ArrayList;

public class Permutation{
    public static List<String> getPermutations(String s){
        if(s==null){
          return null;
        }
        return permRec(s,new boolean[s.length()],"",new ArrayList<String>);
        // 순서들을 recursivecall . 두번째꺼는 누굴골랐는지 표시해주는..FFTFF (3번이 골라졌을때),저장할 string,리턴할것.

    }

    private static List<String> permRec(String s, boolean[] pick, String perm, ArrayList<String> result){

      if(perm.length() == s.length()){
         result.add(perm);
         return result;
      }

      for(int i=0;i<s.length;i++){
        if(pick[i])
           continue;
        pick[i] = true;
        permRec(s,pick,perm+s.charAt[i],result);   
        pick[i] = false; // 얜 다시 안뽑은 애니까?
      }

      return result;
    }
}
```


### 괄호 조합

내 답

import java.util.ArrayList;

public class Parentheses {
    public static List<String> getPairs(int n) {
		// ToDo

		if(n%2!=0)
		   return null;

		return recPair(n,"",new ArrayList<String>());   
	}

	private static List<String> recPair(int n,String s,ArrayList<String> result){

	    if(s.length()==n){
	    	result.add(s);
	    	return result;
	    }



	   recPair(n,s+"()",result);     
	   recPair(n,"()"+s,result);
	   recPair(n,"("+s+")",result);

	   return result;
	}

	public static void main(String args[]){
		System.out.println(getPairs(3));
	}
}

정답

import java.util.List;
import java.util.ArrayList;

public class Parentheses {
    public static List<String> getPairs(int n) {
		// ToDo

		if(n==0)
		   return null;

		return recPair(n,n,"",new ArrayList<String>());   
    //연 것의 갯수와 닫은 것의 남은 갯수 추적하기위해서 n을 두개 씀.
	}

	private static List<String> recPair(int l,int r,String s,ArrayList<String> result){

	    if(l>r){
        return result;
      }
      if(l<0 || r<0)
        return result;
      if(l==0&&r==0){
          list.add(pairs);
          return result;
      }

      recPair(l-1,r,s+"(",result);
      recPair(l,r-1,s+")",result);

      return result;
	}
}


## 동적 프로그래밍
출제빈도는 낮지만 나오면 까다로움
(다음에 듣기루)

## 링크드 리스트
```
class LinkedList{
  Node head;
}

class Node{
  int Data;
  Node next;
}

// 연결해주었을때
node = new Node();
node.next = head;
head = node;

//머리에 추가해주는 식인듯?
```

## 더블 링크드 리스트

//노드에 prev추가
```
node = new Node();
node.next = head;
node.prev = null;
head = node;
node.next.prev = node;
```

* single linkedlist 기본 기능 구현 혹은
* 있다고 가정하고 특정 기능 함수

```
add(T e)
#추가

get(int index)
#검색

remove(int index)
# 제거

isEmpty()
# 비었는지 검사

size()
# 저장된 아이템 수
```


### 싱글링크드 리스트 구현하기

```
private Node head;

public void addToHead(n){
  Node node = new Node();
  node.data = n;
  node.next = head;
  head = node;
}

public void removeFirst(){
  if(head == null){
    throw new RunTimeException("Nothing to remove");
  }
  // 런타임 처리 못해줌.

  head = head.next;
}
```

### 싱글 링크드 리스트 중복 제거


```
import java.util.HashSet;

public class MyList {
    private Node head;

    public void addToHead(int n) {
        Node newNode = new Node();
        newNode.data = n;
        newNode.next = head;
        head = newNode;
    }

    @Override
    public String toString() {
        String str = "[ ";
        for(Node n = head; n!=null; n=n.next) {
            str += n.data;
            str += " ";
        }
        str += "]";
        return str;
    }

    public void removeDuplicates() {
        // 중복 허용안하니까
        HashSet<Integer> set = new HashSet<Integer>();
        //싱글 링크드 리스트는 나의 전 노드의 정보를 알아야함.

        Node prev = null;
        Node n = head;

        while(n!=null){
           if(set.contains(n.data)){
             //있으면 삭제
             prev.next = n.next;
           }else {
             set.add(n.data);
             //없으면 set에 넣고 prev에 날 넣음
             prev = n;
           }
           n = n.next;
        }
    }
}
```

### Single Linked List 뒤집기

```
//비효율적인 코드
public void reverse(){
  Node oldHead = head;
  head = null;

  for(Node n = oldHead; n!=null; n=n.next){
      addToHead(n.data);
  }
}


```

### Single Linked List 뒤에서 K번째 원소

```
public Node kthToLast(int k){
  //k가 음수가 되면 안되겠졍
  if(k < 0){
    return null;
  }
  // 루프 한번만 돌아서 푸는 방법

  Node n1 = head;
  Node n2 = head;

  for(int i=0;i<k;i++){
      if(n2==null){ //최소한 원소가 K개 만큼있어야함.
        return null;
      }
      n2 = n2.next;
  }

  while(n2.next != null){ //k개 만큼 차이나게
     n1 = n1.next;
     n2 = n2.next;
  }

  return n1;
}


```

### palindrome 판별하기

Stack과 list를 써야함.

```
public boolean isPanlindrome(){
  Node n1 = head;
  Node n2 = head;

  Stack<Integer> s = new Stack<Integer>();

  while(n2 !=null && n2.next != null){
     s.push(n1.data);
     n1 = n1.next;
     n2 = n2.next.next; // 절반을 달리기 위해서. 더블러너라구함. 절반만큼 들어감
  }

 // To skil the middle in the case of odd number

  if(n2 ! = null){
    n1  = n1.next;
  }

  while(n1 !=null){
    if(s.pop() != n1.data){
       return false;
    }else {
      n1 = n1.next;
    }
  }

  return true;
}
```
