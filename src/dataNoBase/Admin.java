package dataNoBase;

public class Admin {
    private int aid;
    private String adminName;
    private String password;
    private String email;
    private java.sql.Timestamp createTime;

    public Admin(){
    }

    public Admin(int aid, String adminName, String password, String email, java.sql.Timestamp createTime) {
        this.aid = aid;
        this.adminName = adminName;
        this.password = password;
        this.email = email;
        this.createTime = createTime;
    }

    public int getId() {
        return aid;
    }

    public void setId(int id) {
        this.aid = id;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
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
