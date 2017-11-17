# [백준](https://www.acmicpc.net/) 온라인 judge 문제들을 풉니다.


## 2557 Hello World

```java
import java.util.*;

public class Main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Hello World!");
	}

}

```

## 11718 받은대로 출력하기

```java
import java.util.Scanner;

public class Main {
	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		while(s.hasNextLine()) {
			String str = s.nextLine();

			if (!(str.isEmpty() || str.length() > 100)) {
				System.out.println(str);
			}
		}
	}
}

```


## 2839번 설탕배달 문제

idea: 전체에서 3씩 빼면서 5로 나눠지는지 확인한다.

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int N = s.nextInt();
		// N은 3과 5000사이의 값

		System.out.println(cal(N));

	}

	public static int cal(int N) {

		int cnt = 0;
		while (N > 0) {

			if ((N%5) == 0) {
				return N/5 + cnt;
			}
			cnt ++;
			N -= 3;

		}

		if (N==0) {
			return cnt;
		}else {
			return -1;
		}
	}
}
```

## 2741번 for문 출력

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int N = s.nextInt();
		// N은 100,000보다 작거나 같은 자연수

		for (int i =0 ; i<N; i++) {
			System.out.println(i+1);
		}

	}

}


```


## 11721 열개씩 끊어서 출력

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		String str = s.nextLine();
		// N은 100,000보다 작거나 같은 자연수

		char[] array = new char[10];
		for (int i = 0 ; i<str.length(); i++) {

			array[i%10] = str.charAt(i);

			if (i%10 == 9) {
				System.out.println(array);
			}

			if(i == str.length()-1) {
				for(int j=0; j < (i+1)%10; j++) {
					System.out.print(array[j]);
				}
				System.out.println("");
			}
		}

	}

}

```


## 10817번 두번째로 큰 숫자

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int a = Integer.parseInt(s.next());
		int b = Integer.parseInt(s.next());
		int c = Integer.parseInt(s.next());

		if ((a <= b && b<= c) || (c <= b && b<= a))  {
			System.out.println(b);
		}else if ((b <= a && a<= c) || (c <= a && a<= b)) {
			System.out.println(a);
		}else if ((a <= c && c<= b) || (b <= c && c<= a)) {
			System.out.println(c);
		}
	}

}

```

## 4344번 평균은 넘겠지

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int numOfTestCase = s.nextInt();

		for(int i=0;i<numOfTestCase;i++) {
			int caseNum = s.nextInt();
			int[] array = new int[caseNum];
			int sum = 0,overAvgNum = 0;
			float avg = 0;
			for (int j = 0; j< caseNum; j++) {
				array[j] = s.nextInt();
				sum += array[j];
			}

			avg = sum / caseNum;

			for(int e: array) {
				if (e > avg) {
					overAvgNum ++;
				}
			}

			System.out.printf("%.3f",(float)overAvgNum/(float)caseNum * 100);
			System.out.print("%");
			System.out.println("");
		}


	}

}
```

## 1065번 한수
문제 조건인 1000 이상일 때를 안맞춰줘서 4번이나 재제출했다. ㅠ_ㅠ

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt();
		// num은 첫째 줄에 1,000보다 작거나 같은 자연수


		System.out.println(findHanNumber(num));
	}

	public static int findHanNumber(int N) {

		int cnt = 0;
		int[] array = new int[3];

		for (int num = N; num >=1; num--) {

			if (num >=1000) {
				continue;
			}else if (num >= 100) {
				array[0] = num % 10;
				array[1] = (num / 10) % 10;
				array[2] = (num / 100) % 10;

				if ((array[1] - array[0]) == (array[2] - array[1])) {
					cnt ++;
				}

			}else if (num>= 1) {
				cnt++;
			}
		}

		return cnt;
	}
}
```

## 1152 단어의 갯수

