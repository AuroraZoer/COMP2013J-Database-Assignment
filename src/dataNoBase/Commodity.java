package dataNoBase;

public class Commodity {
    private int cid;
    private String itemName;
    private String category;
    private float price;
    private int stock;
    private boolean isAvailable;

    public Commodity(int cid, String itemName, String category, float price, int stock, boolean isAvailable) {
        this.cid = cid;
        this.itemName = itemName;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.isAvailable = isAvailable;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }
}
