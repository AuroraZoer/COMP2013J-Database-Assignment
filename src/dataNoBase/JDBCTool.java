package dataNoBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for managing database connections using JDBC.
 */
public class JDBCTool {

    private static final String userName = "Zoe";
    private static final String passWord = "7BybPneSwJHjzLRk";
    private static final String dbName = "zoe";

    /**
     * Retrieves a database connection using the specified URL, database name, username, and password.
     *
     * @param url      the URL of the database server
     * @param dbname   the name of the database
     * @param username the username for authentication
     * @param password the password for authentication
     * @return the database connection
     */
    public static Connection getConnection(String url, String dbname, String username, String password) {
        Connection conn = null;
        try {
            // Load the JDBC driver class
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the database connection
            conn = DriverManager.getConnection("jdbc:mysql://" + url + "/" + dbname, username, password);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * Retrieves a database connection using the default URL, database name, username, and password.
     *
     * @return the database connection
     */
    public static Connection getConnection() {
        return JDBCTool.getConnection("42.193.97.229", dbName, userName, passWord);
    }
}