처음 착안점은 앞뒤의 공백 문자일경우만 빼고
단어 사이의 공백문자 갯수 + 1 이면 될 것으로 생각했으나..
공백문자가 반복되는 경우때문에
'단어의 시작'을 세는 걸로 전략을 바꿨다.

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		String str = s.nextLine();
		char[] arr = str.toCharArray();
		int cnt = 0;

		for(int i=0; i< arr.length;i++) {

			if (i == 0 && arr[i] != ' ') {
				cnt ++;
			}else if ( i != 0 && (arr[i-1] == ' ') && (arr[i] != ' ')){
				cnt ++;
			}

		}

		System.out.println(cnt);
	}

}

```

## 5622 다이얼

0이랑 1에 해당하는 문자가 없어서 명세가 이상함.

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		String str = s.nextLine();
		char[] arr = str.toCharArray();
		int sum = 0;
		for(char ch: arr) {
			switch(ch) {
			case 'A':
			case 'B':
			case 'C':
				sum += 3; break;
			case 'D':
			case 'E':
			case 'F':
				sum += 4; break;
			case 'G':
			case 'H':
			case 'I':
				sum += 5; break;
			case 'J':
			case 'K':
			case 'L':
				sum += 6; break;
			case 'M':
			case 'N':
			case 'O':
				sum += 7; break;
			case 'P':
			case 'Q':
			case 'R':
			case 'S':
				sum += 8; break;
			case 'T':
			case 'U':
			case 'V':
				sum += 9; break;
			case 'W':
			case 'X':
			case 'Y':
			case 'Z':
				sum += 10; break;
			case '0':
				sum += 11; break;
			case '1':
				sum += 2; break;
			default :
				break;
			}
		}
		System.out.println(sum);
	}

}

```


## 10250번 ACM 호텔

나만 string '0'을 중간에 넣은거같은 기분인데..

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int numOfTestCase = s.nextInt();

		for (int i=0; i<numOfTestCase; i++) {
			int H = s.nextInt();
			int W = s.nextInt();
			int customerNum = s.nextInt();

			if (customerNum % H != 0) {
				if (customerNum / H >= 9) {
					System.out.println(customerNum % H + ""+ (customerNum / H + 1));
				}else {
					System.out.println(customerNum % H + "0"+ (customerNum / H + 1));
				}
			}else {
				if (customerNum / H >= 10) {
					System.out.println(H + ""+ (customerNum / H));
				}else {
					System.out.println(H + "0"+ (customerNum / H ));
				}
			}

		}

	}
}
```

## 2750번 수정렬하기 (일반적인 버블소트)

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int numOfTestCase = s.nextInt();

		int[] arr = new int[numOfTestCase];

		for (int i=0; i<numOfTestCase; i++) {
			arr[i] = s.nextInt();
		}

		for (int i=0; i<arr.length-1;i++) {
			for(int j=i+1; j<arr.length;j++) {
				if ((arr[i]>arr[j])) {
					int temp = arr[j];
					arr[j] = arr[i];
					arr[i] = temp;
				}
			}
		}

		for (int num:arr) {
			System.out.println(num);
		}

	}
}

```

## 2751 수 정렬하기 (MergeSort)

1. 반으로 갈라서 각각 왼쪽, 오른쪽을 복사해둔다.
2. 반으로 가른 두쪽을 합치는 함수를 짠다.
3. 이 합치는 함수에서는 왼쪽 / 오른쪽 index가 남아있을 때까지 돌려서
새로운 세번째 arr를 반환한다.

* ArrayList를 쓰는게 나았으려나.

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int length = s.nextInt();

		int[] arr = new int[length];

		for (int i=0; i<length; i++) {
			arr[i] = s.nextInt();
		}

		int[] sorted = mergeSort(arr,0,length);

		for (int num:sorted) {
			System.out.println(num);
		}

	}

	public static int[] mergeSort(int[] array, int start, int end) {

		int mid = (start+end) / 2;
		int[] left = new int[mid];
		int[] right = new int[end-mid];

		for (int i=0;i<mid;i++) {
			left[i] = array[i];
		}

		for(int i=mid;i<end;i++) {
			right[i-mid] = array[i];
		}
		if (array.length > 1) {
			left = mergeSort(left,0,left.length);
			right = mergeSort(right,0,right.length);
		}else {
			return array;
		}

		return merge(left,right);

	}


	public static int[] merge(int[] left, int[] right) {
		int[] result = new int[left.length+right.length];
		int leftIndex=0,rightIndex=0,resultIndex=0;


		while(leftIndex < left.length || rightIndex < right.length) {
			if (leftIndex >= left.length) {
				result[resultIndex] = right[rightIndex];
				rightIndex ++;
			}else if (rightIndex >= right.length) {
				result[resultIndex] = left[leftIndex];
				leftIndex ++;
			}else {
				if (left[leftIndex] <= right[rightIndex]) {
					result[resultIndex] = left[leftIndex];
					leftIndex ++;
				}else {
					result[resultIndex] = right[rightIndex];
					rightIndex ++;
				}
			}
			resultIndex ++;
		}


		return result;
	}

}

