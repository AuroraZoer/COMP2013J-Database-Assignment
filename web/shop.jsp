<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
    if (session.isNew()) {
        session.setAttribute("referenced", "shop.jsp");
        response.sendRedirect("login.jsp");
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval() < 0) {
        session.setAttribute("referenced", "shop.jsp");
        response.sendRedirect("login.jsp");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
    Person person = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
//    用户不存在,返回登陆
    if (person == null){
        session.setAttribute("referenced", "shop.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
//    用户信息异常,返回登录
    if (person.getType()!= 1 && person.getType()!=0){
        session.setAttribute("referenced", "shop.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
//    登录状态异常,返回登录
    if (login_status==null || !login_status){
        session.setAttribute("referenced", "shop.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--recv parameters--%>
<%
    String keyword = request.getParameter("keyword");
    String page_str = request.getParameter("page_num");
    String category_str = request.getParameter("category_str");
    String create_category_name = request.getParameter("create_category_name");
    String delete_category_name = request.getParameter("delete_category_name");
    String add_transaction_number_str = request.getParameter("add_transaction_number");
    String add_transaction_cid_str = request.getParameter("add_transaction_cid");
%>

<%--NullPointerException && NumberFormatException--%>
<%
    int page_num = 1;
    int category_num = 1;
    int add_transaction_number = -1;
    int add_transaction_cid = -1;
    try {
        page_num = Integer.parseInt(page_str);
    } catch (Exception ignored) {

    }
    try {
        category_num = Integer.parseInt(category_str);
    } catch (Exception ignored) {
    }

    try {
        add_transaction_number = Integer.parseInt(add_transaction_number_str);
    } catch (Exception ignored) {
    }

    try {
        add_transaction_cid = Integer.parseInt(add_transaction_cid_str);
    } catch (Exception ignored) {
    }
%>

<%--check parameters invalid--%>
<%

%>

<%--parameters react--%>
<%
    if (create_category_name != null) {
        CategoryDAO.insertCategory(new Category(create_category_name));
    }

    if (delete_category_name != null) {
        CategoryDAO.deleteCategory(delete_category_name);
    }

    if (add_transaction_cid>0 && add_transaction_number>0){
        TransactionDAO.addTransaction(add_transaction_cid,person.getId(), add_transaction_number);
    }

%>

<%--pre-action--%>
<%
//    类别列表
    List<Category> categories = CategoryDAO.getAllCategories();
    
//    商品列表
    List<Commodity> commodities = null;
    if (keyword == null)
        commodities = CommodityDAO.getCommoditiesByCategory(categories.get(category_num - 1).getName(), page_num);
    else
        commodities = CommodityDAO.getCommoditiesByCategory(keyword, page_num);
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>


<html>
<head>
    <title>Shop</title>
    <link rel="stylesheet" href="css/shop.css">
    <style>
        #cate<%=category_num%> {
            /*    高亮显示span*/
        }
    </style>


</head>
<body>

<div class="whole">
    <div class="left_box">
        <div class="left_box_item">
            <%
                for (int i = 0; i < categories.size(); i++) {
                    Category category = categories.get(i);
            %>
            <div>
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="category_str" value="<%=i+1%>">
                    <button type="submit"><span><%=category.getName()%></span><br></button>
                </form>
                <% if (person.getType() == 0) {%>
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="delete_category_name" value="<%=category.getName()%>">
                    <input type="submit" value="Delete">
                </form>
                <%}%>
            </div>

            <%}%>

            <% if (person.getType() == 0) {%>
            <form action="shop.jsp" method="post">
                <label> Category:name
                    <input type="text" name="create_category_name">
                </label>
                <button type="submit">add</button>
            </form>

            <a href="manage.jsp">Click here to manage users</a>
            <%}%>
        </div>
    </div>

    <div class="mid_box">
        <div class="top_box">
            <div class="outer_search_box">
                <div class="left_input_box">
                    Please enter the category of the product you wish to search for:
                </div>
                <div class="right_input_box">
                    <form action="shop.jsp" method="get">
                        <div class="input_wrapper">
                            <input type="input_search" name="keyword" width="80000px" height="50px" spellcheck="false"
                                   placeholder="Drink">
                            <button type="submit">
                                <img src="img/search_icon.png" alt="搜索" width="40px" height="40px">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="main_box">
            <% for (Commodity commodity : commodities) { %>
            <div class="item_box">
                <div class="item_left_box">
                    <%=commodity.getCategory()%> <br>
                    <% if (person.getType() == 0) { %>
                    <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>">edit</a>
                    <% } %>
                </div>
                <div class="item_mid_box">
                    <div class="item_top_box">
                        <%=commodity.getItemName()%> <br>
                    </div>
                </div>
                <div class="item_right_box">
                    <div class="price-wrapper">
        <span class="price">
            ¥ <%=commodity.getPrice()%> <br>
        </span>
                    </div>
                    <% if (person.getType() == 0) { %>
                    <span class="stock">
                        Stock: <%=commodity.getStock()%> <br>
                    </span>
                    <% } else { %>
                    <form class="stock" action="shop.jsp" method="post">
                        <input type="number" name="add_transaction_number" min="1" max="<%=commodity.getStock()%>" step="1" placeholder="0">
                        <input type="hidden" name="category_str" value="<%=category_num%>">
                        <input type="hidden" name="page_num" value="<%=page_num%>">
                        <%if (keyword != null) {%>
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <%}%>
                        <input type="hidden" name="add_transaction_cid" value="<%=commodity.getCid()%>">
                        <input type="submit" value="add">
                    </form>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>

        <div class="pagination_box">
            <div class="last_page">
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="category_str" value="<%=category_num%>">
                    <input type="hidden" name="page_num" value="<%=page_num<=1?1:page_num-1 %>">
                    <%if (keyword != null) {%>
                    <input type="hidden" name="keyword" value="<%=keyword%>">
                    <%}%>
                    <input type="submit" value="last page">
                </form>
            </div>

            <div class="next_page">
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="category_str" value="<%=category_num%>">
                    <input type="hidden" name="page_num" value="<%=commodities.size()<10?page_num:page_num+1 %>">
                    <%if (keyword != null) {%>
                    <input type="hidden" name="keyword" value="<%=keyword%>">
                    <%}%>
                    <input type="submit" value="next page">
                </form>
            </div>
        </div>
    </div>


    <div class="right_box">
    <%--    用户界面--%>
        <div class="user">
            <a href="userMain.jsp">
                <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
            </a>
        </div>
        <div class="user_type">
            <%=person.getType()==1?"customer":"admin"%>
        </div>
        <%--    购物车--%>
        <div class="shopping_car">
            <%
                if (person.getType() == 1) {
            %>
            <a href="shopping_car.jsp">
                <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
            </a>
            <%}%>
        </div>
        <%
            if (person.getType() == 1) {
        %>
        <div class="user_type">
            shopping cart
        </div>
        <%}%>
    </div>
</div>

</body>
</html>
