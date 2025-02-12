package fee_report;
import java.util.*;

public class Main 
{
    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        AdminDAO adminDAO = new AdminDAO();
        AccountantDAO accountantDAO = new AccountantDAO();

        while (true) {
            System.out.println("\n--- Fee Report Software --- \n 1. Admin Panel \n 2. Accountant Panel \n 3.Exit");           
            System.out.print("Enter your choice: ");
            int choice = s.nextInt();
            s.nextLine(); 

            switch (choice) {
                case 1:
                    System.out.println("\n--- Admin Panel --- \n 1. Add Accountant \n 2. View Accountants");
                    System.out.print("Enter your choice: ");
                    int adminChoice = s.nextInt();
                    s.nextLine(); 

                    if (adminChoice == 1) adminDAO.addAccountant();
                    else if (adminChoice == 2) adminDAO.viewAccountant();
                    break;

                case 2:
                    System.out.println("\n--- Accountant Panel --- \n 1. Add Student \n 2. Check Due Fee");
                    System.out.print("Enter your choice: ");
                    int accChoice = s.nextInt();
                    s.nextLine();

                    if (accChoice == 1) accountantDAO.addStudent();
                    else if (accChoice == 2) accountantDAO.checkDueFee();
                    break;

                case 3:
                    System.out.println("Exiting...");
                    System.exit(0);
            }
        }
    }
}
