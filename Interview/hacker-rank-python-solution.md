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

딕셔너리쓰면 늦지않게ㅋㅋ다할수있다 dictionary(hashtable) 의 접근 시간 복잡도는 O(1)이니까 그런가.


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

다만 이 방식은 spatial complexity 가 겁나 커진다는 걸 알 수 있다.
흠, 그러면 어떤 자료 구조를 써야할까 -
문제에 나와있지만 (Trie)[http://blog.ilkyu.kr/entry/%ED%8C%8C%EC%9D%B4%EC%8D%AC%EC%97%90%EC%84%9C-Trie-%ED%8A%B8%EB%9D%BC%EC%9D%B4-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0]이다.

tree의 일종임.

Trie는 문자열 검색에 특화된 자료구조이고, 참고한 링크에 설명이 매우매우 잘 나와있으니 한번 보는 것이 좋을 듯.


## DFS : Connected cell in grid

자주 나오는 문제임
필요한 부분만 돌고,
positions = [(-1,-1)..]
등으로 주변 8개를 도는 것이 포인트.

만약 어떤 점이 1이면, 그 점은 0으로 바꿔놓고.

```python
def dfs(grid,i,j):
    n , m = len(grid), len(grid[0])
    cnt = 1
    positions = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
    grid[i][j] = 0

    for pos in positions:
        if i + pos[0] in range(n) and j + pos[1] in range(m):
            if grid[i+pos[0]][j+pos[1]] == 1:
                cnt += dfs(grid,i+pos[0],j+pos[1])
    return cnt

def getBiggestRegion(grid):
    max_region = 0
    n, m = len(grid) , len(grid[0])

    for i in range(n):
        for j in range(m):
            if grid[i][j] == 1:
                max_region = max(max_region, dfs(grid,i,j))

    return max_region

n = int(input().strip())
m = int(input().strip())
grid = []
for grid_i in range(n):
    grid_t = list(map(int, input().strip().split(' ')))
    grid.append(grid_t)
print(getBiggestRegion(grid))

```


## BFS: Shortest Reach in Graph
일반적으로는 다익스트라로 푸는 내용을 BFS로 푸는 해법.

물론 이번에도 풀지 못했지만 따라 쳤다리..

`' '.join` 등의 프린트 방법도 볼수있었음.

```python
from queue import Queue
class Graph(object):

    def __init__(self,n):
        self.n = n
        self.edges = [[0] * n for i in range(n)]

    def connect(self,i,j):
        self.edges[i][j] = 1
        self.edges[j][i] = 1

    def find_all_distances(self,index):
        distances = [-1] * self.n
        queue = Queue()
        queue.put((index,-1,0))
        # 시작점 index, 이전 노드의 index, 시작점과의 거리

        while not queue.empty():
            _index, _preIndex, _dist = queue.get()
            if distances[_index] == -1 or _dist < distances[_index]:
                distances[_index] = _dist
                for idx, edge in enumerate(self.edges[_index]):
                    if not idx == _preIndex and edge:
                        queue.put((idx,_index,_dist+1))

        return [6*d if d != -1 else d for d in distances]





t = int(input())
for i in range(t):
    n,m = [int(value) for value in input().split()]
    graph = Graph(n)
    for i in range(m):
        x,y = [int(x) for x in input().split()]
        graph.connect(x-1,y-1)
    s = int(input())
    dist = graph.find_all_distances(s-1)

    print(' '.join([str(item) for item in dist if item !=0]))


```

## HEAP : median 찾기

물론 힌트 봤지만..
python에는 갓갓 sort 가 있었던 것이다
이진 탐색을 이용한 insort (배열 정렬 순을 바꾸지않고 insert하는 것)

insert(리스트,넣을 원소,(범위)) 이렇게 쓴다.

```python
#!/bin/python3

import sys
from bisect import insort

def median(list):
    if len(list) % 2 == 0 :
        half = int(len(list) / 2)
        pre_half = half - 1
        return (list[half] + list[pre_half]) / 2
    else:
        return float(list[int((len(list)-1)/2)])

n = int(input().strip())
a = []
a_i = 0
for a_i in range(n):
   a_t = int(input().strip())
   insort(a,a_t)
   print(median(a))

```


## MERGE SORT : COUNTING INVERSIONS

순서가 잘못된 부분을 세는 것임


```python
#!/bin/python3

import sys

def merge_sort(arr):
    list = []
    if len(arr) > 1:
        mid = int(len(arr) / 2)
        arr1,cnt1 = merge_sort(arr[:mid])
        arr2,cnt2 = merge_sort(arr[mid:])
        list,cnt = merge(arr1,arr2)
        return list, cnt1+cnt2+cnt
    else:
        return arr,0

def merge(arr1,arr2):
    arr = []
    cnt = 0
    while arr1 and arr2:
        if arr1[0] <= arr2[0]:
            arr.append(arr1.pop(0))
        else:
            cnt += len(arr1)
            arr.append(arr2.pop(0))

    if len(arr1) != 0:
        arr.extend(arr1)
    if len(arr2) != 0:
        arr.extend(arr2)
    return arr,cnt

def countInversions(arr):
    sorted, cnt = merge_sort(arr)
    return cnt


if __name__ == "__main__":
    t = int(input().strip())
    for a0 in range(t):
        n = int(input().strip())
        arr = list(map(int, input().strip().split(' ')))
        result = countInversions(arr)
        print(result)

```
