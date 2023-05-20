package dataNoBase;

import java.util.List;

public class AdminDAO {

    /**
     * Inserts an admin into the database.
     *
     * @param admin the admin to insert
     */
    public static void insertAdmin(Admin admin) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        PersonDAO.insertPerson(admin);
    }

    /**
     * Retrieves a list of all admins from the database.
     *
     * @return the list of all admins
     */
    public static List<Person> getAllAdmins() {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        return PersonDAO.getAllPersons();
    }

    /**
     * Retrieves an admin from the database based on the username.
     *
     * @param username the username of the admin
     * @return the admin object
     */
    public static Admin getAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        return (Admin) PersonDAO.getPersonByName(username);
    }

    /**
     * Checks if the provided password is correct for the given admin username.
     *
     * @param inputUsername the admin username
     * @param inputPassword the password to check
     * @return true if the password is correct, false otherwise
     */
    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    /**
     * Deletes an admin from the database based on the username.
     *
     * @param username the username of the admin to delete
     */
    public static void deleteAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        PersonDAO.deletePersonByName(username);
    }

    /**
     * Retrieves a list of admins from the database based on the page number.
     *
     * @param pageNumber the page number
     * @return the list of admins on the specified page
     */
    public static List<Person> getaAdminsByPage(int pageNumber) {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        List<Person> persons = PersonDAO.getPersonsByPage(pageNumber);
        return persons;
    }

}
