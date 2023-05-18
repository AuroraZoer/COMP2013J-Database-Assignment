package dataNoBase;

public class Person {
    private int id;
    private String name;
    private String password;
    private String email;
    private java.sql.Timestamp createTime;
    private int  type; // Added type attribute: 0 admin; 1 user

    public Person() {
    }

    public Person(int id, String name, String password, String email, java.sql.Timestamp createTime, int type) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.createTime = createTime;
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public java.sql.Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(java.sql.Timestamp createTime) {
        this.createTime = createTime;
    }

    public int  getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
