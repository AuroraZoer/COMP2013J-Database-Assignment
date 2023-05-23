package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommodityDAO {
    /**
     * Inserts a new commodity into the database.
     *
     * @param commodity The Commodity object representing the commodity to be inserted.
     */
    public static void insertCommodity(Commodity commodity) {
        String sql = "INSERT INTO commodity (itemName, category, price, stock, isAvailable) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, commodity.getItemName());
            pstmt.setString(2, commodity.getCategory());
            pstmt.setFloat(3, commodity.getPrice());
            pstmt.setInt(4, commodity.getStock());
            pstmt.setBoolean(5, commodity.isAvailable());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves all commodities from the database.
     *
     * @return A List of Commodity objects representing all the commodities in the database.
     */
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
                boolean isAvailable = rs.getBoolean("isAvailable");
                commodities.add(new Commodity(cid, itemName, category, price, stock, isAvailable));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    /**
     * Updates a commodity in the database.
     *
     * @param commodity The Commodity object representing the updated commodity.
     */
    public static void updateCommodity(Commodity commodity) {
        String sql = "UPDATE commodity SET itemName = ?, category = ?, price = ?, stock = ?, isAvailable = ? WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, commodity.getItemName());
            pstmt.setString(2, commodity.getCategory());
            pstmt.setFloat(3, commodity.getPrice());
            pstmt.setInt(4, commodity.getStock());
            pstmt.setBoolean(5, commodity.isAvailable());
            pstmt.setInt(6, commodity.getCid());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a commodity from the database.
     *
     * @param cid The ID of the commodity to be deleted.
     */
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

    /**
     * Retrieves commodities based on the category, with pagination support.
     *
     * @param category   The category to filter the commodities.
     * @param pageNumber The page number for pagination (starting from 1).
     * @return A List of Commodity objects representing the filtered commodities.
     */
    public static List<Commodity> getCommoditiesByCategory(String category, int pageNumber) {
        List<Commodity> commodities = new ArrayList<>();
        String sql = "SELECT * FROM commodity WHERE category = ? LIMIT 10 OFFSET ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category);
            pstmt.setInt(2, (pageNumber - 1) * 10);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int cid = rs.getInt("cid");
                    String itemName = rs.getString("itemName");
                    float price = rs.getFloat("price");
                    int stock = rs.getInt("stock");
                    boolean isAvailable = rs.getBoolean("isAvailable");
                    commodities.add(new Commodity(cid, itemName, category, price, stock, isAvailable));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    /**
     * Retrieves available commodities by category from the database.
     *
     * @param category   The category to filter the commodities.
     * @return A List of Commodity objects representing the available commodities in the specified category.
     */
    public static List<Commodity> getAvailableCommoditiesByCategory(String category) {
        List<Commodity> commodities = new ArrayList<>();
        String sql = "SELECT * FROM commodity WHERE category = ? AND isAvailable = ? LIMIT 10";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category);
            pstmt.setBoolean(2, true);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int cid = rs.getInt("cid");
                    String itemName = rs.getString("itemName");
                    float price = rs.getFloat("price");
                    int stock = rs.getInt("stock");
                    boolean isAvailable = rs.getBoolean("isAvailable");
                    commodities.add(new Commodity(cid, itemName, category, price, stock, isAvailable));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    /**
     * Retrieves a commodity by its ID.
     *
     * @param cid The ID of the commodity to retrieve.
     * @return The Commodity object if found, null otherwise.
     */
    public static Commodity getCommodityByCid(int cid) {
        String sql = "SELECT * FROM commodity WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cid);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String itemName = rs.getString("itemName");
                    String category = rs.getString("category");
                    float price = rs.getFloat("price");
                    int stock = rs.getInt("stock");
                    boolean isAvailable = rs.getBoolean("isAvailable");
                    return new Commodity(cid, itemName, category, price, stock, isAvailable);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves available commodities from the database.
     *
     * @return A List of Commodity objects representing the available commodities.
     */
    public static List<Commodity> getAvailableCommodities() {
        List<Commodity> commodities = new ArrayList<>();
        String sql = "SELECT * FROM commodity WHERE isAvailable = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, true);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int cid = rs.getInt("cid");
                    String itemName = rs.getString("itemName");
                    String category = rs.getString("category");
                    float price = rs.getFloat("price");
                    int stock = rs.getInt("stock");
                    boolean isAvailable = rs.getBoolean("isAvailable");
                    commodities.add(new Commodity(cid, itemName, category, price, stock, isAvailable));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    /**
     * Retrieves unavailable commodities from the database.
     *
     * @return A List of Commodity objects representing the unavailable commodities.
     */
    public static List<Commodity> getUnavailableCommodities() {
        List<Commodity> commodities = new ArrayList<>();
        String sql = "SELECT * FROM commodity WHERE isAvailable = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, false);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int cid = rs.getInt("cid");
                    String itemName = rs.getString("itemName");
                    String category = rs.getString("category");
                    float price = rs.getFloat("price");
                    int stock = rs.getInt("stock");
                    boolean isAvailable = rs.getBoolean("isAvailable");
                    commodities.add(new Commodity(cid, itemName, category, price, stock, isAvailable));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commodities;
    }

    /**
     * Updates the availability of a commodity in the database.
     *
     * @param cid        The ID of the commodity to update.
     * @param isAvailable The availability status of the commodity.
     */
    public static void updateCommodityAvailability(int cid, boolean isAvailable) {
        String sql = "UPDATE commodity SET isAvailable = ? WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBoolean(1, isAvailable);
            pstmt.setInt(2, cid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


}
