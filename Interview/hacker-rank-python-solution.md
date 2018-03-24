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


## Strings: Making Anagrams

anagram 관계를 만들기 위해서는
몇개의 string을 제거해야할까?

```python
def number_needed(a, b):
    dic1 = {}
    dic2 = {}
    str1 = list(a)
    str2 = list(b)

    for item in str1:
        if item in dic1.keys():
            dic1[item] += 1
        else:
            dic1[item] = 1

    for item in str2:
        if item in dic2.keys():
            dic2[item] += 1
        else:
            dic2[item] = 1

    num = 0
    for k in dic1.keys():
        if k in dic2.keys():
            num += abs(dic1[k] - dic2[k])
        else:
            num += dic1[k]

    for k in dic2.keys():
        if k not in dic1.keys():
            num += dic2[k]

    return num



a = input().strip()
b = input().strip()

print(number_needed(a, b))

```


## Trees: Is This a Binary Search Tree?
binary search tree의 조건에 부합하는지


```python
import sys
def checkBST(root):
    return checkBST2(root,-1,pow(10,5))

def checkBST2(root,left,right):
    if root is None:
        return True
    if root.data <= left or root.data >= right:
        return False
    else:
        return checkBST2(root.left,left,root.data) and checkBST2(root.right,root.data,right)

```

## HashTables: Ice cream parlor

어떤 요소가 hashtable을 쓰게하는 건지 잘 모르겠음
unique한 두 값이 결정되는 input임
돈 이 있고
i번째 아이스크림의 가격이 들어있는 arr가 있음

이 돈에 꼭 맞는 아이스크림 두개 번호를 print
```python
#!/bin/python3

import sys

def solve(arr, money):
    map = {}
    idx = 0
    for cost in arr:
        comp = money - cost
        if comp in map.keys():
            print(str(map[comp]+1) + " " + str(idx+1))
            break
        else:
            map[cost] = idx
            idx = idx + 1

if __name__ == "__main__":
    t = int(input().strip())
    for a0 in range(t):
        money = int(input().strip())
        n = int(input().strip())
        arr = list(map(int, input().strip().split(' ')))
        solve(arr, money)

```

### Tries: Contacts

이름을 저장하는 함수
그리고 특정 검색어로 시작되는 게 몇개나 있는지 리턴하는 함수를 구현

역시 검색엔진처럼 해보려고했지만
dict 으로 나누면 아니 효율 너무 별로지않을까했고, 그래서 구현을 안했었는데
답을 보니...이거였음

딕셔너리쓰면 늦지않게ㅋㅋ다할수있다 dictionary(hashtable) 의 접근 시간 복잡도는 O(1)이니까 그런가

```python
def all_pos(contact):
    return list((contact[0:idx] for idx in range(1,len(contact) + 1)))

contact_dict = {}
def add(contact):
    list = all_pos(contact)
    for item in list:
        if item in contact_dict.keys():
            contact_dict[item] = contact_dict[item] + 1
        else:
            contact_dict[item] = 1

def find(contact):
    if contact in contact_dict.keys():
        return contact_dict[contact]
    else:
        return 0

n = int(input().strip())
for a0 in range(n):
    op, contact = input().strip().split(' ')
    if op == "add":
        add(contact)
    elif op == "find":
        print(str(find(contact)))

```
