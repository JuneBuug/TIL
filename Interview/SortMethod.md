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
