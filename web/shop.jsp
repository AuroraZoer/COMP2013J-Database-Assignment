<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.*" %><%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/21
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
    if (session.isNew()) {
        response.sendRedirect("login.jsp");
    }
%>

<%--recv session msg--%>
<%
    Person person = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval() < 0) {
        response.sendRedirect("login.jsp");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
    String keyword = request.getParameter("keyword");
    String page_str = request.getParameter("page_num");
    String category_str = request.getParameter("category_str");
    String create_category_name = request.getParameter("create_category_name");
    String delete_category_name = request.getParameter("delete_category_name");
%>

<%--check parameters invalid--%>
<%
    int page_num = 1;
    int category_num = 1;
    try {
        page_num = Integer.parseInt(page_str);
    } catch (Exception e) {

    }
    try {
        category_num = Integer.parseInt(category_str);
    } catch (Exception e) {
    }

%>

<%--parameters react--%>
<%
    if (create_category_name != null) {
        CategoryDAO.insertCategory(new Category(create_category_name));
    }

    if (delete_category_name != null) {
        CategoryDAO.deleteCategory(delete_category_name);
    }

%>


<%--change session msg by param--%>
<%
    int user_type = -1;
%>

<%--check session msg--%>
<%
    if (person == null) {
        response.sendRedirect("login.jsp");
    } else if (!login_status) {
        response.sendRedirect("login.jsp");
    } else if (person.getType() == 0 || person.getType() == 1) {
        user_type = person.getType();
    }

%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shop");
%>

<%--pre-action--%>
<%
    session.setAttribute("referenced", "shop.jsp");
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<%--初始化--%>
<%
    List<Category> categories = CategoryDAO.getAllCategories();
    List<Commodity> commodities = null;
    if (keyword == null)
        commodities = CommodityDAO.getCommoditiesByCategory(categories.get(category_num - 1).getName(), page_num);
    else
        commodities = CommodityDAO.getCommoditiesByCategory(keyword, page_num);
%>


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
                <% if (user_type == 0) {%>
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="delete_category_name" value="<%=category.getName()%>">
                    <input type="submit" value="Delete">
                </form>
                <%}%>
            </div>

            <%}%>

            <% if (user_type == 0) {%>
            <form action="shop.jsp" method="post">
                <label> Category:name
                    <input type="text" name="create_category_name">
                </label>
                <button type="submit">add</button>
            </form>
            <%}%>
        </div>
    </div>

    <div class="mid_box">
        <div class="top_box">
            <div class="outer_search_box">
                <div class="inner_search_box">
                    <form action="shop.jsp" method="get">
                        <label>
                            <input type="search" name="keyword" width="300px" height="50px" spellcheck="false"
                                   placeholder="请输入你的商品">
                        </label>
                        <button type="submit">
                            <img src="img/search_icon.png" alt="搜索" width="50px" height="50px">
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <%--        <div class="main_box">--%>
        <%--            &lt;%&ndash;        test&ndash;%&gt;--%>
        <%--            <%=category_num%> <br>--%>
        <%--            <%=page_num%> <br>--%>
        <%--            <%=commodities.size()%>--%>
        <%--            <%=    categories.get(category_num - 1).getName()--%>
        <%--            %>--%>
        <%--            <%--%>
        <%--                for (Commodity commodity : commodities) {--%>
        <%--            %>--%>
        <%--            <div class="item_box" id="item_box1">--%>
        <%--                <div class="item_left_box">--%>
        <%--                    <%=commodity.getCategory()%> <br>--%>
        <%--                </div>--%>
        <%--                <div class="item_mid_box">--%>
        <%--                    <div class="item_top_box">--%>
        <%--                        <%=commodity.getCid()%> <br>--%>
        <%--                    </div>--%>
        <%--                    <div class="item_bottom_box">--%>
        <%--                        <%=commodity.getItemName()%> <br>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--                <div class="item_right_box">--%>
        <%--                    <%=commodity.getPrice()%> <br>--%>
        <%--                    <%=commodity.getStock()%> <br>--%>
        <%--                    <%--%>
        <%--                        if (user_type == 0) {--%>
        <%--                    %>--%>
        <%--                    <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>">edit</a>--%>
        <%--                    <%--%>
        <%--                        }--%>
        <%--                    %>--%>
        <%--                </div>--%>
        <%--            </div>--%>
        <%--            <%}%>--%>
        <%--            <%if (user_type == 0) {%>--%>
        <%--            <div class="item_admin_box">--%>
        <%--                <a href="commodity_admin.jsp?category=<%=categories.get(category_num-1).getName()%>"><img--%>
        <%--                        src="img/add.png"--%>
        <%--                        alt="addition"--%>
        <%--                        width="200"--%>
        <%--                        height="50"></a>--%>
        <%--            </div>--%>
        <%--            <%}%>--%>

        <%--        </div>--%>
        <div class="main_box">
<%--            <div class="head">--%>
<%--                <span></span>--%>
<%--            </div>--%>
            <% for (Commodity commodity : commodities) { %>
            <div class="item_box" id="item_box1">
                <div class="item_left_box">
                    <%=commodity.getCategory()%> <br>
                    <% if (user_type == 0) { %>
                        <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>">edit</a>
                    <% } %>
                </div>
                <div class="item_mid_box">
                    <div class="item_top_box">
                        <%=commodity.getItemName()%> <br>

                    </div>
                    <div class="item_bottom_box">
                        Cid:<%=commodity.getCid()%> <br>
                    </div>
                </div>
                <div class="item_right_box">
                    <span class="price">
                        ¥<%=commodity.getPrice()%> <br>
                    </span>

                    <span class="stock">
                        Stock :<%=commodity.getStock()%> <br>
                    </span>
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


    <%--    用户界面--%>
    <div>
        <a href="userMain.jsp">
            <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
        </a>
    </div>

    <%--    购物车--%>
    usertype:
    <%=user_type%>
    <div>
        <%
            if (user_type == 1) {
        %>
        <a href="shopping_car.jsp">
            <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
        </a>
        <%}%>
    </div>

</div>


</body>
</html>
