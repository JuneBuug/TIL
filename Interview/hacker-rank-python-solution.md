## DAY 10 binary numbers
이진수에서 가장 긴 consecutive 1's 길이 반환


```python

#!/bin/python3

import sys


n = int(input().strip())

if ~n == 0:
    print(len(bin(n)-2))
else:
    arr = list(bin(n))
    del arr[0]
    del arr[0]
    maxLen = 0
    pastLen = 0
    for item in arr:
        if item == "1":
            pastLen +=1
            if maxLen < pastLen:
                maxLen = pastLen
        else:
            pastLen = 0
    print(str(maxLen))

```


## Arrays : Left Rotation

길이 n과 왼쪽으로 밀 횟수 k가 주어졌을 때
배열을 민 결과를 반환

예를 들어 3만큼 왼쪽으로 민다고 했고, 길이가 n인 배열일 때
0번째는 0-3 + n 번째에 위치하게 되고
1번째는 1 -3 + n 번째
...
j번째는 j-3 번째 (만약 j-3이 음수라면 j-3 + n)번째에 위치

```python

def array_left_rotation(a, n, k):
    if k >= n:
        k = k % n
    arr = []
    for i in range(0,n):
        new_index = i - k
        if new_index < 0:
            new_index += n
        arr.insert(new_index,a[i])
    return arr

n, k = map(int, input().strip().split(' '))
a = list(map(int, input().strip().split(' ')))
answer = array_left_rotation(a, n, k);
print(*answer, sep=' ')

```
