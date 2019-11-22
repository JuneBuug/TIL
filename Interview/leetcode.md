난도를 적지 않은 것은 모두 Easy입니다.

1. Two Sum 

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        
        int[] answer = new int[2];
        for (int i=0; i< nums.length; i++) {
     
            for (int j=i+1; j< nums.length; j++) {
                
                if(nums[i]+ nums[j] == target) {
                    answer[0] = i;
                    answer[1] = j;
                }
            }
        }
        
        return answer;
    }
}

```

7. Reverse Integer

```java
class Solution {
    public int reverse(int x) {
        
        int remains = Math.abs(x);
        int length = String.valueOf(remains).length();
        int result = 0;
        while(remains > 0) {
            
            result += (remains % 10) * Math.pow(10, length - 1); 
            remains = (int) remains / 10;
            length -= 1;
        }
    
        
        if (result == Integer.MAX_VALUE || result ==  Integer.MIN_VALUE) {
            return 0;
        }
        
        
        if (x < 0) {
            return -1 * result;
        }
        
        return result;
    }
}

```

9. Palindrome Number 

```java
class Solution {
    public boolean isPalindrome(int x) {
        
        if (x< 0){
            return false;
        }
        
        String num = String.valueOf(x);
        char[] arr = num.toCharArray();
        
        
        for (int i=0; i<= (Math.ceil(arr.length / 2) - 1); i++) {
            
            if (arr[i] != arr[arr.length - i - 1]) {
                return false;
            }
        }
        return true; 
    }
}
```

13. Roman to Integer
완전 무식하게 map 썼는데
```java

class Solution {
    public int romanToInt(String s) {
        Map<String, Integer> map = new HashMap<>();
        
        map.put("IV", 4);
        map.put("IX", 9);
        map.put("XL", 40);
        map.put("XC", 90);
        map.put("CD", 400);
        map.put("CM", 900);
        
        
        int result = 0;
        for (String roman : map.keySet()) {
            if (s.contains(roman)) {
                s = s.replace(roman, "");
                result += map.get(roman);
            }
        }
          
        Map<String, Integer> map2 = new HashMap<>();
        
        map2.put("I", 1);
        map2.put("V", 5);
        map2.put("X", 10);
        map2.put("L", 50);
        map2.put("C", 100);
        map2.put("D", 500);
        map2.put("M", 1000);
        
        
         for (String roman : map2.keySet()) {
            while (s.contains(roman)) {
                System.out.println(s);
                
                s = s.replaceFirst(roman, "");
                result += map2.get(roman);
            }
        }
        
        return result; 
    }
}
```


14. Longest Common Prefix

```java
class Solution {
    public String longestCommonPrefix(String[] strs) {
        
        if (strs.length == 0) {
            return "";
        }
        
       String shortest = strs[0]; 
        
        if (strs.length == 1) {
            return shortest;
        }
       
        
        for(String s : strs) {
            if (s.length() < shortest.length()) {
                shortest = s;
            }
        }
        
         System.out.println(shortest);
        
        String prefix = "";
        for(int i=0; i<= shortest.length(); i++) {
            
            String candidate = shortest.substring(0,i);
            System.out.println(candidate);
            if (allStartsWith(strs, candidate)){
                prefix = candidate;
            }else {
                break;
            }
        }
        return prefix;
        
    }
    
    private boolean allStartsWith(String[] strs, String candidate) {
        for (String s: strs) {
            if (!s.startsWith(candidate)) {
                return false;
            }
        }
        return true;
    }
}


```

20 Valid Parentheses
stack 하면 제일 쉬운거..

```java
class Solution {
    public boolean isValid(String s) {
        if (s.length() == 0) {
            return true;
        }
        
        if (s.length() % 2 == 1) {
            return false;
        }
        
        Stack<Character> stack = new Stack();
        
        for (char c : s.toCharArray()) {
            
            if (c == '(' || c == '{' || c == '[') {
                stack.push(c);
            }
            
            if (c == ')') {
                if (stack.size() == 0 || stack.pop() != '(') {
                    return false;
                } 
            }
            
            if (c == '}') {
                if (stack.size() == 0 || stack.pop() != '{') {
                    return false;
                } 
            }
            
            if (c == ']') {
                if (stack.size() == 0 || stack.pop() != '[') {
                    return false;
                } 
            }
        }
        
        if (stack.size() != 0) {
            return false; 
        }
        
        return true;
    
    }
}

