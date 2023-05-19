<%@ page import="dataNoBase.User" %><%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/24
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()) {
        response.sendRedirect("login.jsp");
    }
%>

<%--recv session msg--%>
<%
    User user = (User) session.getAttribute("user");
    String login_status = (String) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
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

<%--recv parameters--%>
<%
    String item = request.getParameter("item_id");
%>

<%--parameters react--%>
<%
    if (item == null) {
        item = "null";
    }
%>

<%--check parameters invalid--%>
<%

%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (user == null) {
        login_status = "false";
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "userMain.jsp");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")) {
        response.sendRedirect("login.jsp");
    }
    session.setAttribute("referenced", "item");

%>
<html>
<head>
    <title><%=item%>></title>
</head>
<body>
this is Item
<div>
    <form action="shop.jsp">
        <button type="submit">
            <img src="img/shop.jpg" alt="商城">
        </button>
    </form>
</div>

<div>
    <form action="shopping_car.jsp">
        <button type="submit">
            <img src="img/shopping_car.jpg" alt="购物车">
        </button>
    </form>
</div>


</body>
</html>
