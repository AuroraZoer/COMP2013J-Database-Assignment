import dataNoBase.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection test = JDBCTool.getConnection();
//        System.out.println(test.isValid(1));

        // 添加交易记录
//        TransactionDAO.addTransaction(1, 16, 5);

        // 获取指定用户的交易记录
        List<Transaction> userTransactions = TransactionDAO.getUserTransactions(16, 1);
        for (Transaction transaction : userTransactions) {
            System.out.println(transaction.getTid());
            System.out.println(transaction.getCid());
            System.out.println(transaction.getQuantity());
            System.out.println(transaction.getTotal());
            System.out.println(transaction.isPaid());
            System.out.println("------------------------");
        }

//        TransactionDAO.updateTransactionPaymentStatus(1);
    }
}