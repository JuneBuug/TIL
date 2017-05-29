
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
# key목록 Set<K> 그러면 Set으로 나오나... 이거 검색 !

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

1)번 문제 풀이
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

2)번
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

3) anagram 파악

public java.util.HashMap;

public class Anagram{
  public static boolean isAnagram(String s1,String s2){
    // 정렬하고 비교해야되나? 시간복잡도가 넘 많아짐.


  }
}
