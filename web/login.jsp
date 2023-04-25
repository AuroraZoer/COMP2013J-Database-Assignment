<%@ page import="dataNoBase.UserDAO" %><%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        session.setAttribute("login_status", "false");
    }
%>

<%--recv session msg--%>
<%
    String login_status = (String) session.getAttribute("login_status");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        login_status = "false";
    }
%>

<%--session update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password")==null?"null":request.getParameter("password");
    String uid = request.getParameter("uid")==null?"null":request.getParameter("uid");
%>

<%--parameters react--%>
<%
    if (username==null){login_status="false";}
    if (password==null){login_status="false";}
    if (uid==null){login_status="false";}
%>

<%--check parameters invalid--%>
<%
    if (username==null){username="null";}
    if (password==null){password="null";}
    if (uid==null){uid="null";}
%>

<%--change session msg by param--%>
<%
//    调用数据库
    if (UserDAO.isPasswordCorrect(username, password)){
        login_status="true";
    }

//    test
//    if (!username.equals("null")&&!password.equals("null")){
//        login_status = "true";
//    }
%>

<%--check session msg--%>
<%

%>

<%--change session--%>
<%
    session.setAttribute("login_status", login_status);
    session.setAttribute("uid", uid);
    session.setAttribute("referenced", "login.jsp");
%>

<%--pre-action--%>
<%
    Boolean need_login = !login_status.equals("true");
%>


<html>
<head>
    <link rel="stylesheet" href="css/login.css">
    <title>Login</title>
</head>
<body>

<%--if need_login--%>
<%
    if (need_login){
%>

username:<%=username%><br>
password:<%=password%><br>
uid:<%=uid%><br>
need_login:<%=need_login%><br>
<div class="container"> <!-- 添加这个div -->
    <div class="login_box">
        <form action="login.jsp" method="post">
            <label class="username_box">用户名:
                <input type="text" name="username" size="30" maxlength="20">
            </label><br>
            <label class="password_box">密码:
                <input type="password" name="password" size="30" maxlength="20">
            </label><br>
            <input type="hidden" name="uid" value="admin">
            <input type="submit" name="submit" value="Submit">
        </form>
    </div>
</div> <!-- 结束这个div -->


<%--if not need_login--%>
<%
}else {
%>

<%--redirect userMain.jsp--%>
<%
    session.setAttribute("uid", uid);
    session.setAttribute("login_status", "true");
    response.sendRedirect("shop.jsp");
%>

<%
    }
%>
</body>
</html>