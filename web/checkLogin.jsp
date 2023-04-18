<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    String useraccount = request.getParameter("username");
    String password = request.getParameter("password");
    if (!UserDAO.existUser(useraccount)){
        response.sendRedirect("login.jsp");
    }


    User user = UserDAO.getUser(useraccount, password);
    session.setAttribute("user", user);
    String uid = UserDAO.getUid(user);
    String description = UserDAO.getDescription(user);
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="userMain.jsp" method="get">
    <input type="hidden" name="username" value="<%=username%>">
    <input type="hidden" name="uid" value="<%=uid%>">
    <input type="hidden" name="msg" value="<%=description%>">

</form>
</body>
</html>
