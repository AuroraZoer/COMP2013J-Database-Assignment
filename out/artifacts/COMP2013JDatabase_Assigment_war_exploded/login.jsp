<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--Set session--%>
<%
    session.setAttribute("login", "true");
    session.setMaxInactiveInterval(1800);
%>

<html>
<head>
    <title>Login</title>
</head>
<body>
<form action="checkLogin.jsp" method="post">
    <input type="text" name="username" size="30" maxlength="20"><br>
    <input type="password" name="password" size="30" maxlength="20"><br>
    <input type="submit" name="submit" value="提交">
</form>
</body>
</html>
