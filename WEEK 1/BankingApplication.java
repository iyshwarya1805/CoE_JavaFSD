package techm_ass;
import java.util.Scanner;

class BankAccount {
    private double balance;

    public BankAccount(double initialBalance) {
        this.balance = initialBalance;
    }

    public synchronized void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("Deposited: " + amount + ", New Balance: " + balance);
        }
    }

    public synchronized void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.println("Withdrawn: " + amount + ", New Balance: " + balance);
        } else {
            System.out.println("Insufficient funds for withdrawal.");
        }
    }

    public double getBalance() {
        return balance;
    }
}

class TransactionThread extends Thread {
    private BankAccount account;
    private boolean isDeposit;
    private double amount;

    public TransactionThread(BankAccount account, boolean isDeposit, double amount) {
        this.account = account;
        this.isDeposit = isDeposit;
        this.amount = amount;
    }

    public void run() {
        if (isDeposit) {
            account.deposit(amount);
        } else {
            account.withdraw(amount);
        }
    }
}

public class BankingApplication {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        BankAccount account = new BankAccount(1000);

        while (true) {
            System.out.println("\n1. Deposit");
            System.out.println("2. Withdraw");
            System.out.println("3. Check Balance");
            System.out.println("4. Exit");
            System.out.print("Enter choice: ");
            
            if (!scanner.hasNextInt()) {
                System.out.println("Invalid input! Please enter a number between 1 and 4.");
                scanner.next(); 
                continue;
            }

            int choice = scanner.nextInt();

            if (choice == 4) break;
            if (choice < 1 || choice > 4) {
                System.out.println("Invalid choice! Please enter a number between 1 and 4.");
                continue;
            }

            if (choice == 3) {
                System.out.println("Balance: " + account.getBalance());
                continue;
            }

            System.out.print("Enter amount: ");
            if (!scanner.hasNextDouble()) {
                System.out.println("Invalid amount! Please enter a valid number.");
                scanner.next(); 
                continue;
            }

            double amount = scanner.nextDouble();

            TransactionThread transaction;
            if (choice == 1) {
                transaction = new TransactionThread(account, true, amount);
            } else {
                transaction = new TransactionThread(account, false, amount);
            }

            transaction.start();
            try {
                transaction.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        scanner.close();
    }
}