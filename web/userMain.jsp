<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        response.sendRedirect("login.jsp");
    }
%>

<%--update session--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv user msg--%>
<%
    String uid = (String)session.getAttribute("uid");
%>

<%--check uid--%>
<%
    if (uid==null){
        response.sendRedirect("login.jsp");
    }
%>

<%--generate user data--%>
<%

%>

<html>
<head>
    <title><%=request.getParameter("username")%></title>
</head>
<body>
<div>
    用户名：<%=request.getParameter("username")%><br>
    uid：<%=uid%><br>
    信息：<%=request.getParameter("msg")%>
</div>

</body>
</html>
