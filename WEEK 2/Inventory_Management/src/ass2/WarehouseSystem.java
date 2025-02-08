package ass2;

import java.util.*;

public class WarehouseSystem {
    public static void main(String[] args) {
        InventoryManager inventoryManager = new InventoryManager();
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\n1. Add Product\n2. Search Product\n3. Place Order\n4. Process Orders\n5. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter Product ID: ");
                    String pid = scanner.next();
                    System.out.print("Enter Name: ");
                    String name = scanner.next();
                    System.out.print("Enter Quantity: ");
                    int qty = scanner.nextInt();
                    System.out.print("Enter Aisle: ");
                    int aisle = scanner.nextInt();
                    System.out.print("Enter Shelf: ");
                    int shelf = scanner.nextInt();
                    System.out.print("Enter Bin: ");
                    int bin = scanner.nextInt();
                    inventoryManager.addProduct(new Product(pid, name, qty, new Location(aisle, shelf, bin)));
                    break;

                case 2:
                    System.out.print("Enter Product Name: ");
                    String searchName = scanner.next();
                    inventoryManager.searchProduct(searchName);
                    break;

                case 3:
                    System.out.print("Enter Order ID: ");
                    String orderID = scanner.next();
                    System.out.print("Enter number of products in order: ");
                    int count = scanner.nextInt();
                    List<String> productIDs = new ArrayList<>();
                    for (int i = 0; i < count; i++) {
                        System.out.print("Enter Product ID " + (i + 1) + ": ");
                        productIDs.add(scanner.next());
                    }
                    System.out.print("Enter Priority (1 for STANDARD, 2 for EXPEDITED): ");
                    int priorityChoice = scanner.nextInt();
                    Order.Priority priority = priorityChoice == 2 ? Order.Priority.EXPEDITED : Order.Priority.STANDARD;
                    inventoryManager.placeOrder(new Order(orderID, productIDs, priority));
                    break;

                case 4:
                    inventoryManager.processOrders();
                    break;

                case 5:
                    System.out.println("Exiting Warehouse System...");
                    scanner.close();
                    System.exit(0);

                default:
                    System.out.println("Invalid choice, try again.");
            }
        }
    }
}