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
    if (session.isNew()){
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
    if (session.getMaxInactiveInterval()<0){
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
    String category_str = request.getParameter("category_num");
    String create_category_name = request.getParameter("create_category_name");
    String delete_category_name = request.getParameter("delete_category_name");
%>

<%--check parameters invalid--%>
<%
    if (keyword==null){
        keyword = "";
    }
    if (page_str==null) {
        page_str = "0";
    }

    int page_num = 0;
    int category_num = 0;
    try{
        page_num = Integer.parseInt(page_str);
    }catch (NumberFormatException e){

    }
    try{
        category_num = Integer.parseInt(category_str);
    }catch (NumberFormatException e){

    }

%>

<%--parameters react--%>
<%
    if (create_category_name != null){
        CategoryDAO.insertCategory(new Category(create_category_name));
    }

    if (delete_category_name != null){
        CategoryDAO.deleteCategory(delete_category_name);
    }

%>


<%--change session msg by param--%>
<%
    int user_type = -1;
%>

<%--check session msg--%>
<%
    if (person == null){
        person = new Person();
        response.sendRedirect("login.jsp");
    }
    else if (!login_status){
        response.sendRedirect("login.jsp");

    }
//    NullPointerException
    else if (person.getType() == 0 && person.getType() == 1) {
        user_type = person.getType();    }

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
    List<Commodity> commodities = CommodityDAO.getCommoditiesByCategory(categories.get(category_num).getName(), page_num);
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
                for (int i = 0; i<categories.size(); i++){
                    Category category = categories.get(i);
            %>
            <div>
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="category_num" value="<%=i%>">
                    <button type="submit"><span><%=category.getName()%></span><br></button>
                </form>
                <% if (user_type == 0){%>
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="delete_category_name" value="<%=category.getName()%>">
                </form>
                <%}%>
            </div>
<%--            <form action="shop.jsp">--%>
<%--                <input type="hidden" name="category_num" value="0">--%>
<%--                <button type="submit"><span id="cate0"><%=categories.get(0).getName()%></span><br></button>--%>
<%--            </form>--%>

<%--            <form action="shop.jsp">--%>
<%--                <input type="hidden" name="category_num" value="1">--%>
<%--                <button type="submit"><span id="cate1"><%=categories.get(1).getName()%></span><br></button>--%>
<%--            </form>--%>

<%--            <form action="shop.jsp">--%>
<%--                <input type="hidden" name="category_num" value="2">--%>
<%--                <button type="submit"><span id="cate2"><%=categories.get(2).getName()%></span><br></button>--%>
<%--            </form>--%>

<%--            <form action="shop.jsp">--%>
<%--                <input type="hidden" name="category_num" value="3">--%>
<%--                <button type="submit"><span id="cate3"><%=categories.get(3).getName()%></span><br></button>--%>
<%--            </form>--%>

<%--            <div>--%>
<%--                <form action="shop.jsp">--%>
<%--                    <input type="hidden" name="category_num" value="4">--%>
<%--                    <button type="submit"><span id="cate4"><%=categories.get(4).getName()%></span><br></button>--%>
<%--                </form>--%>
<%--                <% if (user_type.equals("admin")){%>--%>
<%--                <form action="shop.jsp" method="post">--%>
<%--                    <input type="hidden" name="delete_category_name" value="<%=categories.get(4).getName()%>">--%>
<%--                </form>--%>
<%--                <%}%>--%>
<%--            </div>--%>

            <%}%>

            <% if (user_type==0){%>
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
                            <input type="search" name="keyword" width="300px" height="50px" spellcheck="false" placeholder="请输入你的商品">
                        </label>
                        <button type="submit">
                            <img src="img/search_icon.png" alt="搜索" width="50px" height="50px">
                        </button>
                    </form>
                </div>
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
            if (user_type == 1){
        %>
        <a href="shopping_car.jsp">
            <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
        </a>
        <%}%>
    </div>

    <div class="main_box">
<%--        test--%>
        <%=category_num%> <br>
    <%=page_num%> <br>
    <%
        for (Commodity commodity : commodities){
    %>
        <div class="item_box" id="item_box1">
            <div class="item_left_box">
                <%=commodity.getCategory()%> <br>
            </div>
            <div class="item_mid_box">
                <div class="item_top_box">
                    <%=commodity.getCid()%> <br>
                </div>
                <div class="item_bottom_box">
                    <%=commodity.getItemName()%> <br>
                </div>
            </div>
            <div class="item_right_box">
                <%=commodity.getPrice()%> <br>
                <%=commodity.getStock()%> <br>
                <%
                    if (user_type == 0){
                %>
                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>
                <%
                    }
                %>
            </div>
        </div>
    <%}%>
<%--        <div class="item_box" id="item_box2">--%>
<%--            <%--%>
<%--                commodity = commodities.get(1);--%>
<%--            %>--%>
<%--            <div class="item_left_box" id="item_left_box2">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box2">--%>
<%--                <div class="item_top_box" id="item_top_box2">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box2">--%>

<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box2">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box3">--%>
<%--            <%--%>
<%--                commodity = commodities.get(2);--%>
<%--            %>--%>
<%--            <div class="item_left_box" id="item_left_box3">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box3">--%>
<%--                <div class="item_top_box" id="item_top_box3">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box3">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box3">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box4">--%>
<%--            <%--%>
<%--                commodity = commodities.get(3);--%>
<%--            %>--%>
<%--            <div class="item_left_box" id="item_left_box4">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box4">--%>
<%--                <div class="item_top_box" id="item_top_box4">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box4">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box4">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>
<%--            <%=commodity.getCid()%> <br>--%>
<%--        </div>--%>
<%--        <div class="item_box" id="item_box5">--%>
<%--            <%--%>
<%--                commodity = commodities.get(4);--%>
<%--            %>--%>
<%--            <div class="item_left_box" id="item_left_box5">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box5">--%>
<%--                <div class="item_top_box" id="item_top_box5">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box5">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box5">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box6">--%>
<%--            commodity = commodities.get(5);--%>
<%--            <div class="item_left_box" id="item_left_box6">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box6">--%>
<%--                <div class="item_top_box" id="item_top_box6">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box6">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box6">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box7">--%>
<%--            commodity = commodities.get(6);--%>
<%--            <div class="item_left_box" id="item_left_box7">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box7">--%>
<%--                <div class="item_top_box" id="item_top_box7">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box7">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box7">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box8">--%>
<%--            commodity = commodities.get(7);--%>
<%--            <div class="item_left_box" id="item_left_box8">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box8">--%>
<%--                <div class="item_top_box" id="item_top_box8">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box8">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box8">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box9">--%>
<%--            commodity = commodities.get(8);--%>
<%--            <div class="item_left_box" id="item_left_box9">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box9">--%>
<%--                <div class="item_top_box" id="item_top_box9">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box9">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box9">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>
<%--        <div class="item_box" id="item_box10">--%>
<%--            commodity = commodities.get(9);--%>
<%--            <div class="item_left_box" id="item_left_box10">--%>
<%--                <%=commodity.getCategory()%> <br>--%>
<%--            </div>--%>
<%--            <div class="item_mid_box" id="item_mid_box10">--%>
<%--                <div class="item_top_box" id="item_top_box10">--%>
<%--                    <%=commodity.getCid()%> <br>--%>
<%--                </div>--%>
<%--                <div class="item_bottom_box" id="item_bottom_box10">--%>
<%--                    <%=commodity.getItemName()%> <br>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="item_right_box" id="item_right_box10">--%>
<%--                <%=commodity.getPrice()%> <br>--%>
<%--                <%=commodity.getStock()%> <br>--%>
<%--                <%--%>
<%--                    if (user_type.equals("admin")){--%>
<%--                %>--%>
<%--                <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>&">edit</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </div>--%>

<%--        </div>--%>

        <%if (user_type == 0){%>
        <div class="item_admin_box">
            <a href="commodity_admin.jsp?"><img src="img/add.png" alt="addition" width="200" height="50"></a>
        </div>
        <%}%>

    </div>

    <div class="next_page">
        <form action="shop.jsp" method="post">
            <input type="hidden" name="category_num" value="<%=category_num%>">
            <input type="hidden" name="page_num" value="<%=categories.size()<10?page_num:page_num+1%>">
            <input type="hidden" name="keyword" value="<%=keyword%>">
            <input type="submit" value="next page">
        </form>
    </div>

    <div class="last_page">
        <form action="shop.jsp" method="post">
            <input type="hidden" name="category_num" value="<%=category_num%>">
            <input type="hidden" name="page_num" value="<%=page_num-1<0?page_num:page_num-1%>">
            <input type="hidden" name="keyword" value="<%=keyword%>">
            <input type="submit" value="next page">
        </form>
    </div>
</div>


</body>
</html>
