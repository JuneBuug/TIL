
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
