package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TransactionDAO {

    // 添加交易记录
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

    // 计算交易总额
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

    // 获取指定用户的交易记录
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


}