```

## 1978번 소수구하기

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt(); // 100 이하
		int cnt = 0;
		for (int i=0; i<num; i++) {
			int c_num = s.nextInt();
			if (isPrime(c_num)) {
				cnt ++;
			}
		}

		System.out.println(cnt);

	}

	public static boolean isPrime(int num) {

		if (num <= 1){
			return false;
		}else if (num == 2){
			return true;
		}else {
			for (int i=2; i< (num/2)+1; i++) {
				if ((num % i) == 0) {
					return false;
				}
			}
			return true;
		}
	}

}

```

## 10828번 스택 기본
그냥 ArrayList 씀

```java

package code_tes;

import java.util.ArrayList;
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt(); // 명령 수

		ArrayList<Integer> list = new ArrayList<Integer>();

		while(num > 0) {
			String str = s.next();

			switch(str) {
			case "push" :
				int n = s.nextInt();
				list.add(n);
				break;
			case "size" :
				System.out.println(list.size());
				break;
			case "pop" :
				if (!list.isEmpty()) {
					System.out.println(list.get(list.size()-1));
					list.remove(list.size()-1);
					break;
				}else {
					System.out.println(-1);
					break;
				}
			case "empty" :
				if (list.isEmpty()) {
					System.out.println(1);
					break;
				}else {
					System.out.println(0);
					break;
				}
			case "top" :
				if (!list.isEmpty()) {
					System.out.println(list.get(list.size()-1));
					break;
				}else {
					System.out.println(-1);
					break;
				}
			default :
				continue;
			}
			num --;
		}
	}


}
```

## 9012번 괄호

메인에 한번에 짜려니까 역시 잘 안된다

```java
import java.util.Scanner;
import java.util.Stack;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt(); // 명령 수


		while(num > 0 ) {
			String pStr = s.next();
			char[] arr = pStr.toCharArray();


			if (isValid(arr)) {
				System.out.println("YES");
			}else {
				System.out.println("NO");
			}

			num --;
		}
	}

	public static boolean isValid(char[] arr) {
		Stack stack = new Stack();

		for (char ch: arr) {
			if (ch == '(') {
				stack.push(ch);
			}else if (ch == ')') {
				if (!stack.isEmpty()) {
					stack.pop();
				}else {
					return false;
				}
			}
		}

		if (stack.isEmpty()) {
			return true;
		}else {
			return false;
		}

	}

}
```

## 2504 Stack 기본 응용 (내일 풀어볼 것)


## 1260번 BFS와 defense

1. DFS
Distance first니까
나랑 연결되어있는 것 중에 visited 안한걸로 무조건 이동해서 또 DFS 돌린다 -> 재귀

2. BFS
뭐랄까..
한 정점에 서서 엇 저기도 여기도 거기도 가봐야지! 하는 콜렉터에 가깝다고나 할까...
인접행렬에 대해서 쭉 돌리는데 어 나랑 연결된 애 중에 안연결된애있었음?
일단 큐에 넣고 계속 찾아봐야지 - 다 찾았네!
그러면 큐에서 poll()해서 얘 기준으로 또 땅 보러가자 ~.~

