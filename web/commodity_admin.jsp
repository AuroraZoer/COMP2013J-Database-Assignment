<%@ page import="dataNoBase.Admin" %><%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/17
  Time: 21:14
  To change this template use File | Settings | File Templates.
--%>

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
    String user_type = (String) session.getAttribute("user_type");
    if (!user_type.equals("admin")){
        response.sendRedirect("shop.jsp");
    }
    Admin admin = (Admin) session.getAttribute("user");
    String login_status = (String) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
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
    String category = request.getParameter("category");
    String cid = request.getParameter("cid");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");

%>

<%--check parameters invalid--%>
<%
    if (!referenced.equals("shop")){
        response.sendRedirect("shop.jsp");
    }
    if (category == null || cid == null || name == null || price == null || stock == null){
        response.sendRedirect("shop.jsp");
    }
%>

<%--parameters react--%>
<%

%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (admin == null){
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
    session.setAttribute("referenced", "commodity_admin");
%>
<%--session事件--%>
<%--=========================================================================================================================================--%>



<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="commodity_admin.jsp">
    <label>
        <input type="text" name="category">
    </label>
    <label>
        <input type="text" name="name">
    </label>
    <label>
        <input type="text" name="cid">
    </label>
    <label>
        <input type="text" name="name">
    </label>
    <label>
        <input type="text" name="cid">
    </label>
    <input type="submit" value="confirm">
</form>


</body>
</html>
