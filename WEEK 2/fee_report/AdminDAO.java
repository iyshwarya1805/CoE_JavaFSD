package fee_report;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class AdminDAO 
{
    private Connection conn = DBConnection.getConnection();
    private Scanner s = new Scanner(System.in);

    
    public void addAccountant() {
        System.out.print("Enter Accountant Name: ");
        String name = s.nextLine();
        System.out.print("Enter Email: ");
        String email = s.nextLine();
        System.out.print("Enter Phone: ");
        String phone = s.nextLine();
        System.out.print("Enter Password: ");
        String password = s.nextLine();

        String sql = "insert into accountant (name, email, phone, password) values (?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, password);
            pstmt.executeUpdate();
            System.out.println("Accountant added successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

   
    public void viewAccountant() {
        String sql = "select * from accountant";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id") + ", Name: " + rs.getString("name") +
                        ", Email: " + rs.getString("email") + ", Phone: " + rs.getString("phone"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
