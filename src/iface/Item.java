package iface;

public interface Item {
    /**
     * @return the name of an item
     */
    public String name();

    /**
     * @return the category of an item
     */
    public String category();

    /**
     * @return the description of an item
     */
    public String description();

    /**
     * @return the number of inventory
     */
    public int inventory();

    /**
     * @return the paths of performing image
     */
    public String[] IMGs();

    /**
     * @return the price of an item
     */
    public int price();
}
