package dataNoBase;

public class User {
    private int uid;
    private String username;
    private String password;
    private String email;
    private java.sql.Timestamp createTime;
    public User(){
    }

    public User(int uid, String username, String password, String email, java.sql.Timestamp createTime) {
        this.uid = uid;
        this.username = username;
        this.password = password;
        this.email = email;
        this.createTime = createTime;
    }

    public int getId() {
        return uid;
    }

    public void setId(int id) {
        this.uid = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

}
