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
    Admin admin = (Admin) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
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
    String category = request.getParameter("category");
    String cid = request.getParameter("cid");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");
    String action = request.getParameter("action");
%>

<%--check parameters invalid--%>
<%
    if (!referenced.equals("shop") && !referenced.equals("commodity_admin")){
        response.sendRedirect("shop.jsp");
    }
%>

<%--parameters react--%>
<%
    category = category==null?"null":category;
    cid = cid==null?"null":cid;
    name = name==null?"null":name;
    price = price==null?"null":price;
    stock = stock==null?"null":stock;
    action = action==null?"null":action;

    if (category.equals("null") || cid.equals("null") || name.equals("null") || price.equals("null") || stock.equals("null") || action.equals("null")){
        response.sendRedirect("shop.jsp");
    }
    if (!action.equals("delete") && !action.equals("create") && !action.equals("modify")){
        response.sendRedirect("shop.jsp");
    }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (admin == null){
        response.sendRedirect("shop.jsp");
    }
    if (!login_status){
        response.sendRedirect("login.jsp");
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shop");
%>

<%--pre-action--%>
<%
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
    <label>
        <input type="radio" name="action" value="delete">
    </label>
    <label>
        <input type="radio" name="action" value="create">
    </label>
    <label>
        <input type="radio" name="action" value="modify">
    </label>
    <input type="submit" value="confirm">
</form>


</body>
</html>
