package dataNoBase;

import java.sql.Timestamp;

public class Person {
    private int id;
    private String name;
    private String password;
    private String email;
    private Timestamp createTime;

    public Person() {
    }

    public Person(int id, String name, String password, String email, Timestamp createTime) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.createTime = createTime;
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

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
}
