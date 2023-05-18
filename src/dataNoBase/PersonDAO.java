package dataNoBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PersonDAO {
    private static String tableName;
    private static String idColumnName;
    private static String nameColumnName;

    public static void setTableName(String tableName) {
        PersonDAO.tableName = tableName;
    }

    public static void setIdColumnName(String idColumnName) {
        PersonDAO.idColumnName = idColumnName;
    }

    public static void setNameColumnName(String nameColumnName) {
        PersonDAO.nameColumnName = nameColumnName;
    }

    public static void insertPerson(Person person) {
        String sql = "INSERT INTO " + tableName + " (" + nameColumnName + ", password, email) VALUES (?, ?, ?)";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, person.getName());
            pstmt.setString(2, person.getPassword());
            pstmt.setString(3, person.getEmail());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Person> getAllPersons() {
        String sql = "SELECT * FROM " + tableName;
        List<Person> persons = new ArrayList<>();
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Person person = createPersonInstance();
                person.setId(rs.getInt(idColumnName));
                person.setName(rs.getString(nameColumnName));
                person.setPassword(rs.getString("password"));
                person.setEmail(rs.getString("email"));
                person.setCreateTime(rs.getTimestamp("create_time"));
                persons.add(person);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return persons;
    }

    public static Person getPersonByName(String name) {
        String sql = "SELECT * FROM " + tableName + " WHERE " + nameColumnName + " = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Person person = createPersonInstance();
                    person.setId(rs.getInt(idColumnName));
                    person.setName(rs.getString(nameColumnName));
                    person.setPassword(rs.getString("password"));
                    person.setEmail(rs.getString("email"));
                    person.setCreateTime(rs.getTimestamp("create_time"));
                    return person;
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean isPasswordCorrect(String inputName, String inputPassword) {
        String sql = "SELECT password FROM " + tableName + " WHERE " + nameColumnName + " = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, inputName);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedPassword = rs.getString("password");
                    return storedPassword.equals(inputPassword);
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void deletePersonByName(String name) {
        String sql = "DELETE FROM " + tableName + " WHERE " + nameColumnName + " = ?";
        try (Connection conn = JDBCTool.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static Person createPersonInstance() {
        if (tableName.equals("user")) {
            return new User();
        } else if (tableName.equals("admin")) {
            return new Admin();
        }
        return null;
    }
}
