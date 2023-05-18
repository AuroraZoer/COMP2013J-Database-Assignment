package dataNoBase;

import java.util.List;

public class UserDAO {

    public static void insertUser(User user) {
        PersonDAO.setTableName("user");
        PersonDAO.insertPerson(user);
    }

    public static List<Person> getAllUsers() {
        PersonDAO.setTableName("user");
        return PersonDAO.getAllPersons();
    }

    public static User getUserByUsername(String username) {
        PersonDAO.setTableName("user");
        return (User) PersonDAO.getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("user");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteUserByUsername(String username) {
        PersonDAO.setTableName("user");
        PersonDAO.deletePersonByName(username);
    }
}
