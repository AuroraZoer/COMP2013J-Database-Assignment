package dataNoBase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public static void insertAdmin(Admin admin) {
        String sql = "INSERT INTO admin (admin_name, password, email) VALUES (?, ?, ?)";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, admin.getAdminName());
            pstmt.setString(2, admin.getPassword());
            pstmt.setString(3, admin.getEmail());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Admin> getAllAdmins() {
        String sql = "SELECT * FROM admin";
        List<Admin> admins = new ArrayList<>();
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Admin admin = new Admin();
                admin.setId(rs.getInt("aid"));
                admin.setAdminName(rs.getString("admin_name"));
                admin.setPassword(rs.getString("password"));
                admin.setEmail(rs.getString("email"));
                admin.setCreateTime(rs.getTimestamp("create_time"));
                admins.add(admin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }
}