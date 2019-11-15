
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
