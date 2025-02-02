package techm_ass;
import java.util.*;

public class ExceptionHandling {
	public static void processInput()
	{
		Scanner s=new Scanner(System.in);
		System.out.println("Enter a number:");
		try
		{
			double num=s.nextDouble();
			if (num == 0) {
                throw new ArithmeticException("No reciprocal for 0");
            }

            double reciprocal = 1.0 / num;
            System.out.println("The reciprocal of " + num + " is " + reciprocal);

        } 
		catch (NumberFormatException e) {
            System.out.println("Invalid input");

        } 
		catch (ArithmeticException e) {
            System.out.println("Error: " + e.getMessage());

		}
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		processInput();

	}

}
