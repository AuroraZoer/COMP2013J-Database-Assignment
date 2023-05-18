package dataNoBase;

public class Admin extends Person {

    public Admin() {
        setType(0); // Set the type as 0 for admin
    }

    public Admin(int id, String name, String password, String email, java.sql.Timestamp createTime) {
        super(id, name, password, email, createTime, 0); // Set the type as 0 for admin
    }
}
