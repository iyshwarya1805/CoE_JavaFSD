package techm_ass;
import java.util.*;

class Task {
    String id;
    String description;
    int priority;

    public Task(String id, String description, int priority) {
        this.id = id;
        this.description = description;
        this.priority = priority;
    }

    public String toString() {
        return "ID: " + id + ", Description: " + description + ", Priority: " + priority;
    }
}

class TaskManager {
    private PriorityQueue<Task> taskQueue;
    private Map<String, Task> taskMap;

    public TaskManager() {
        taskQueue = new PriorityQueue<>(Comparator.comparingInt(t -> -t.priority));
        taskMap = new HashMap<>();
    }

    public void addTask(String id, String description, int priority) {
        if (!taskMap.containsKey(id)) {
            Task task = new Task(id, description, priority);
            taskQueue.add(task);
            taskMap.put(id, task);
        }
    }

    public void removeTask(String id) {
        Task task = taskMap.remove(id);
        if (task != null) {
            taskQueue.remove(task);
        }
    }

    public Task getHighestPriorityTask() {
        return taskQueue.peek();
    }

    public void displayTasks() {
        if (taskQueue.isEmpty()) {
            System.out.println("No tasks available.");
        } else {
            for (Task task : taskQueue) {
                System.out.println(task);
            }
        }
    }
}

public class TaskManagerCollections
{
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        TaskManager manager = new TaskManager();
        
        while (true) {
            System.out.println("\n1. Add Task");
            System.out.println("2. Remove Task");
            System.out.println("3. Get Highest Priority Task");
            System.out.println("4. Display All Tasks");
            System.out.println("5. Exit");
            System.out.print("Enter choice: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter Task ID: ");
                    String id = scanner.nextLine();
                    System.out.print("Enter Description: ");
                    String description = scanner.nextLine();
                    System.out.print("Enter Priority: ");
                    int priority = scanner.nextInt();
                    manager.addTask(id, description, priority);
                    break;
                    
                case 2:
                    System.out.print("Enter Task ID to remove: ");
                    String removeId = scanner.nextLine();
                    manager.removeTask(removeId);
                    break;
                    
                case 3:
                    Task highest = manager.getHighestPriorityTask();
                    System.out.println(highest != null ? "Highest Priority Task: " + highest : "No tasks available.");
                    break;
                    
                case 4:
                    manager.displayTasks();
                    break;
                    
                case 5:
                    System.out.println("Exiting...");
                    scanner.close();
                    return;
                    
                default:
                    System.out.println("Invalid choice, try again.");
            }
        }
    }
}