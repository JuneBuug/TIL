## DAY 10 binary numbers
이진수에서 가장 긴 consecutive 1's 길이 반환


```python3

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
