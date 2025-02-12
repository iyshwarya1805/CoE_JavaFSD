package fee_report;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class AccountantDAO {
    private Connection conn = DBConnection.getConnection();
    private Scanner s = new Scanner(System.in);

    
    public void addStudent() 
    {
        System.out.print("Enter Student Name: ");
        String name = s.nextLine();
        System.out.print("Enter Email: ");
        String email = s.nextLine();
        System.out.print("Enter Course: ");
        String course = s.nextLine();
        System.out.print("Enter Total Fee: ");
        double fee = s.nextDouble();
        System.out.print("Enter Paid Fee: ");
        double paid = s.nextDouble();
        double due = fee - paid;
        s.nextLine(); 
        System.out.print("Enter Address: ");
        String address = s.nextLine();
        System.out.print("Enter Phone: ");
        String phone = s.nextLine();

        String sql = "insert into student (name, email, course, fee, paid, due, address, phone) values (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, course);
            pstmt.setDouble(4, fee);
            pstmt.setDouble(5, paid);
            pstmt.setDouble(6, due);
            pstmt.setString(7, address);
            pstmt.setString(8, phone);
            pstmt.executeUpdate();
            System.out.println("Student added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    
    public void checkDueFee() {
        String sql = "select * from student where due > 0";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                System.out.println("Student: " + rs.getString("name") + ", Due Fee: " + rs.getDouble("due"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
