<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%--recv msg--%>
<%
    String account = request.getParameter("account")==null?"null":request.getParameter("account");
    String password = request.getParameter("password")==null?"null":request.getParameter("password");
    Boolean delete_session = request.getParameter("delete_session")!=null;
    String uid = request.getParameter("uid")==null?"null":request.getParameter("uid");
%>

<%--session--%>
<%--session parameter processing--%>
<%
    if (delete_session){
        session.setAttribute("need_login", "true");
    }
%>

<%--session new--%>
<%
    if (session.isNew()){
        session.setAttribute("need_login", "true");
        session.setMaxInactiveInterval(1800);
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("need_login", "true");
    }
%>

<%--session update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--session parameter--%>
<%
    String session_id = session.getAttribute("need_login")==null?"null":(String)session.getAttribute("need_login");
    Boolean need_login = session_id.equals("true");
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
delete_session:<%=delete_session%>
<br>
need_login:<%=need_login%><br>

<form action="login.jsp" method="post">
    <input type="text" name="account" size="30" maxlength="20"><br>
    <input type="password" name="password" size="30" maxlength="20"><br>
    <input type="hidden" name="uid", value="uid">
    <%session.setAttribute("need_login", "false");%>
    <input type="submit" name="submit" value="提交">
</form>

<%--if not need_login--%>
<%
}else {
%>

<%--redirect userMain.jsp--%>
<%
    session.setAttribute("uid", uid);
    response.sendRedirect("userMain.jsp");
%>

<%
    }
%>
</body>
</html>