## 버블 소트

바로 다음 거랑만 비교하는 것
내꺼
```
public class BubbleSort {
    public static void sort(int[] a) {
        // ToDo
        for(int i =0;i<a.length;i++){
            for(int j=i+1;j<a.length;j++){
                if(a[i]>a[j]){
                    int temp = a[i];
                    a[i] = a[j];
                    a[j] = temp;
                }
            }
        }
    }
}

```
강의 답
```
public class BubbleSort {
    public static void sort(int[] a) {
        // ToDo
        for(int i =0;i<a.length-1;i++){
            for(int j=0;j<a.length-1-i;j++){
                 if(a[j]>a[j+1]){
                    int temp = a[j];
                    a[j] = a[j+1];
                    a[j+1] = temp;
                 }
                }
            }
        }
    }
}


```

## O(n) 의 배열 정렬
**다시 한번 볼것**
사람들의 나이값이 주어진 배열을 정렬하는 함수
나이 => 숫자 크지 않다!
```
public class AgeSort{
  // age range: 0~149 사람 수를 세서 나열하면됨
  public static void sort(int[] a){
      int[] cntArray = new int[150];

      for(int p:a){
         cntArray[p]++;
      }

      int index=  0;
      for(int i=0;i<cntArray.length;i++){
          for(int k=0; k<cntArray[i] ; k++){
              a[index] =i;
              ++index;
          }
      }
  }
}
```

## BinarySearch

바이너리 서치는 정렬되어있는 배열에 대해서 검색을 하는 방법이다.
반씩 나눠서 찾아가는 것이기때문에 O(log N)의 시간 복잡도를 가진다.
재귀로도 짤 수 있을 거고, while문으로도 짤 수 있다.
우아한 형제 캠프 코딩 인터뷰에 비슷한 문제가 나와서 적어본다.

```
# 검색된 값의 index를 반환
class Solution{


  public static void main(String args[]){

    int[] array = { 2, 3, 5, 6, 10};
    int target = 5;
    System.out.println(target +" 값이 저장된 index는 " +BinarySearch(array,target,0,array.length - 1));
  }
  public static int BinarySearch(int[] A, int target,int left,int right){

      int m = (left + right) / 2;

      if(A[m] == target) {
         return m;
      }

      if(A[m] > target){
          return BinarySearch(A,target,m+1,right);
      }else{
    	  return BinarySearch(A,target,left,right-1);
      }
  }
}
```