```java
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

public class Main {


	static int[][] matrix;
	static int numOfNode;
	static int numOfLine;
	static int start;
	static boolean[] visited;

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		numOfNode = s.nextInt();
		numOfLine = s.nextInt();
		start = s.nextInt();
		// 0번들은 쓰지 않는다.
		matrix = new int[numOfNode+1][numOfNode+1];
		visited = new boolean[numOfNode+1];

		for (int i=0; i<numOfLine; i++) {
			int a = s.nextInt();
			int b = s.nextInt();

			matrix[a][b] = matrix[b][a] = 1;
		}

		dfs(start);
		for(int i=1;i<numOfNode+1;i++) {
			visited[i] = false;
		}

		System.out.println("");

		bfs(start);

	}


	public static void dfs(int start) {
		visited[start] = true;
		System.out.print(start + " ");

		for(int i=1; i<=numOfNode;i++) {
			if( matrix[start][i] == 1 && !visited[i] ) {
				dfs(i);
			}
		}
	}

	public static void bfs(int start) {
		Queue<Integer> queue = new LinkedList<Integer>();
		queue.offer(start);
		visited[start] = true;
		System.out.print(start + " ");

		while(!queue.isEmpty()) {
			int node = queue.poll();
			for(int i=1;i<=numOfNode;i++) {
				if(matrix[node][i] == 1 && !visited[i]) {
					queue.offer(i);
					visited[i] = true;
					System.out.print(i + " ");
				}
			}
		}

	}
}

```

## 10866번 Deck

deck은 앞뒤로 삽입 삭제가 가능한 리스트 ~.~

```java

import java.util.LinkedList;
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);
		int num = s.nextInt();
		LinkedList<Integer> deck = new LinkedList<Integer>();

		int n;
		while (num > 0) {
			switch(s.next()) {
			case "push_back":
				n = s.nextInt();
				deck.addLast(n);
				break;
			case "push_front":
				n = s.nextInt();
				deck.addFirst(n);
				break;
			case "front":
				if (!deck.isEmpty()) {
					System.out.println(deck.getFirst());
				}else {
					System.out.println(-1);
				}
				break;
			case "back":
				if (!deck.isEmpty()) {
					System.out.println(deck.getLast());
				}else {
					System.out.println(-1);
				}
				break;
			case "size":
				System.out.println(deck.size());
				break;
			case "pop_front":
				if (!deck.isEmpty()) {
					System.out.println(deck.getFirst());
					deck.removeFirst();
				}else {
					System.out.println(-1);
				}
				break;
			case "pop_back":
				if (!deck.isEmpty()) {
					System.out.println(deck.getLast());
					deck.removeLast();
				}else {
					System.out.println(-1);
				}
				break;
			case "empty":
				if (deck.isEmpty()) {
					System.out.println(1);
				}else {
					System.out.println(0);
				}
				break;
			default:
				continue;
			}
			num --;
		}

	}

}

```

## 2747번 피보나치 수
아주 전형적이고 기본적인 재귀 문제
왜 이 이상 재귀를 못풀까 ㅠ_ㅠ

```java

import java.util.Scanner;

public class Main {


	public static void main(String args[]) {

		Scanner s = new Scanner(System.in);
		int num = s.nextInt();
		System.out.println(fibonnaci(num));

	}

	public static int fibonnaci(int n) {

		if (n==0) {
			return 0;
		}else if (n==1) {
			return 1;
		}else if (n>1) {
			return fibonnaci(n-1)+ fibonnaci(n-2);
		}else {
			return -1;
		}
	}
}

```


## 11050 이항계수 재귀함수

(N,K) = (N-1,K-1) + (N-1,K) 라는 성질을 이용해서 재귀를 성립시키면 된다.
K<0이거나 N>K인경우는 0이고,
N=1인 경우는 무조건 1이겠지.
제한 조건만 잘 써주면 금방인 문제

```java
import java.util.Scanner;

public class Main {


	public static void main(String args[]) {

		Scanner s = new Scanner(System.in);
		int N = s.nextInt();
		int k = s.nextInt();

		System.out.println(combination(N,k));

	}

	public static int combination(int N,int k) {

		if (k>N || k<0) {
			return 0;
		}else if (N == 1) {
			return 1;
		}else {
			return combination(N-1,k-1) + combination(N-1,k);
		}
	}
}


```


