<%@ page import="dataNoBase.UserDAO" %>
<%@ page import="dataNoBase.User" %>
<%@ page import="java.sql.Timestamp" %>
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
        return;
    }
%>

<%--session update--%>
<%
    session.setMaxInactiveInterval(1800);
%>
<%--recv session msg--%>
<%
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
    //默认登录shop.jsp
    if (referenced == null){
        referenced = "shop.jsp";
    }
%>

<%--recv parameters--%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String confirm = request.getParameter("confirm");
    String email = request.getParameter("email");
%>

<%--NullPointerException && NumberFormatException--%>
<%

%>


<%--check parameters invalid--%>
<%

%>

<%--parameters react--%>
<%
    if (username != null && confirm != null && email != null && confirm.equals(password)){
//        参数正常，注册
        UserDAO.insertUser(new User(1, username, password, email, new Timestamp(new java.util.Date().getTime())));
    }
%>

<%--pre-action--%>
<%

%>


<html>
<head>
    <title>Create Your Account!</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="container">
    <div class="login_box">
        <form action="create_account.jsp" method="post">
            <label class="username_box">Username:
                <input type="text" name="username" size="30" maxlength="20">
            </label><br>
            <label class="password_box">Password:
                <input type="password" name="password" size="30" maxlength="20">
            </label><br>
            <label class="password_box">Confirm Password:
                <input type="password" name="confirm" size="30" maxlength="20">
            </label><br>
            <label class="username_box">Email:
                <input type="text" name="email" size="40" maxlength="20">
            </label><br>
            <input type="hidden" name="user_type" value="user">
            <input type="submit" name="submit" value="sign up">
        </form>
    </div>
</div>


</body>
</html>
