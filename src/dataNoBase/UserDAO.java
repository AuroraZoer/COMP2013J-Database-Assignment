package dataNoBase;

import java.util.List;

public class UserDAO extends PersonDAO {

    public UserDAO() {
        super("user", "uid", "username");
    }

    @Override
    public List<Person> getAllPersons() {
        return super.getAllPersons();
    }

    // Other specific methods for UserDAO
}

