package techm_ass;

import java.io.*;
import java.util.*;

class LogAnalyzer {
    private static final List<String> KEYWORDS = Arrays.asList("ERROR", "WARNING");

    public void analyzeLogFile(String inputFile, String outputFile) {
        File file = new File(inputFile);
        if (!file.exists()) {
            System.err.println("Error: File not found - " + file.getAbsolutePath());
            return;
        }

        Map<String, Integer> keywordCount = new HashMap<>();
        for (String keyword : KEYWORDS) {
            keywordCount.put(keyword, 0);
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(outputFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                for (String keyword : KEYWORDS) {
                    if (line.contains(keyword)) {
                        keywordCount.put(keyword, keywordCount.get(keyword) + 1);
                        writer.write(line);
                        writer.newLine();
                    }
                }
            }

            writer.write("\nSummary:\n");
            for (Map.Entry<String, Integer> entry : keywordCount.entrySet()) {
                writer.write(entry.getKey() + ": " + entry.getValue());
                writer.newLine();
            }

            System.out.println("Log analysis completed. Check output.txt");

        } catch (IOException e) {
            System.out.println("Error reading or writing file: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        LogAnalyzer analyzer = new LogAnalyzer();
        analyzer.analyzeLogFile("log.txt", "output.txt");
    }
}