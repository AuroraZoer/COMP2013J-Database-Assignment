package iface;

public interface Shop {

    /**
     * return ten items depend on keyword and page.
     * @param keyword
     * @param page
     * @return
     */
    public Item[] getItems(String keyword, int page);

    /**
     * @return ten hot items
     */
    public Item[] getHot();
}
