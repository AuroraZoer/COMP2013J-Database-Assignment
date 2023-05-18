package dataNoBase;

import java.util.List;

public class AdminDAO extends PersonDAO {

    public AdminDAO() {
        super("admin", "aid", "admin_name");
    }

    @Override
    public List<Person> getAllPersons() {
        return super.getAllPersons(); // No need to override, as it's already implemented in the parent class
    }

    // Other specific methods for AdminDAO
}
