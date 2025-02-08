package ass2;

import java.util.*;
import java.io.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


class InventoryManager {
    private Map<String, Product> products = new ConcurrentHashMap<>();
    private PriorityQueue<Order> orderQueue = new PriorityQueue<>();
    private ExecutorService executorService = Executors.newFixedThreadPool(3);
    private final String FILE_NAME = "inventory_data.ser";

    public InventoryManager() { loadInventory(); }

    public synchronized void addProduct(Product product) {
        products.put(product.getProductID(), product);
        System.out.println("Product added: " + product);
        saveInventory();
    }

    public void searchProduct(String name) {
        boolean found = false;
        for (Product product : products.values()) {
            if (product.getName().equalsIgnoreCase(name)) {
                System.out.println(product);
                found = true;
            }
        }
        if (!found) {
            System.out.println("Product '" + name + "' not found in inventory.");
        }
    }

    public void placeOrder(Order order) {
        orderQueue.add(order);
        System.out.println("Order placed: " + order.getOrderID() + " with priority " + order.getPriority());
    }

    public void processOrders() {
        while (!orderQueue.isEmpty()) {
            Order order = orderQueue.poll();
            if (order != null) {
                executorService.execute(() -> fulfillOrder(order));
            }
        }
        executorService.shutdown();
    }

    private void fulfillOrder(Order order) {
        System.out.println("Processing order: " + order.getOrderID());
        for (String productID : order.getProductIDs()) {
            Product product = products.get(productID);
            if (product != null) {
                try {
                    product.reduceStock(1);
                    System.out.println("Shipped: " + product.getName());
                } catch (OutOfStockException e) {
                    System.out.println("Order failed: " + e.getMessage());
                }
            }
        }
        saveInventory();
    }

    private void saveInventory() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_NAME))) {
            oos.writeObject(products);
        } catch (IOException e) {
            System.out.println("Error saving inventory.");
        }
    }

    @SuppressWarnings("unchecked")
    private void loadInventory() {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_NAME))) {
            products = (ConcurrentHashMap<String, Product>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            System.out.println("No previous inventory found. Starting fresh.");
        }
    }
}
