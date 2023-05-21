<%@ page import="dataNoBase.User" %>
<%@ page import="dataNoBase.Person" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.Transaction" %>
<%@ page import="dataNoBase.TransactionDAO" %><%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/24
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--set referenced--%>
<%
    session.setAttribute("referenced", "shopping_car.jsp");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval() < 0) {
        session.setAttribute("login_status", "true");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>


<%--recv session msg--%>
<%
    Person user = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
    if (user == null){
        response.sendRedirect("login.jsp");
        return;
    }
    if (user.getType()!=1){
        response.sendRedirect(referenced);
    }
    if (!login_status){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--recv parameters--%>
<%
    String page_str = request.getParameter("page_num");
    String keyword = request.getParameter("keyword");
    String delete_cid = request.getParameter("delete_cid");
    String
%>

<%--NullPointerException && NumberFormatException--%>
<%
    int page_num = 1;
    try {
        page_num = Integer.parseInt(page_str);
    } catch (Exception ignored) {}
%>

<%--parameters react--%>
<%

%>

<%--check parameters invalid--%>
<%

%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shopping_car.jsp");
%>

<%--pre-action--%>
<%
    List<Transaction> transactions = TransactionDAO.getUserTransactions(user.getId(), page_num)
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
                        <% if (user_type == 0) { %>
                        Cid: <%=commodity.getCid()%> <br>
                        <% } %>
                    </div>
                </div>
                <div class="item_right_box">
                    <span class="price">
                        ¥ <%=commodity.getPrice()%> <br>
                    </span>
                    <% if (user_type == 0) { %>
                    <span class="stock">
                        Stock: <%=commodity.getStock()%> <br>
                    </span>
                    <% } else { %>
                    <form action="shop.jsp" method="post">
                        <input type="number" name="add_commodity_number" min="1" max="<%=commodity.getStock()%>" step="1">
                        <input type="hidden" name="category_str" value="<%=category_num%>">
                        <input type="hidden" name="page_num" value="<%=page_num%>">
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <input type="hidden" name="add_commodity_cid" value="<%=commodity.getCid()%>">
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
        <br>

        <%--    购物车--%>
        <div class="user_type">
            usertype:
            <br>
            <%=user_type==1?"customer":"admin"%>
        </div>
        <br>

        <div class="shopping_car">
            <%
                if (user_type == 1) {
            %>
            <a href="shopping_car.jsp">
                <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
            </a>
            <%}%>
        </div>

    </div>
</div>


</body>
</html>

<html>
<head>
    <title>shopping_car</title>
</head>
<body>

<div>
    <a href="shop.jsp">
        <span>返回商城：</span>
        <img src="img/shop.jpg" alt="商城" width="50" height="50">
    </a>
</div>

</body>
</html>
