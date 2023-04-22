import dataNoBase.JDBCTool;

import java.sql.Connection;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) throws SQLException {
        System.out.println("Hello world!");
        Connection test = JDBCTool.getConnection("");
        System.out.println(test.isClosed());
    }

}