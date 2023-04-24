<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/24
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        response.sendRedirect("login.jsp");
    }
%>

<%--recv session msg--%>
<%
    String uid = (String)session.getAttribute("uid");
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

%>

<%--parameters react--%>
<%

%>

<%--check parameters invalid--%>
<%

%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (uid == null){
        login_status = "false";
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shopping_car.jsp");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")){
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
    <title>shopping_car</title>
</head>
<body>
这是没完成的购物车

<div>
    <a href="shop.jsp">
        <span>返回商城：</span>
        <img src="img/shop.jpg" alt="商城" width="50" height="50">
    </a>
</div>

</body>
</html>
