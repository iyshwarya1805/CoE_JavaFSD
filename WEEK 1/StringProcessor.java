package techm_ass;
import java.util.*;

public class StringProcessor {
	public static String reverseString(String str)
	{
		String temp="";
		for(int i=str.length()-1;i>=0;i--)
		{
			temp=temp+str.charAt(i);
		}
		return temp;
		
	}
	
	public static int countOccurrences(String text,String sub)
	{
		int count=0;
		int index=text.indexOf(sub);
		while(index!=-1)
		{
			count++;
			index=text.indexOf(sub,index+sub.length());
		}
		return count;
	}
	public static String splitAndCapitalize(String str)
	{
		String[] temp=str.split(" ");
		String res="";
		for(int i=0;i<temp.length;i++)
		{
			res=res+temp[i].substring(0,1).toUpperCase()+temp[i].substring(1).toLowerCase();
		}
		return res;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner s=new Scanner(System.in);
		System.out.println("Enter the string:");
		String str=s.nextLine();
		String res1=reverseString(str);
		System.out.println("The reverse of the string is:"+res1);
		
		System.out.println("Enter text");
		String text=s.nextLine();
		System.out.println("Enter substring to find how many times it occurs in the text:");
		String sub=s.nextLine();
		int res2=countOccurrences(text,sub);
		System.out.println("The substring appears "+res2+" times");
		
		System.out.println("Enter a sentence:");
		String str2=s.nextLine();
		String res3=splitAndCapitalize(str2);
		System.out.println("Result:"+res3);
		
		
		
		

	}

}
