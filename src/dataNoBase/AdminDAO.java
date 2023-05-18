package dataNoBase;

import java.util.List;

public class AdminDAO {

    public static void insertAdmin(Admin admin) {
        PersonDAO.setTableName("admin");
        PersonDAO.insertPerson(admin);
    }

    public static List<Person> getAllAdmins() {
        PersonDAO.setTableName("admin");
        return PersonDAO.getAllPersons();
    }

    public static Admin getAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        return (Admin) PersonDAO.getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("admin");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        PersonDAO.deletePersonByName(username);
    }
}