## 1003번 피보나치 호출 횟수 구하기
f(0)과 f(1)이 얼마나 호출되는지 구하는 문제
static var 써서 그냥 구했는데
동적 계획법이랑 무슨 연관인지 잘 모르겠다.

```java
import java.util.Scanner;

public class Main {


	static int called0=0;
	static int called1=0;
	public static void main(String args[]) {

		Scanner s = new Scanner(System.in);
		int testCase = s.nextInt();

		for(int i=0; i<testCase; i++) {
			int n = s.nextInt();
			fibonacci(n);
			System.out.println(called0+" "+called1);
			called0 = 0;
			called1 = 0;
		}

	}

	public static int fibonacci(int n) {

		 if (n==0) {
		        called0 ++;
		        return 0;
		    } else if (n==1) {
		        called1 ++;
		        return 1;
		    } else {
		        return fibonacci(n-1) + fibonacci(n-2);
		    }
	}
}
```

## 1149 RGB 거리

3가지 방법을 선택했을 때 결국 어떤 비용이 나오는 지 보고 최솟값을 고르는거.
기본 비용 matrix와
크기가 똑같은 matrix(d matrix)를 만듦

d matrix의 (행,열)에는
그 선택을 했을때의 비용이 빼곡히 채워져야함

어떤 집에 R을 칠한다는 것 = 그 전집에서 G나 B 중 비용 적은 거 칠함 + 지금 이집에 R칠함

이런 식으로 구해나가면 됨

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int numOfHouse = s.nextInt();

		int[][] arr = new int[numOfHouse+1][3];
		int[][] d = new int[numOfHouse+1][3];


		for (int i=1; i<numOfHouse+1; i++) {
			for (int j=0;j<3;j++) {
				arr[i][j] = s.nextInt();
			}
		}

		arr[0][0] = arr[0][1] = arr[0][2] = 0;
		d[0][0] = d[0][1] = d[0][2] = 0;

		for(int k=1;k<numOfHouse+1;k++) {
			d[k][0] = min(d[k-1][1],d[k-1][2]) + arr[k][0];
			d[k][1] = min(d[k-1][0],d[k-1][2]) + arr[k][1];
			d[k][2] = min(d[k-1][0],d[k-1][1]) + arr[k][2];
		}

		System.out.println(min(min(d[numOfHouse][0],d[numOfHouse][1]),d[numOfHouse][2]));

	}

	public static int min(int a,int b){
		return a < b ? a : b;
	}

}
```


## 1932번 숫자 삼각형


```java

