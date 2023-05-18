package dataNoBase;

import java.util.List;

public class UserDAO {

    public static void insertUser(User user) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        PersonDAO.insertPerson(user);
    }

    public static List<Person> getAllUsers() {
        PersonDAO.setTableName("user");
        PersonDAO.setIdColumnName("uid");
        PersonDAO.setNameColumnName("username");
        return PersonDAO.getAllPersons();
    }

    public static User getUserByUsername(String username) {
        PersonDAO.setTableName("user");
        PersonDAO.setIdColumnName("uid");
        PersonDAO.setNameColumnName("username");
        return (User) PersonDAO.getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteUserByUsername(String username) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        PersonDAO.deletePersonByName(username);
    }
}
