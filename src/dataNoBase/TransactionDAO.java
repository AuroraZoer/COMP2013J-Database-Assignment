package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    /**
     * Adds a transaction record to the database.
     *
     * @param cid      Customer ID
     * @param uid      User ID
     * @param quantity Quantity of items
     */
    public static void addTransaction(int cid, int uid, int quantity) {
        String sql = "INSERT INTO `transaction` (cid, uid, quantity, total, is_paid) VALUES (?, ?, ?, ?, 0)";
        float total = calculateTotal(cid, quantity); // 计算交易总额
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cid);
            pstmt.setInt(2, uid);
            pstmt.setInt(3, quantity);
            pstmt.setFloat(4, total);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a transaction record from the database.
     *
     * @param tid Transaction ID
     */
    public static void deleteTransaction(int tid) {
        String sql = "DELETE FROM `transaction` WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves a list of transactions for a specific user.
     *
     * @param uid        User ID
     * @param pageNumber Page number for pagination
     * @return List of Transaction objects
     */
    public static List<Transaction> getUserTransactions(int uid, int pageNumber) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT * FROM `transaction` WHERE uid = ? ORDER BY tid DESC LIMIT 10 OFFSET ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, uid);
            pstmt.setInt(2, (pageNumber - 1) * 10);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    int tid = rs.getInt("tid");
                    int cid = rs.getInt("cid");
                    int quantity = rs.getInt("quantity");
                    float total = rs.getFloat("total");
                    boolean isPaid = rs.getBoolean("is_paid");
                    Transaction transaction = new Transaction(tid, uid, cid, quantity, total, isPaid);
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return transactions;
    }

    /**
     * Updates the quantity and total amount of a transaction.
     *
     * @param tid      Transaction ID
     * @param quantity New quantity of items
     */
    public static void updateTransactionQuantity(int tid, int quantity) {
        String sql = "UPDATE `transaction` SET quantity = ?, total = ? WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            // Retrieve the original transaction information
            Transaction transaction = getTransactionById(tid);
            if (transaction == null) {
                return; // Transaction does not exist, no updates needed
            }

            // Calculate the new total amount
            float newTotal = calculateTotal(transaction.getCid(), quantity);

            pstmt.setInt(1, quantity);
            pstmt.setFloat(2, newTotal);
            pstmt.setInt(3, tid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retrieves a single transaction by its ID.
     *
     * @param tid Transaction ID
     * @return Transaction object if found, null otherwise
     */
    public static Transaction getTransactionById(int tid) {
        String sql = "SELECT * FROM `transaction` WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tid);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int uid = rs.getInt("uid");
                    int cid = rs.getInt("cid");
                    int quantity = rs.getInt("quantity");
                    float total = rs.getFloat("total");
                    boolean isPaid = rs.getBoolean("is_paid");
                    return new Transaction(tid, uid, cid, quantity, total, isPaid);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Updates the payment status of a transaction to "paid".
     *
     * @param tid Transaction ID
     */
    public static void updateTransactionPaymentStatus(int tid) {
        String sql = "UPDATE `transaction` SET is_paid = 1 WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tid);
            pstmt.executeUpdate();

            // Retrieve the transaction information
            Transaction transaction = getTransactionById(tid);
            if (transaction == null || !transaction.isPaid()) {
                return; // Transaction does not exist or is not paid, no updates needed
            }

            // Update commodity stock based on the transaction quantity
            int cid = transaction.getCid();
            int quantity = transaction.getQuantity();
            Commodity commodity = CommodityDAO.getCommodityByCid(cid);
            if (commodity != null) {
                int updatedStock = commodity.getStock() - quantity;
                commodity.setStock(updatedStock);
                CommodityDAO.updateCommodity(commodity);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Calculates the total amount of a transaction based on the commodity price and quantity.
     *
     * @param cid      Commodity ID
     * @param quantity Quantity of items
     * @return Total amount of the transaction
     */
    private static float calculateTotal(int cid, int quantity) {
        String sql = "SELECT price FROM commodity WHERE cid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, cid);
            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                float price = resultSet.getFloat("price");
                return price * quantity;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

