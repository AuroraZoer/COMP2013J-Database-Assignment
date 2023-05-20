<%@ page import="dataNoBase.Admin" %>
<%@ page import="dataNoBase.CommodityDAO" %>
<%@ page import="dataNoBase.Commodity" %><%--
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
    if (session.isNew()) {
        session.setAttribute("login_status", "true");
    }
%>

<%--recv session msg--%>
<%
    Admin admin = (Admin) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
    boolean back = false;
    boolean finish = true;
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
    String category = request.getParameter("category");

    int cid = -1;
    try {
        cid = Integer.parseInt(request.getParameter("cid"));
    } catch (Exception e) {
    }

    String name = request.getParameter("name");
    Float price = -1F;
    try {
        price = Float.parseFloat(request.getParameter("price"));
    } catch (Exception e) {
    }
    int stock = -1;
    try {
        stock = Integer.parseInt(request.getParameter("stock"));
    } catch (Exception e) {
    }
    String action = request.getParameter("action");
%>

<%--check parameters invalid--%>
<%
    //    if (!referenced.equals("shop") && !referenced.equals("commodity_admin")){
//        back = true;
//    }
    if (admin == null) {
        back = true;
    }
%>

<%--parameters react--%>
<%
    category = category == null ? "" : category;
    name = name == null ? "" : name;
    action = action == null ? "" : action;

    if (!action.equals("delete") && !action.equals("create") && !action.equals("modify")) {
        finish = false;
    }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (admin == null) {
        back = true;
    }
    if (!login_status) {
        back = true;
    }
%>

<%--change session--%>
<%

%>

<%--pre-action--%>
<%
    session.setAttribute("referenced", "commodity_admin");
    if (back) {
        response.sendRedirect("shop.jsp");
    } else if (finish) {
        if (action.equals("delete"))
            CommodityDAO.deleteCommodity(cid);
        if (action.equals("create"))
            CommodityDAO.insertCommodity(new Commodity(cid, name, category, price, stock));
        if (action.equals("modify"))
            CommodityDAO.updateCommodity(new Commodity(cid, name, category, price, stock));
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
    <label>Category:
        <input type="text" name="category" value="<%=category%>">
    </label>
    <br>
    <label>Name
        <input type="text" name="name" value="<%=name%>">
    </label>
    <br>
    <label>Cid
        <input type="text" name="cid" value="<%=cid==-1?"":cid%>">
    </label>
    <br>
    <label>Price
        <input type="text" name="price" value="<%=price==-1F?"":price%>">
    </label>
    <br>
    <label>Stock
        <input type="text" name="stock" value="<%=stock==-1?"":stock%>">
    </label>
    <br>
    <label>Delete
        <input type="radio" name="action" value="delete">
    </label>
    <label>Create
        <input type="radio" name="action" value="create">
    </label>
    <br>
    <label>Modify
        <input type="radio" name="action" value="modify">
    </label>
    <input type="submit" value="confirm">
</form>


</body>
</html>
