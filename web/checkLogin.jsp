<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--session dealing--%>
<%--no session--%>
<%
    if (session.isNew()){
        response.sendRedirect("login.jsp");
    }
%>

<%--fake session--%>
<%
    if (session.getAttribute("login")!="true"){
        response.sendRedirect("login.jsp");
    }
%>

<%--recv account&password--%>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");
%>

<%--check the data to database--%>
<%--account not exist--%>
<%

%>

<%--password false--%>
<%

%>

<%--添加用户session--%>
<%
    session.setAttribute("uid", "10000001");
%>

<%--跳转usermain--%>
<%
    response.sendRedirect("userMain.jsp");
%>

<html>
<head>
    <title>Title</title>
</head>
<body>
404
</body>
</html>
