package techm_ass;
import java.util.*;

class AnagramFinder {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();
        if (s.length() < p.length()) {
            return result;
        }

        int[] pCount = new int[26];
        int[] sCount = new int[26];

        for (char c : p.toCharArray()) {
            pCount[c - 'a']++;
        }

        int windowSize = p.length();
        for (int i = 0; i < s.length(); i++) {
            sCount[s.charAt(i) - 'a']++;

            if (i >= windowSize) {
                sCount[s.charAt(i - windowSize) - 'a']--;
            }

            if (Arrays.equals(pCount, sCount)) {
                result.add(i - windowSize + 1);
            }
        }

        return result;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter string s: ");
        String s = scanner.nextLine();

        System.out.print("Enter string p: ");
        String p = scanner.nextLine();

        AnagramFinder finder = new AnagramFinder();
        List<Integer> indices = finder.findAnagrams(s, p);

        System.out.println("Anagram indices: " + indices);

        scanner.close();
    }
}