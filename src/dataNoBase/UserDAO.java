package dataNoBase;

import java.util.ArrayList;
import java.util.List;

public class UserDAO extends PersonDAO{
    public static void insertUser(User user) {
        setTableName("user");
        setNameColumnName("username");
        insertPerson(user);
    }

    public static List<Person> getAllUsers() {
        setTableName("user");
        setIdColumnName("uid");
        setNameColumnName("username");
        return getAllPersons();
    }

    public static User getUserByUsername(String username) {
        setTableName("user");
        setIdColumnName("uid");
        setNameColumnName("username");
        return (User) getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        setTableName("user");
        setNameColumnName("username");
        return isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteUserByUsername(String username) {
        setTableName("user");
        setNameColumnName("username");
        deletePersonByName(username);
    }

    public static List<User> getUsersByPage(int pageNumber) {
        setTableName("user");
        setIdColumnName("uid");
        setNameColumnName("username");
        List<Person> persons = getPersonsByPage(pageNumber);
        List<User> users = new ArrayList<>();
        for (Person person : persons) {
            users.add((User) person);
        }
        return users;
    }
}