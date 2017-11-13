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
