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

    // 删除交易记录
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

    // 修改交易记录的商品数量和总价
    public static void updateTransactionQuantity(int tid, int quantity) {
        String sql = "UPDATE `transaction` SET quantity = ?, total = ? WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            // 获取原始交易记录信息
            Transaction transaction = getTransactionById(tid);
            if (transaction == null) {
                return; // 交易记录不存在，不进行更新
            }

            // 计算新的总价
            float newTotal = calculateTotal(transaction.getCid(), quantity);

            pstmt.setInt(1, quantity);
            pstmt.setFloat(2, newTotal);
            pstmt.setInt(3, tid);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 根据交易记录ID获取单个交易记录
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

    // 更新交易记录的支付状态
    public static void updateTransactionPaymentStatus(int tid) {
        String sql = "UPDATE `transaction` SET is_paid = 1 WHERE tid = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, tid);
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
}

