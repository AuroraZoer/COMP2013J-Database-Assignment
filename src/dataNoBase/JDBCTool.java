package dataNoBase;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class JDBCTool {

    private static final String userName = "Zoe";
    private static final String passWord = "7BybPneSwJHjzLRk";
    private static final String dbName = "zoe";
    public static Connection getConnection(String url, String dbname, String username, String password) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://" + url + "/" + dbname, username, password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static Connection getConnection() {
        return JDBCTool.getConnection("42.193.97.229", dbName, userName, passWord);
    }


}