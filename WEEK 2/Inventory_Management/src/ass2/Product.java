package ass2;

import java.io.Serializable;

class Product implements Serializable {
    private String productID;
    private String name;
    private int quantity;
    private Location location;

    public Product(String productID, String name, int quantity, Location location) {
        this.productID = productID;
        this.name = name;
        this.quantity = quantity;
        this.location = location;
    }

    public String getProductID() { return productID; }
    public String getName() { return name; }
    public int getQuantity() { return quantity; }
    public Location getLocation() { return location; }

    public void reduceStock(int qty) throws OutOfStockException {
        if (quantity < qty) throw new OutOfStockException("Not enough stock for " + name);
        quantity -= qty;
    }

    @Override
    public String toString() {
        return "Product ID: " + productID + ", Name: " + name + ", Quantity: " + quantity + ", Location: " + location;
    }
}
