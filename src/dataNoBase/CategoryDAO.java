package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    /**
     * Inserts a new category into the database.
     *
     * @param category The Category object representing the category to be inserted.
     */
    public static void insertCategory(Category category) {
        String sql = "INSERT INTO categories (category) VALUES (?)";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, category.getName());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves all categories from the database.
     *
     * @return A List of Category objects representing all the categories in the database.
     */
    public static List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                String name = rs.getString("category");
                categories.add(new Category(name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    /**
     * Updates the name of a category in the database.
     *
     * @param oldName The current name of the category.
     * @param newName The new name for the category.
     */
    public static void updateCategory(String oldName, String newName) {
        String sql = "UPDATE categories SET category = ? WHERE category = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newName);
            pstmt.setString(2, oldName);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a category from the database.
     *
     * @param name The name of the category to be deleted.
     */
    public static void deleteCategory(String name) {
        String sql = "DELETE FROM categories WHERE category = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