import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int height = s.nextInt();

		int[][] arr = new int[height+1][height+1];
		int[][] d = new int[height+1][height+1];

		int max = 0;
		for(int i=0;i<height+1;i++) {
			for(int j=0;j<height+1;j++) {
				arr[i][j] = 0;
				d[i][j] = 0;
			}
		}

		for(int i=1;i<height+1;i++) {
			for(int j=1;j<i+1;j++) {
				arr[i][j] = s.nextInt();
			}
		}

		for(int i=1;i<height+1;i++) {
			for(int j=1; j<i+1;j++) {
				d[i][j] = max(d[i-1][j],d[i-1][j-1]) + arr[i][j];
			}
		}

		for(int i=1;i<height+1;i++) {
			if (d[height][i] > max) {
				max = d[height][i];
			}
		}

		System.out.println(max);


	}

	public static int max(int a,int b){
		return a > b ? a : b;
	}

}
```

## 2579 계단오르기
두 노드를 생각해서 (2,1) + (1,2) + (2,2)
인 경우 중에서 최대 값을 생각했는데
그럴 필요는 없고
마지막 밟아야하는 n번째 노드 기준으로 n-1를 밟았을때와 안밟았을 때를 구별해서 해준다


```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt();

		int[] arr = new int[num+1];
		int[] d = new int[num+1];

		arr[0] = d[0] = 0;

		for (int i=1;i<num+1;i++) {
			arr[i] = s.nextInt();
		}


		d[1] = arr[1];
		d[2] = arr[1] + arr[2];

		for(int i=3;i<num+1;i++) {
			d[i] = max(d[i-3]+arr[i-1]+arr[i],d[i-2]+arr[i]);
		}

		System.out.println(d[num]);
	}

	public static int max(int a,int b){
		return a > b ? a : b;
	}

}
```

## 1463번 1로 만들기

DP문제는
무엇을 최소 혹은 최대로 만들것인지에 따라서
DP 매트릭스를 정하고 점화식을 제대로 만들고
base case 값만 잘 정해주면 되는 거같다

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int N = s.nextInt();
		int[] d = new int[N+1];
		d[0] = 0;
		d[1] = 0;
		if (N>1) {
			d[2] = 1;
		}

		if (N>2) {
			d[3] = 1;
		}

		if(N>4) {
			for(int i=4;i<N+1;i++) {
				if( i%6 == 0 ) {
					d[i] = min(min(d[i/2]+1, d[i-1]+1),d[i/3]+1);
				}else if( i%2 == 0) {
					d[i] = min(d[i/2]+1, d[i-1]+1);
				}else if (i%3 == 0) {
					d[i] = min(d[i/3]+1,d[i-1]+1);
				}else {
					d[i] = d[i-1] + 1;
				}
			}
		}

		System.out.print(d[N]);
	}

	public static int min(int a,int b) {
		return a < b ? a : b;
	}

}
```


## 10871번 X보다 작은 수
이런건 왜내는거야

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int N = s.nextInt();
		int X = s.nextInt();

		for(int i=0;i<N;i++) {
			int a = s.nextInt();
			if (a < X) {
				System.out.print(a+ " ");
			}
		}
	}

}
```

## 2490번 윷놀이

이런건 왜 내는거야 2

```java
package code_tes;

import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int cnt0 = 0;

		for(int i=0;i<12;i++) {
			if (s.nextInt() == 0) {
				cnt0++;
			}

			if ((i+1)%4==0) {
				switch (cnt0){
				case 1 : System.out.println('A'); break;
				case 2 : System.out.println('B'); break;
				case 3 : System.out.println('C'); break;
				case 4 : System.out.println('D'); break;
				default : System.out.println('E'); break;
				}
				cnt0 = 0;
			}
		}
	}
}
```

## 3053번 택시기하학
|x|+|y|= R 을 그릴줄만 알면
```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int r = s.nextInt();

		System.out.printf("%.6f",Math.PI * r * r);
		System.out.println("");
		System.out.printf("%.6f",2.0 * r *r);
	}
}
```

## 1934번 최소공배수
일반적인 약수 구할때 처럼 N/2 + 1까지만 돌렸다가 틀림.

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int test = s.nextInt();

		while(test>0) {
			int A = s.nextInt();
			int B = s.nextInt();
			System.out.println(LCM(A,B));
			test--;
		}
	}

	public static int LCM(int A,int B) {
		int GCD =  GCD(A,B);

		return A * B / GCD ;
	}

	public static int GCD(int A,int B) {
		int min = Math.min(A,B);
		int GCD = 1;
		for(int i=1; i<=min;i++) {
			if (A % i == 0 && B % i == 0) {
				GCD = Math.max(GCD,i);
			}
		}
		return GCD;
	}
}
```

## 1850번 최대공약수
런타임에러가 뜨지만 더이상어케 개선해야할지모르겠다

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

			int A = s.nextInt();
			int B = s.nextInt();

			for(int i=0;i<GCD(A,B);i++) {
				System.out.print(1);
			}
	}


	public static long GCD(long A,long B) {
		if (B==0) {
			return A;
		}else {
			return GCD(A,A%B);
		}
	}
}
```

## 2455번 지능형 기차
이런건 왜 내는거야 3

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int max = 0;
		int current = 0;
		for(int i=0;i<4;i++) {
			int out = s.nextInt();
			int in = s.nextInt();
			current += in - out;
			max = max(max,current);
		}
		System.out.println(max);
	}

	public static int max(int a, int b) {
		return a > b ? a : b;
	}
}
```

