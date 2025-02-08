package ass1;
import java.util.*;
public class Main {
    public static void main(String[] args) {
    	Scanner scanner = new Scanner(System.in);
        LibraryManager library = new LibraryManager();
        library.loadData();

        
        library.addBook(new Book("Java Programming", "James Gosling", "1111"));
        library.addBook(new Book("Data Structures", "Robert Lafore", "2222"));
        library.addBook(new Book("Machine Learning", "Andrew Ng", "3333"));
        library.addBook(new Book("Operating System", "Greg", "4444"));
        library.addBook(new Book("Computer Networks", "Andrew", "5555"));
        library.addUser(new User("Asan", "A001"));
        library.addUser(new User("Banu", "B002"));
        library.addUser(new User("Cha", "C003"));
        

        while (true) {
            System.out.println("\nLibrary Menu:");
            System.out.println("1. Borrow Book");
            System.out.println("2. Return Book");
            System.out.println("3. Search Book");
            System.out.println("4. Exit & Save");
            System.out.print("Choose an option: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); 

            try {
                switch (choice) {
                    case 1:
                        System.out.print("Enter ISBN \n(1111-Java Programming\n2222-Data Structures\n3333-Machine Learning\n4444-Operating System\n5555-Computer Networks): ");
                        String borrowISBN = scanner.nextLine();
                        System.out.print("Enter User ID: ");
                        String borrowUserID = scanner.nextLine();
                        Thread borrowThread = new Thread(() -> {
                            try { library.borrowBook(borrowISBN, borrowUserID); } 
                            catch (Exception e) { System.out.println(e.getMessage()); }
                        });
                        borrowThread.start();
                        borrowThread.join();
                        break;

                    case 2:
                        System.out.print("Enter ISBN: ");
                        String returnISBN = scanner.nextLine();
                        System.out.print("Enter User ID: ");
                        String returnUserID = scanner.nextLine();
                        library.returnBook(returnISBN, returnUserID);
                        break;

                    case 3:
                        System.out.print("Enter Book Title: ");
                        String title = scanner.nextLine();
                        Book found = library.searchBook(title);
                        System.out.println(found != null ? "Book Found: " + found : "Book Not Found");
                        break;

                    case 4:
                        library.saveData();
                        System.out.println("Exiting...");
                        scanner.close();
                        return;

                    default:
                        System.out.println("Invalid choice!");
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
