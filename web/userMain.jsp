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

<%--wrong session--%>
<%
    if (session.getAttribute("need_login")=="true"){
        response.sendRedirect("login.jsp");
    }
%>

<%--recv user msg--%>
<%
    String uid = (String)session.getAttribute("uid");
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
    Boolean need_login = session_id.equals("true");
    if (need_login){
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


<div>
    <form action="login.jsp">
        <input type="hidden" name="delete_session" value="true">
        <button type="submit">退出登录</button>
    </form>
</div>
</body>
</html>