public static void findMaxSubMatrix(int[][] a) {
       int cols = a[0].length;
       int rows = a.length;
       int[] currentResult;
       int maxSum = Integer.MIN_VALUE;
       int left = 0;
       int top = 0;
       int right = 0;
       int bottom = 0;

       for (int leftCol = 0; leftCol < cols; leftCol++) {
           int[] tmp = new int[rows];

           for (int rightCol = leftCol; rightCol < cols; rightCol++) {

               for (int i = 0; i < rows; i++) {
                   tmp[i] += a[i][rightCol];
               }
               currentResult = kadane(tmp);
               if (currentResult[0] > maxSum) {
                   maxSum = currentResult[0];
                   left = leftCol;
                   top = currentResult[1];
                   right = rightCol;
                   bottom = currentResult[2];
               }
           }
       }
             System.out.println("MaxSum: " + maxSum +
                              ", range: [(" + left + ", " + top +
                                ")(" + right + ", " + bottom + ")]");
   }
