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

%>

<%--recv session msg--%>
<%
    Boolean login_status = true;
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
        login_status = false;
    }
    if (password == null) {
        login_status = false;
    }
    if (user_type == null) {
        login_status = false;
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
    if (user_type.equals("admin")) {
        if (AdminDAO.isPasswordCorrect(username, password)) {
            session.setAttribute("person", AdminDAO.getAdminByUsername(username));
            session.setAttribute("test", 1);
        }
    } else if (user_type.equals("customer")) {
        if (UserDAO.isPasswordCorrect(username, password)) {
            session.setAttribute("person", UserDAO.getUserByUsername(username));
            session.setAttribute("test", 1);
        }

    } else {
        login_status = false;
    }
%>

<%--change session msg by param--%>
<%
    if (login_status) {
        session.setAttribute("login_status", true);
        response.sendRedirect("shop.jsp");
    }
%>

<%--check session msg--%>
<%

%>

<%--change session--%>
<%
    session.setAttribute("referenced", "login");
%>

<%--pre-action--%>
<%
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
                    <label><input type="radio" id="customer" name="user_type" value="customer">User</label>
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

<%--test--%>
<%--<%=user_type%>--%>
<%--<%=login_status%>--%>
<%--<%=username%>--%>
<%--<%=password%>--%>


</body>
</html>