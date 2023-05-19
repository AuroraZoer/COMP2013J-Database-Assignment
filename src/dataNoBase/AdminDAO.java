package dataNoBase;

import java.util.ArrayList;
import java.util.List;

public class AdminDAO extends PersonDAO{
    public static void insertAdmin(Admin admin) {
        setTableName("admin");
        setNameColumnName("admin_name");
        insertPerson(admin);
    }

    public static List<Person> getAllAdmins() {
        setTableName("admin");
        setIdColumnName("aid");
        setNameColumnName("admin_name");
        return getAllPersons();
    }

    public static Admin getAdminByUsername(String username) {
        setTableName("admin");
        setIdColumnName("aid");
        setNameColumnName("admin_name");
        return (Admin) getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        setTableName("admin");
        setNameColumnName("admin_name");
        return isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteAdminByUsername(String username) {
        setTableName("admin");
        setNameColumnName("admin_name");
        deletePersonByName(username);
    }

    public static List<Admin> getAdminsByPage(int pageNumber) {
        setTableName("user");
        setIdColumnName("uid");
        setNameColumnName("username");
        List<Person> persons = getPersonsByPage(pageNumber);
        List<Admin> admins = new ArrayList<>();
        for (Person person : persons) {
            admins.add((Admin) person);
        }
        return admins;
    }
}
