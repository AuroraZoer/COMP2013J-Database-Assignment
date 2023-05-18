import dataNoBase.*;

import java.sql.Connection;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws SQLException {
        Connection test = JDBCTool.getConnection();
        System.out.println(test.isValid(1));
        System.out.println(CommodityDAO.getCommoditiesByCategory("Drink", 1).size());
    }

}