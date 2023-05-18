<%@ page import="dataNoBase.Admin" %>
<%@ page import="dataNoBase.CommodityDAO" %><%--
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
    Admin admin = (Admin) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
    Boolean back = false;
    Boolean finish = true;
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
    String cid_str = request.getParameter("cid_str");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String stock = request.getParameter("stock");
    String action = request.getParameter("action");
%>

<%--check parameters invalid--%>
<%
    if (!referenced.equals("shop") && !referenced.equals("commodity_admin")){
        back = true;
    }else if (admin == null){
        back = true;
    }
%>

<%--parameters react--%>
<%
    category = category==null?"null":category;
    cid_str = cid_str==null?"null":cid_str;
    name = name==null?"null":name;
    price = price==null?"null":price;
    stock = stock==null?"null":stock;
    action = action==null?"null":action;

    int cid = -1;

    if (category.equals("null") || cid_str.equals("null") || name.equals("null") || price.equals("null") || stock.equals("null")){
        back = true;
    }else if (!action.equals("delete") && !action.equals("create") && !action.equals("modify")){
        finish = false;
    }
%>


<%--change session msg by param--%>
<%
    
%>

<%--check session msg--%>
<%
    if (admin == null){
        back = true;
    }
    if (!login_status){
        response.sendRedirect("login.jsp");
    }
%>

<%--change session--%>
<%

%>

<%--pre-action--%>
<%
    session.setAttribute("referenced", "commodity_admin");
    if (back){
        response.sendRedirect("shop.jsp");
    }
    if (finish){
        if (action.equals("delete"))
        CommodityDAO.deleteCommodity(cid_str);
        if (action.equals())
        response.sendRedirect("shop.jsp");
    }
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
        <input type="text" name="cid_str">
    </label>
    <label>
        <input type="text" name="name">
    </label>
    <label>
        <input type="text" name="cid_str">
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
