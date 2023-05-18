<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Date" %>
<%@ page import="dataNoBase.*" %><%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()) {
        session.setAttribute("login_status", false);
    }
%>

<%--recv session msg--%>
<%
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    Person person = (Person) session.getAttribute("person");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval() < 0) {
        response.sendRedirect("login.jsp");
    }
%>

<%--session update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String user_type = request.getParameter("user_type");
%>

<%--parameters react--%>
<%
    if (username == null) {
        login_status = "false";
    }
    if (password == null) {
        login_status = "false";
    }
    if (user_type == null) {
        login_status = "false";
    }
%>

<%--check parameters invalid--%>
<%
    if (username == null) {
        username = "null";
    }
    if (password == null) {
        password = "null";
    }
    if (user_type == null) {
        user_type = "null";
    }
    if (!user_type.equals("admin") && !user_type.equals("user")) {
        login_status = "null";
    }
%>

<%--change session msg by param--%>
<%
    //    调用数据库
    if (person.)
    session.setAttribute("user", AdminDAO.getAdminByUsername(username));
%>

<%--check session msg--%>
<%

%>

<%--change session--%>
<%
    session.setAttribute("login_status", login_status);
    session.setAttribute("referenced", "login.jsp");
%>

<%--pre-action--%>
<%
    Boolean need_login = !login_status.equals("true");
    session.setAttribute("referenced", "login");
%>


<html>
<head>
    <link rel="stylesheet" href="css/login.css">
    <title>Login</title>
</head>
<body>


<div class="container">
    <h1>COMP2013J Databases and Info Sys</h1>
    <h2>Group3 Assignment</h2>
    <div class="login_box">
        <form action="login.jsp" method="post">
            <label class="username_box">Username:
                <input type="text" name="username" size="30" maxlength="20">
            </label><br>
            <label class="password_box">Password:
                <input type="password" name="password" size="30" maxlength="20">
            </label><br>

            <div class="radio_box">
                <div class="left_box">
                    <label><input type="radio" id="user" name="user_type" value="user">User</label>
                </div>
                <div class="right_box">
                    <label><input type="radio" id="admin" name="user_type" value="admin">Admin</label>
                </div>

            </div>
            <input type="submit" name="submit" value="Login">
        </form>
        <a href="create_account.jsp">Click to create an account</a>
    </div>
</div>

<%--redirect shop.jsp--%>
<%
    if (user_type.equals("admin")){
        session.setAttribute("user", AdminDAO.getAdminByUsername(username));
    }else {
        session.setAttribute("user", UserDAO.getUserByUsername(username));
    }
    session.setAttribute("login.jsp", true);
    response.sendRedirect("shop.jsp");
%>

</body>
</html>