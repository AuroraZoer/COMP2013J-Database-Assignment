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

<%--recv session msg--%>
<%
    String uid = (String)session.getAttribute("uid");
    String login_status = (String) session.getAttribute("login_status")
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("login_status", "true");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%

%>

<%--parameters react--%>
<%

%>

<%--check parameters invalid--%>
<%

%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (uid == null){
        login_status = "false";
    }
%>

<%--check uid--%>
<%
    if (uid==null){
        session.setAttribute("need_login", "true");
    }
%>

<%--need_login--%>
<%
    String session_id = session.getAttribute("need_login")==null?"null":(String)session.getAttribute("need_login");
    if (session_id.equals("true")){
        response.sendRedirect("login.jsp");
    }
%>

<%--pre-action--%>
<%

%>




<html>
<head>
    <title>Shop</title>
</head>
<body>

</body>
</html>
