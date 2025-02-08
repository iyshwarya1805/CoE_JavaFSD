package ass2;

import java.util.Comparator;

class OrderComparator implements Comparator<Order> {
    @Override
    public int compare(Order o1, Order o2) {
        return o1.getPriority().compareTo(o2.getPriority());
    }
}