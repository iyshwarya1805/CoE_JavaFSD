package techm_ass;
import java.io.*;
import java.util.*;

class User {
    private String name;
    private String email;

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    public String toString() {
        return name + "," + email;
    }

    public static User fromString(String line) {
        String[] parts = line.split(",");
        if (parts.length == 2) {
            return new User(parts[0].trim(), parts[1].trim());
        }
        return null;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}

class UserManager {
    private List<User> users = new ArrayList<>();

    public void addUser(String name, String email) {
        users.add(new User(name, email));
    }

    public void saveUsersToFile(String filename) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (User user : users) {
                writer.write(user.toString());
                writer.newLine();
            }
            System.out.println("Users saved successfully.");
        } catch (IOException e) {
            System.out.println("Error saving users to file.");
        }
    }

    public void loadUsersFromFile(String filename) {
        users.clear();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromString(line);
                if (user != null) {
                    users.add(user);
                }
            }
            System.out.println("Users loaded successfully.");
        } catch (IOException e) {
            System.out.println("Error loading users from file.");
        }
    }

    public void displayUsers() {
        if (users.isEmpty()) {
            System.out.println("No users found.");
        } else {
            System.out.println("\nUser List:");
            for (User user : users) {
                System.out.println("Name: " + user.getName() + ", Email: " + user.getEmail());
            }
        }
    }
}

public class UserManagementSystem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        UserManager userManager = new UserManager();
        String filename = "users.txt";

        while (true) {
            System.out.println("\n1. Add User");
            System.out.println("2. Save Users to File");
            System.out.println("3. Load Users from File");
            System.out.println("4. Display Users");
            System.out.println("5. Exit");
            System.out.print("Enter choice: ");

            if (!scanner.hasNextInt()) {
                System.out.println("Invalid input! Please enter a number between 1 and 5.");
                scanner.next();
                continue;
            }

            int choice = scanner.nextInt();
            scanner.nextLine(); 

            switch (choice) {
                case 1:
                    System.out.print("Enter name: ");
                    String name = scanner.nextLine().trim();
                    System.out.print("Enter email: ");
                    String email = scanner.nextLine().trim();
                    userManager.addUser(name, email);
                    System.out.println("User added successfully.");
                    break;
                case 2:
                    userManager.saveUsersToFile(filename);
                    break;
                case 3:
                    userManager.loadUsersFromFile(filename);
                    break;
                case 4:
                    userManager.displayUsers();
                    break;
                case 5:
                    System.out.println("Exiting program...");
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid choice! Please enter a number between 1 and 5.");
            }
        }
    }
}