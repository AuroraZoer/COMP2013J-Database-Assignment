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
        session.setAttribute("login_status", "true");
    }
%>

<%--recv session msg--%>
<%
    User user = (User) session.getAttribute("user");
    String login_status = (String) session.getAttribute("login_status");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("login_status", "true");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
    String select = request.getParameter("select");
    String keyword = request.getParameter("keyword");
    String page_str = request.getParameter("page_num");
    String category_str = request.getParameter("category_num");
%>

<%--check parameters invalid--%>
<%
    if (select==null){
        select = "null";
    }
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
        category_num = Integer.parseInt(page_str);
    }catch (NumberFormatException e){

    }
%>

<%--parameters react--%>
<%
    if (select.equals("true")){

    }
    if (!keyword.equals("")){
//        ask mysql
    }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (user == null){
        login_status = "false";
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shop");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")){
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("referenced", "shop");
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
            <form action="shop.jsp">
                <input type="hidden" name="category_num" value="0">
                <button type="submit"><span id="cate0"><%=categories.get(0).getName()%></span><br></button>
            </form>

            <form action="shop.jsp">
                <input type="hidden" name="category_num" value="1">
                <button type="submit"><span id="cate1"><%=categories.get(1).getName()%></span><br></button>
            </form>

            <form action="shop.jsp">
                <input type="hidden" name="category_num" value="2">
                <button type="submit"><span id="cate2"><%=categories.get(2).getName()%></span><br></button>
            </form>

            <form action="shop.jsp">
                <input type="hidden" name="category_num" value="3">
                <button type="submit"><span id="cate3"><%=categories.get(3).getName()%></span><br></button>
            </form>

            <form action="shop.jsp">
                <input type="hidden" name="category_num" value="4">
                <button type="submit"><span id="cate4"><%=categories.get(4).getName()%></span><br></button>
            </form>

        </div>
    </div>
    
    <div class="mid_box">
        <div class="top_box">
            <div class="outer_search_box">
                <div class="inner_search_box">
                    <form action="shop.jsp">
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

    <div>
        <a href="shopping_car.jsp">
            <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
        </a>
    </div>
    
    <div class="main_box">
<%--        test--%>
        <%=category_num%> <br>
    <%=page_num%> <br>
        <div class="item_box" id="item_box1">
            <div class="item_left_box" id="item_left_box1">
<%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box1">
                <div class="item_top_box" id="item_top_box1">

                </div>
                <div class="item_bottom_box" id="item_bottom_box">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box1">

            </div>
        </div>
        <div class="item_box" id="item_box2">
            <div class="item_left_box" id="item_left_box2">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box2">
                <div class="item_top_box" id="item_top_box2">

                </div>
                <div class="item_bottom_box" id="item_bottom_box2">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box2">

            </div>

        </div>
        <div class="item_box" id="item_box3">
            <div class="item_left_box" id="item_left_box3">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box3">
                <div class="item_top_box" id="item_top_box3">

                </div>
                <div class="item_bottom_box" id="item_bottom_box3">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box3">

            </div>

        </div>
        <div class="item_box" id="item_box4">
            <div class="item_left_box" id="item_left_box4">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box4">
                <div class="item_top_box" id="item_top_box4">

                </div>
                <div class="item_bottom_box" id="item_bottom_box4">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box4">

            </div>

        </div>
        <div class="item_box" id="item_box5">
            <div class="item_left_box" id="item_left_box5">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box5">
                <div class="item_top_box" id="item_top_box5">

                </div>
                <div class="item_bottom_box" id="item_bottom_box5">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box5">

            </div>

        </div>
        <div class="item_box" id="item_box6">
            <div class="item_left_box" id="item_left_box6">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box6">
                <div class="item_top_box" id="item_top_box6">

                </div>
                <div class="item_bottom_box" id="item_bottom_box6">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box6">

            </div>

        </div>
        <div class="item_box" id="item_box7">
            <div class="item_left_box" id="item_left_box7">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box7">
                <div class="item_top_box" id="item_top_box7">

                </div>
                <div class="item_bottom_box" id="item_bottom_box7">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box7">

            </div>

        </div>
        <div class="item_box" id="item_box8">
            <div class="item_left_box" id="item_left_box8">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box8">
                <div class="item_top_box" id="item_top_box8">

                </div>
                <div class="item_bottom_box" id="item_bottom_box8">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box8">

            </div>

        </div>
        <div class="item_box" id="item_box9">
            <div class="item_left_box" id="item_left_box9">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box9">
                <div class="item_top_box" id="item_top_box9">

                </div>
                <div class="item_bottom_box" id="item_bottom_box9">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box9">

            </div>

        </div>
        <div class="item_box" id="item_box10">
            <div class="item_left_box" id="item_left_box10">
                <%--                <img src="" alt="">--%>
            </div>
            <div class="item_mid_box" id="item_mid_box10">
                <div class="item_top_box" id="item_top_box10">

                </div>
                <div class="item_bottom_box" id="item_bottom_box10">

                </div>
            </div>
            <div class="item_right_box" id="item_right_box10">

            </div>

        </div>

    </div>

    <div class="next_page">
        <form action="shop.jsp">
            <input type="hidden" name="category_num" value="<%=category_num+1%>">
            <input type="hidden" name="page_num" value="<%=page_num+1%>">
            <input type="submit" value="next page">
        </form>
    </div>
    
</div>



</body>
</html>
