package ass2;

import java.util.List;

class Order implements Comparable<Order> {
    private String orderID;
    private List<String> productIDs;
    private Priority priority;

    public enum Priority { STANDARD, EXPEDITED }

    public Order(String orderID, List<String> productIDs, Priority priority) {
        this.orderID = orderID;
        this.productIDs = productIDs;
        this.priority = priority;
    }

    public String getOrderID() { return orderID; }
    public List<String> getProductIDs() { return productIDs; }
    public Priority getPriority() { return priority; }

    @Override
    public int compareTo(Order o) {
        return this.priority == Priority.EXPEDITED && o.priority == Priority.STANDARD ? -1 : 1;
    }
}