package techm_ass;
class LinkedList {
    static class Node {
        int data;
        Node next;
        
        Node(int data) {
            this.data = data;
            this.next = null;
        }
    }

    public boolean hasCycle(Node head) {
        if (head == null || head.next == null) {
            return false;
        }
        
        Node slow = head;
        Node fast = head;
        
        while (fast != null && fast.next != null) {
            slow = slow.next;
            fast = fast.next.next;
            
            if (slow == fast) {
                return true;
            }
        }
        return false;
    }

    public static void main(String[] args) {
        LinkedList list = new LinkedList();
        
        Node head = new Node(1);
        Node second = new Node(2);
        Node third = new Node(3);
        Node fourth = new Node(4);
        
        head.next = second;
        second.next = third;
        third.next = fourth;
        fourth.next = second; // Creating a cycle

        System.out.println("Cycle detected: " + list.hasCycle(head));
    }
}