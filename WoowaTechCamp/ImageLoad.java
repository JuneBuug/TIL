package image;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;

public class ImageLoad {
 
	public static char[] charArray= new char[65536];
 
	public static void main(String args[]) throws IOException {
		byte[] b = new byte[2621440];
        FileInputStream input = new FileInputStream("/Users/woowabrothers/Desktop/5.tech");
        input.read(b);
        
//        
//        printHexStream(input,65536);
//        
      input.close();
      String str = bytesToHex(b);
//      System.out.println(str);
      charArray =str.toCharArray();
      
      char[] array2 = new char[8];
      int cnt =0;
      String str2 =" ";
      for(int i=0; i<charArray.length;i++) {
    	  	
    	    
    	    array2[i%8]=charArray[i];
    	    
    	    
    	    if(i%8==7) {

        	    if(cnt % 256==0) {
        	    	System.out.print("<div style=\"width:256px; height:1px; \">");
        	    }
    	    	 str2 ="<div style=\"width:1px;height:1px; float:left; background-color: #";
    	    	    for(int j=0; j<6;j++) {
    	    	    	    str2 += array2[j];
    	    	    }
    	    	    str2 += ";\"></div>";
    	    	    		
    	    	    System.out.print(str2);
    			cnt++;
    	    }
    	    
    	    if(cnt % 256==255) {
    	    	   System.out.print("</div>");
    	    }
      }
	    
	}
	
	public static void printHexStream(final InputStream inputStream, final int numberOfColumns) throws IOException{
	    long streamPtr=0;
	 
	    while (inputStream.available() > 0) { 
	        final long col = streamPtr++ % numberOfColumns;
	        
//	        System.out.printf("%02d ",inputStream.read());
	       
	        if (col == (numberOfColumns-1)) {
	            System.out.printf("\n");
	        }
	    }
	}

	private final static char[] hexArray = "0123456789ABCDEF".toCharArray();
	public static String bytesToHex(byte[] bytes) {
	    char[] hexChars = new char[bytes.length * 2];
	    for ( int j = 0; j < bytes.length; j++ ) {
	        int v = bytes[j] & 0xFF;
	        hexChars[j * 2] = hexArray[v >>> 4];
	        hexChars[j * 2 + 1] = hexArray[v & 0x0F];
	    }
	    return new String(hexChars);
	}

}
