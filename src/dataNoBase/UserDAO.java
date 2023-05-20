package dataNoBase;

import java.util.List;

public class UserDAO{
    /**
     * Inserts a user into the database.
     *
     * @param user the user to insert
     */
    public static void insertUser(User user) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        PersonDAO.insertPerson(user);
    }

    /**
     * Retrieves a list of all users from the database.
     *
     * @return the list of all users
     */
    public static List<Person> getAllUsers() {
        PersonDAO.setTableName("user");
        PersonDAO.setIdColumnName("uid");
        PersonDAO.setNameColumnName("username");
        return PersonDAO.getAllPersons();
    }

    /**
     * Retrieves a user from the database based on the username.
     *
     * @param username the username of the user
     * @return the user object
     */
    public static User getUserByUsername(String username) {
        PersonDAO.setTableName("user");
        PersonDAO.setIdColumnName("uid");
        PersonDAO.setNameColumnName("username");
        return (User) PersonDAO.getPersonByName(username);
    }

    /**
     * Checks if the provided password is correct for the given user username.
     *
     * @param inputUsername the user username
     * @param inputPassword the password to check
     * @return true if the password is correct, false otherwise
     */
    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    /**
     * Deletes a user from the database based on the username.
     *
     * @param username the username of the user to delete
     */
    public static void deleteUserByUsername(String username) {
        PersonDAO.setTableName("user");
        PersonDAO.setNameColumnName("username");
        PersonDAO.deletePersonByName(username);
    }

    /**
     * Retrieves a list of users from the database based on the page number.
     *
     * @param pageNumber the page number
     * @return the list of users on the specified page
     */
    public static List<Person> getUsersByPage(int pageNumber) {
        PersonDAO.setTableName("user");
        PersonDAO.setIdColumnName("uid");
        PersonDAO.setNameColumnName("username");
        List<Person> persons = PersonDAO.getPersonsByPage(pageNumber);
        return persons;
    }
}