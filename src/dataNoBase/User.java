package dataNoBase;

public class User extends Person {

    public User() {
        setType(1); // Set the type as 1 for user
    }

    public User(int id, String name, String password, String email, java.sql.Timestamp createTime) {
        super(id, name, password, email, createTime, 1); // Set the type as 1 for user
    }
}
