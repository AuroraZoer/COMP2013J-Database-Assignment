package dataNoBase;

public class Transaction {
    private int tid; // Transaction ID
    private int uid; // User ID
    private int cid; // Customer ID
    private int quantity; // Quantity of items
    private boolean isPaid; // Payment status: 1 if paid, 0 otherwise

    public Transaction(int tid, int uid, int cid, int quantity, boolean isPaid) {
        this.tid = tid;
        this.uid = uid;
        this.cid = cid;
        this.quantity = quantity;
        this.isPaid = isPaid;
    }

    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }
}
