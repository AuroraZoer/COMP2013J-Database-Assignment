<%@ page import="dataNoBase.Admin" %>
<%@ page import="dataNoBase.CommodityDAO" %>
<%@ page import="dataNoBase.Commodity" %>
<%@ page import="dataNoBase.Person" %><%--
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
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--set referenced--%>
<%
    session.setAttribute("referenced", "commodity_admin.jsp");
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
    boolean login_status = (boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
//    boolean back = false;
//    boolean finish = true;
%>

<%--session invalid--%>
<%
    //登录状态不正常，重新登陆
    if (!login_status){
        response.sendRedirect("login.jsp");
        return;
    }

//    session获取不到用户信息，重新登录
    if (admin == null){
        response.sendRedirect("login.jsp");
        return;
    }

//    用户权限不足，返回原界面
    if (admin.getType()!=0){
        response.sendRedirect(referenced);
        return;
    }
%>

<%--recv parameters--%>
<%
    String category = request.getParameter("category");
    String name = request.getParameter("name");
    String action = request.getParameter("action");

//    以下参数需要转换类型
    String price_str = request.getParameter("price");
    String cid_str = request.getParameter("cid");
    String stock_str = request.getParameter("stock");
%>

<%--parameters invalid--%>
<%

%>

<%--NullPointerException && NumberFormatException--%>
<%
//    声明变量
    float price = -1F;
    int cid = -1;
    int stock = -1;

//    转换
    try {
        price = Float.parseFloat(price_str);
        cid = Integer.parseInt(cid_str);
        stock = Integer.parseInt(stock_str);
//        接收不到参数，返回原界面
    }catch (NullPointerException e){
        response.sendRedirect(referenced);
//        参数异常，返回原界面
    }catch (NumberFormatException e){
        response.sendRedirect(referenced);
    }
%>

<%--parameters react--%>
<%
    if (action != null){
        switch (action){
//            删除
            case "delete":
                CommodityDAO.deleteCommodity(cid);
                response.sendRedirect(referenced);
                return;
//            创建
            case "create":
                CommodityDAO.insertCommodity(new Commodity(cid, name, category, price, stock));
                response.sendRedirect(referenced);
                return;
//            修改
            case "modify":
                CommodityDAO.updateCommodity(new Commodity(cid, name, category, price, stock));
                response.sendRedirect(referenced);
                return;
        }
    }
%>

<%--pre-action--%>
<%

%>

<%--page--%>
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
