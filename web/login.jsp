<%--
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
    String account = request.getParameter("account");
    String password = request.getParameter("password")==null?"null":request.getParameter("password");
    String uid = request.getParameter("uid")==null?"null":request.getParameter("uid");
%>

<%--parameters react--%>
<%
    if (account==null){login_status="false";}
    if (password==null){login_status="false";}
    if (uid==null){login_status="false";}
%>

<%--check parameters invalid--%>
<%
    if (account==null){account="null";}
    if (password==null){password="null";}
    if (uid==null){uid="null";}
%>

<%--change session msg by param--%>
<%
    if (account.equals("admin")&&password.equals("")){login_status="true";}
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
    <title>Login</title>
</head>
<body>

<%--if need_login--%>
<%
    if (need_login){
%>

account:<%=account%><br>
password:<%=password%><br>
uid:<%=uid%><br>
need_login:<%=need_login%><br>
<div>
    <form action="login.jsp" method="post">
        <label class="account_box">
            <input type="text" name="account" size="30" maxlength="20">
        </label><br>
        <label class="password_box">
            <input type="password" name="password" size="30" maxlength="20">
        </label><br>
        <input type="hidden" name="uid" value="admin">
        <input type="submit" name="submit" value="提交">
    </form>
</div>


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