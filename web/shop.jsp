<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/21
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        response.sendRedirect("login.jsp");
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("need_login", "true");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
    String num;
%>

<%--check session msg--%>
<%

%>

<%--session invalid--%>
<%

%>

<%--recv parameters--%>
<%

%>

<%--check parameters--%>
<%

%>

<%--parameter invalid--%>
<%

%>

<%--add new session--%>
<%
    session.setAttribute("referenced", "shop.jsp");
%>




<html>
<head>
    <title>Shop</title>
</head>
<body>

</body>
</html>
