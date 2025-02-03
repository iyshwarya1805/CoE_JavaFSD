package techm_ass;
public class BinTree {

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int val) {
            this.val = val;
        }
    }

    public static String serialize(TreeNode root) {
        StringBuilder result = new StringBuilder();
        serializeHelper(root, result);
        return result.toString();
    }

    private static void serializeHelper(TreeNode node, StringBuilder result) {
        if (node == null) {
            result.append("#,"); 
            return;
        }
        result.append(node.val).append(","); 
        serializeHelper(node.left, result); 
        serializeHelper(node.right, result); 
    }

    
    public static TreeNode deserialize(String data) {
        String[] values = data.split(",");
        int[] index = { 0 }; 
        return deserializeHelper(values, index);
    }

    private static TreeNode deserializeHelper(String[] values, int[] index) {
        if (index[0] >= values.length || values[index[0]].equals("#")) {
            index[0]++; 
            return null; 
        }

        TreeNode node = new TreeNode(Integer.parseInt(values[index[0]]));
        index[0]++; 
        node.left = deserializeHelper(values, index); 
        node.right = deserializeHelper(values, index); 

        return node;
    }

    
    public static void printTree(TreeNode root) {
        if (root == null) {
            System.out.print("null ");
            return;
        }
        System.out.print(root.val + " ");
        printTree(root.left);
        printTree(root.right);
    }

    public static void main(String[] args) {
        
        TreeNode root = new TreeNode(1);
        root.left = new TreeNode(2);
        root.right = new TreeNode(3);
        root.left.left = new TreeNode(4);
        root.left.right = new TreeNode(5);

        System.out.println("Original Tree (Pre-order): ");
        printTree(root);
        System.out.println();

        String serializedData = serialize(root);
        System.out.println("Serialized Data: " + serializedData);

        TreeNode deserializedRoot = deserialize(serializedData);

        System.out.println("Deserialized Tree (Pre-order): ");
        printTree(deserializedRoot);
        System.out.println();
    }
}