## 2740번 행렬 곱셈
급격히 집중력이 떨어짐.
```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int N = s.nextInt();
		int M = s.nextInt();

		int[][] arr1 = new int[N][M];

		for(int i=0;i<N;i++) {
			for(int j=0;j<M;j++) {
				arr1[i][j] = s.nextInt();
			}
		}

		M = s.nextInt();
		int K = s.nextInt();
		int[][] arr2 = new int[M][K];

		for(int i=0;i<M;i++) {
			for(int j=0;j<K;j++) {
				arr2[i][j] = s.nextInt();
			}
		}


		for(int x=0;x<N;x++) {
			for(int y=0;y<K;y++) {
				int sum = 0;
				for(int z=0;z<M;z++) {
					sum += arr1[x][z] * arr2[z][y];
				}
				System.out.print(sum+ " ");
			}
			System.out.println("");
		}

	}


}
```

## 2965번 캥거루
더 사이가 큰 쪽 -1

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int A = s.nextInt();
		int B = s.nextInt();
		int C = s.nextInt();

		System.out.println(kang(A,B,C));
	}

	public static int kang(int A,int B,int C) {
		return B-A > C-B ? B-A-1 : C-B-1;
	}

}
```


## 약수 조합 갯수 구하기
```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int A = s.nextInt();
		System.out.println(area(A));
	}

	public static int area(int A) {
		int cnt = 0;
		for(int i=1; i<Math.sqrt((float) A)+1;i++) {

			if ( (float) i == Math.sqrt(A)) {
				cnt ++;
			}else if (A%i==0) {
				cnt +=2;
			}
		}

		return cnt;
	}

}
```

## 10점을 얼마나 몇 학기 더 맞아야 기준에 넘을까
```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int num = s.nextInt();
		int[] arr = new int[num];

		while(num>0) {
			arr[num-1] =s.nextInt();
			num --;
		}

		System.out.println(termLeft(arr));

	}

	public static int termLeft(int[] arr) {
		int sum = 0;
		for(int e : arr) {
			sum += e;
		}

		return (int) ((9.5 * arr.length - sum) / 0.5);
	}

}
```


## 이분매칭 (답 이상함, 수정요)

```java
import java.util.Scanner;

public class Main {

	public static void main(String args[]) {
		Scanner s = new Scanner(System.in);

		int test = s.nextInt();
		while(test>0) {
			int N = s.nextInt(); // 사람수이자 자리수
			int condition = s.nextInt(); //앞으로 나올 조건 수
			int[][] arr = new int[N][N]; // 인접행렬
			boolean[] visited = new boolean[N]; // 이 사람은 매칭했는지?
			int[] seatTaken = new int[N]; // 이 자리가 찼는지, 찾으면 몇번인지

			for(int i=0;i<condition;i++) {
				int person = s.nextInt();
				int seat = s.nextInt();
				arr[person][seat] = 1;
			}

			for(int j=0; j<N;j++) {
				seatTaken[j] = -1;
				visited[j] = false;
			}

			if (match(N,arr,visited,seatTaken)) {
				System.out.print("O");
			}else {
				System.out.print("X");
			}

			test --;
		}

	}

	public static int dfs(int person,int[][] arr,boolean[] visited,int[] seatTaken) {
		if (person < 0 ) {
			return 0;
		}
		if (visited[person]) {
			return 0;
		}

		visited[person] = true;
		for (int i=0; i< arr[person].length; i++) {
			int seat = arr[person][i];

			if ( seatTaken[seat] == -1 || dfs(seatTaken[seat],arr,visited,seatTaken) == 1) {
				seatTaken[seat] = person;
				return 1;
			}

		}

		return 0;
	}

	public static boolean match(int N,int[][] arr,boolean[] visited,int[] seatTaken) {
		int max = 0;
		for(int i=0; i< N;i++) {
			if (dfs(i,arr,visited,seatTaken) == 1) {
				max ++;
			}
		}

		if (max == N) {
			return true;
		}else {
			return false;
		}
	}

}
```
