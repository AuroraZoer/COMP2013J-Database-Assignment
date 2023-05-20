package dataNoBase;

import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public static void insertAdmin(Admin admin) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        PersonDAO.insertPerson(admin);
    }

    public static List<Person> getAllAdmins() {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        return PersonDAO.getAllPersons();
    }

    public static Admin getAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        return (Admin) PersonDAO.getPersonByName(username);
    }

    public static boolean isPasswordCorrect(String inputUsername, String inputPassword) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        return PersonDAO.isPasswordCorrect(inputUsername, inputPassword);
    }

    public static void deleteAdminByUsername(String username) {
        PersonDAO.setTableName("admin");
        PersonDAO.setNameColumnName("admin_name");
        PersonDAO.deletePersonByName(username);
    }

    public static List<Person> getaAdminsByPage(int pageNumber) {
        PersonDAO.setTableName("admin");
        PersonDAO.setIdColumnName("aid");
        PersonDAO.setNameColumnName("admin_name");
        List<Person> persons = PersonDAO.getPersonsByPage(pageNumber);
//        List<Admin> admins = new ArrayList<>();
//        for (Person person : persons) {
//            admins.add((Admin) person);
//        }
        return persons;
    }

}
