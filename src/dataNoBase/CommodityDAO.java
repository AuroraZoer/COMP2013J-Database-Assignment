package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CommodityDAO {
    public static void insertCommodity(Commodity commodity) {
        String sql = "INSERT INTO commodity (itemName, category, price, stock) VALUES (?, ?, ?, ?)";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, commodity.getItemName());
            pstmt.setString(2, commodity.getCategory());
            pstmt.setFloat(3, commodity.getPrice());
            pstmt.setInt(4, commodity.getStock());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public static List<Commodity> getAllCommodities() {
        List<Commodity> commodities = new ArrayList<>();
        String sql = "SELECT * FROM commodity";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                int cid = rs.getInt("cid");
                String itemName = rs.getString("itemName");
                String category = rs.getString("category");
                float price = rs.getFloat("price");
                int stock = rs.getInt("stock");
                commodities.add(new Commodity(cid, itemName, category, price, stock));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    public static void updateCommodity(Commodity commodity) {
        String sql = "UPDATE commodity SET itemName = ?, category = ?, price = ?, stock = ? WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, commodity.getItemName());
            pstmt.setString(2, commodity.getCategory());
            pstmt.setFloat(3, commodity.getPrice());
            pstmt.setInt(4, commodity.getStock());
            pstmt.setInt(5, commodity.getCid());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteCommodity(int cid) {
        String sql = "DELETE FROM commodity WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
