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

		bfs(start);
		for(int i=1;i<numOfNode+1;i++) {
			visited[i] = false;
		}

		System.out.println("");

		dfs(start);

	}


	public static void bfs(int start) {
		visited[start] = true;
		System.out.print(start + " ");

		for(int i=1; i<=numOfNode;i++) {
			if( matrix[start][i] == 1 && !visited[i] ) {
				bfs(i);
			}
		}
	}

	public static void dfs(int start) {
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
