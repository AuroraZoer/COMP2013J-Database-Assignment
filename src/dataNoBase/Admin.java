package dataNoBase;

public class Admin extends Person {
    public Admin() {
        super();
    }

    public Admin(int id, String name, String password, String email, java.sql.Timestamp createTime) {
        super(id, name, password, email, createTime);
    }
}