```

21 Merge Two Sorted Lists 

```java

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        ListNode resultNode = new ListNode(0); 
        
        ListNode curr = resultNode;
        while (l1 != null && l2 != null) {
            
            curr.next = new ListNode(0);
            curr = curr.next;
            
            System.out.println("l1: " + l1.val + " l2: " + l2.val);
            if (l1.val <= l2.val) {
                curr.val = l1.val;
                l1 = l1.next;
            } else {
                curr.val = l2.val;
                l2 = l2.next;
            }
            
            
        }
        
        
        if (l1 == null) {
            curr.next = l2;
        }
        
        
        if (l2 == null) {
            curr.next = l1;
        }
        
        return resultNode.next;
    }
}
```



2. Add Two Numbers (Medium)

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode ret = new ListNode(0);
    
        ListNode pnt = ret;
        while (l1 != null || l2 != null) {
            int eval = 0;

           
            if (l1 != null && l2 != null) {
              eval = l1.val + l2.val;
            }
        
            if (l1 == null && l2 != null) {
                eval = l2.val;
            }
            
            if (l2 == null && l1 != null) {
                eval = l1.val;
            }
            
            
            if (eval > 9) {
                
                if (l1.next != null) {
                    l1.next.val += 1;
                }else {
                    l1.next = new ListNode(1);
                }
                eval -= 10;
            }
            

            pnt.next = new ListNode(eval);
            pnt = pnt.next;
            
         
            if (l1 != null) {
                l1 = l1.next;
            }
            
            
            if (l2 != null) {
                l2 = l2.next;
            }
        } 
        
        return ret.next;
    }
    
}
    
```


26. Remove Duplicates from Sorted Array 

```java


class Solution {
    public int removeDuplicates(int[] nums) {
        
        if(nums.length == 0 || nums.length == 1) {
            return nums.length;
        }
        
       
        int i = 0;
        
        for (int j = 1; j < nums.length; j++) {
            if (nums[i] != nums[j]) {
                nums[i+1] = nums[j];
                i++;
            }
        }
        
        return i+1;
    }
}
```


27. Remove Element 

duplicate pointer solution을 보고 푸니 쉽다.
```java 
class Solution {
    public int removeElement(int[] nums, int val) {
        
        int i = 0;
    
        for (int j = 0; j< nums.length; j++) {
            if (nums[j] != val) {
                nums[i] = nums[j];
                i++;
            }
        }
        
        return i;
    }
}
```

35. Search Insert Position

이게 속도가 왜 빠르지?

```java

class Solution {
    public int searchInsert(int[] nums, int target) {
         int length = nums.length;
        
        if (length == 0) {
            return 0;
        }
        
        if (target < nums[0]) {
            return 0;
        }
        
        if (target > nums[length-1]) {
            return length;
        }
        
        
        int ret = 0;
        for (int i=0; i<length-1; i++) {
            if( (nums[i] < target && nums[i+1] > target) || nums[i+1] == target ) {
                ret = i+1;
                break;
            }

        }
        
        return ret;
        
    }
}
```


38. Count and Say 

너무 느리다 ㅋㅋㅋㅋ

> Runtime: 70 ms, faster than 7.82% of Java online submissions for Count and Say.
Memory Usage: 36.4 MB, less than 52.63% of Java online submissions for Count and Say. 
```java
class Solution {
    public String countAndSay(int n) {
            
        Map<Integer, String> map = new HashMap<>();
        map.put(1, "1");
        map.put(2, "11");
        map.put(3, "21");
        map.put(4, "1211");
        map.put(5, "111221");
        
        if (n < 6) {
            return map.get(n);
        } else {
            for(int i=6; i<= n; i ++) {
                map.put(i, count(map.get(i-1)));
            }
        }
        
        return map.get(n);
        
    }
    
    public String count(String org) {
        
        String ret = "";
        
        int cnt = 1;
        char before = ' ';
        for (char c: org.toCharArray()) {
            System.out.println(c);
            
            if (before == c) {
                cnt ++;
            } else if (before != ' ') {
                ret += String.valueOf(cnt);
                ret += before;
                cnt = 1;
            }
             before = c;
        }
        
        ret += String.valueOf(cnt);
        ret += before;
        
        return ret;
    }
}
```


28. Implement strStr()

> Runtime: 0 ms, faster than 100.00% of Java online submissions for Implement strStr().
Memory Usage: 35.7 MB, less than 100.00% of Java online submissions for Implement strStr().

```java
class Solution {
    public int strStr(String haystack, String needle) {
        int needleLength = needle.length();
        int haystackLength = haystack.length(); 
        
        if (needle == null ||needleLength == 0) {
            return 0;
        }
        
    
        if (haystackLength < needleLength) {
            return -1;
        }
        
        char[] arr = haystack.toCharArray();
        for (int i=0; i< haystackLength - needleLength + 1; i++) {
            if (arr[i] == needle.toCharArray()[0]) {
                
                if (haystack.substring(i, i + needleLength).equals(needle)) {
                    return i;
                }
            }
        }
        
        return -1; 
    }
}
```



53. Maximum Subarray 
카데인 알고리즘 공부해서 적었다. 
사실 푼게 아니라 공부인 셈. 

블로그로 적을만 하다
```java
class Solution {
    public int maxSubArray(int[] nums) {
        int best_sum = Integer.MIN_VALUE;
        int end_sum = 0;
        
        for (int num : nums) {
            end_sum = Math.max(end_sum + num, num);
            best_sum  = Math.max(end_sum, best_sum);
        }
        
        return best_sum;
        
    
    }
    
    
}
```


58. Length of Last Word 
이건 왜 있는거야..?
```java
class Solution {
    public int lengthOfLastWord(String s) {
        
        String[] arr = s.split(" ");
        if (arr.length == 0) {
            return 0;
        }
        
        return arr[arr.length-1].length();
    }
}
```

