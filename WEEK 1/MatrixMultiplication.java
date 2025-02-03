package techm_ass;
import java.util.Scanner;

class MatrixMultiplier extends Thread {
    private int row, col;
    private int[][] matrixA, matrixB, result;

    public MatrixMultiplier(int row, int col, int[][] matrixA, int[][] matrixB, int[][] result) {
        this.row = row;
        this.col = col;
        this.matrixA = matrixA;
        this.matrixB = matrixB;
        this.result = result;
    }

    public void run() {
        int sum = 0;
        for (int i = 0; i < matrixA[0].length; i++) {
            sum += matrixA[row][i] * matrixB[i][col];
        }
        result[row][col] = sum;
    }
}

public class MatrixMultiplication {
    public static void multiplyMatrices(int[][] matrixA, int[][] matrixB, int[][] result) {
        int rows = matrixA.length;
        int cols = matrixB[0].length;
        Thread[][] threads = new Thread[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                threads[i][j] = new MatrixMultiplier(i, j, matrixA, matrixB, result);
                threads[i][j].start();
            }
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                try {
                    threads[i][j].join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter rows and columns of Matrix A: ");
        int rowsA = scanner.nextInt();
        int colsA = scanner.nextInt();

        int[][] matrixA = new int[rowsA][colsA];
        System.out.println("Enter elements of Matrix A:");
        for (int i = 0; i < rowsA; i++) {
            for (int j = 0; j < colsA; j++) {
                matrixA[i][j] = scanner.nextInt();
            }
        }

        System.out.print("Enter rows and columns of Matrix B: ");
        int rowsB = scanner.nextInt();
        int colsB = scanner.nextInt();

        if (colsA != rowsB) {
            System.out.println("Matrix multiplication not possible.");
            return;
        }

        int[][] matrixB = new int[rowsB][colsB];
        System.out.println("Enter elements of Matrix B:");
        for (int i = 0; i < rowsB; i++) {
            for (int j = 0; j < colsB; j++) {
                matrixB[i][j] = scanner.nextInt();
            }
        }

        int[][] result = new int[rowsA][colsB];

        multiplyMatrices(matrixA, matrixB, result);

        System.out.println("Result of matrix multiplication:");
        for (int i = 0; i < rowsA; i++) {
            for (int j = 0; j < colsB; j++) {
                System.out.print(result[i][j] + " ");
            }
            System.out.println();
        }

        scanner.close();
    }
}