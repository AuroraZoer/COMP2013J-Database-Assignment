<%@ page import="dataNoBase.Admin" %>
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
    //登录状态不正常，重新登陆
    if (login_status==null || !login_status){
        session.setAttribute("referenced", "commodity_admin");
        response.sendRedirect("login.jsp");
        return;
    }

//    session获取不到用户信息，重新登录
    if (admin == null){
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect("login.jsp");
        return;
    }

//    用户权限不足，返回原界面
    if (admin.getType()!=0){
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

//    以下参数需要转换类型
    String price_str = request.getParameter("price");
    String cid_str = request.getParameter("cid");
    String stock_str = request.getParameter("stock");
    String delete_cid_str = request.getParameter("delete_cid");
    String isvisable_str = request.getParameter("isvisable");
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
    int delete_cid = -1;
    int isvisable = -1;

//    转换
    try {
        price = Float.parseFloat(price_str);
        stock = Integer.parseInt(stock_str);
    }catch (Exception ignored){}
    try{
        delete_cid = Integer.parseInt(delete_cid_str);
    }catch (Exception ignored){}
    try{
        isvisable = Integer.parseInt(isvisable_str);
    }catch (Exception ignored){}
    try{
        cid = Integer.parseInt(cid_str);
    }catch (Exception ignored){}
%>

<%--parameters react--%>
<%
    if (price>0 && cid>0 && stock>0 && name!=null && category!=null && isvisable!=-1){
        CommodityDAO.updateCommodity(new Commodity(cid, name, category, price, stock, isvisable==1));
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect(referenced);
        return;
    }
    else if (delete_cid >0 && once!=null && once.equals("delete")){
        CommodityDAO.deleteCommodity(delete_cid);
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect(referenced);
        return;
    }else if (cid>0 && isvisable!=-1 && once!=null && once.equals("modify")){
        CommodityDAO.updateCommodityAvailability(cid, isvisable!=1);
        session.setAttribute("referenced", "modify_commodity.jsp");
        response.sendRedirect(referenced);
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
    </div>
    <div class="button">
        <input type="submit" value="modify">
    </div>
</form>
    <a href="<%=referenced%>">Click here to return</a>
    <%=cid%>
    <%=price%>
    <%=once%>
    <%=isvisable%>
    <%=stock%>

</div>
</body>
</html>
