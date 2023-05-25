<%@ page import="dataNoBase.CommodityDAO" %>
<%@ page import="dataNoBase.Commodity" %>
<%@ page import="dataNoBase.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
    if (session.isNew()) {
        response.sendRedirect("login.jsp");
        return;
    }
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

<%--recv session msg--%>
<%
    Person admin = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
    // The login status is abnormal. Log in again.
    if (login_status == null || !login_status) {
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("login.jsp");
        return;
    }

    // Session fails to obtain the user information. Log in again.
    if (admin == null) {
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("login.jsp");
        return;
    }

    // If the user has insufficient permissions, return to the original page.
    if (admin.getType() != 0) {
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect(referenced);
        return;
    }
%>

<%--recv parameters--%>
<%
    String category = request.getParameter("category");
    String name = request.getParameter("name");
    String once = request.getParameter("once");

    // The following parameters need to be converted.
    String price_str = request.getParameter("price");
    String cid_str = request.getParameter("cid");
    String stock_str = request.getParameter("stock");
    String delete_cid_str = request.getParameter("delete_cid");
    String isvisable_str = request.getParameter("isvisable");
%>

<%--NullPointerException && NumberFormatException--%>
<%
    // Declare variables.
    float price = -1F;
    int cid = -1;
    int stock = -1;
    int delete_cid = -1;
    int isvisable = -1;

    // Converts the string type to the corresponding type.
    try {
        price = Float.parseFloat(price_str);
        stock = Integer.parseInt(stock_str);
    } catch (Exception ignored) {
    }
    try {
        delete_cid = Integer.parseInt(delete_cid_str);
    } catch (Exception ignored) {
    }
    try {
        isvisable = Integer.parseInt(isvisable_str);
    } catch (Exception ignored) {
    }
    try {
        cid = Integer.parseInt(cid_str);
    } catch (Exception ignored) {
    }
%>

<%--parameters invalid--%>
<%

%>

<%--parameters react--%>
<%
    if (price > 0 && cid > 0 && stock > 0 && name != null && category != null && once != null && once.equals("modify")) {
        CommodityDAO.updateCommodity(new Commodity(cid, name, category, price, stock, isvisable == 1));
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("shop.jsp");
        return;
    } else if (delete_cid > 0 && once != null && once.equals("delete")) {
        CommodityDAO.deleteCommodity(delete_cid);
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("shop.jsp");
        return;
    } else if (cid > 0 && isvisable != -1 && once != null && once.equals("modify")) {
        CommodityDAO.updateCommodityAvailability(cid, isvisable != 1);
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("shop.jsp");
        return;
    }
%>

<%--pre-action--%>
<%

%>

<%--page--%>
<%--=========================================================================================================================================--%>


<html>
<head>
    <title>Edit commodity</title>
    <link rel="stylesheet" href="css/commodity_admin.css">
</head>
<body>
<div class="container">
    <form action="modify_commodity.jsp">
        <div class="line">
            <label>Category:
                <input type="text" name="category" value="<%=category==null?"":category%>">
            </label>
        </div>
        <div class="line">
            <label>Name:
                <input type="text" name="name" value="<%=name==null?"":name%>">
            </label>
        </div>
        <div class="line">
            <label>Price:
                <input type="text" name="price" value="<%=price==-1F?"":price%>">
            </label>
        </div>
        <div class="line">
            <label>Stock:
                <input type="text" name="stock" value="<%=stock==-1?"":stock%>">
            </label>
            <input type="hidden" name="once" value="modify">
            <input type="hidden" name="cid" value="<%=cid%>">
        </div>
        <div class="button">
            <input type="submit" value="modify">
        </div>
    </form>
    <a href="<%=referenced%>">Click here to return</a>

</div>
</body>
</html>
