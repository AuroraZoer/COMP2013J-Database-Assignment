package dataNoBase;

public class User extends Person {
    public User() {
        super();
    }

    public User(int id, String name, String password, String email, java.sql.Timestamp createTime) {
        super(id, name, password, email, createTime);
    }
}
