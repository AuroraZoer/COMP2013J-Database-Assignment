package dataNoBase;

public class Transaction {
    private int tid;
    private int uid;
    private int cid;
    private int quantity;
    private float total;
    private boolean isPaid;  // is_paid：表示付款状态，如果付款了则为1，否则为0

    public Transaction(int tid, int uid, int cid, int quantity, float total, boolean isPaid) {
        this.tid = tid;
        this.uid = uid;
        this.cid = cid;
        this.quantity = quantity;
        this.total = total;
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

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public boolean isPaid() {
        return isPaid;
    }

    public void setPaid(boolean paid) {
        isPaid = paid;
    }
}

