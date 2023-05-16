<%@ page import="dataNoBase.User" %>
<%@ page import="dataNoBase.UserDAO" %><%--
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

<%--recv session msg--%>
<%
    User user = (User) session.getAttribute("user");
    String login_status = (String) session.getAttribute("login_status");
    String username = user.getUsername();
%>

<%

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
    String user_logout = request.getParameter("user_logout");
    String delete_account = request.getParameter("delete_account");
%>

<%--parameters react--%>
<%
    if (user_logout!=null){
        session.setAttribute("login_status", "false");
        response.sendRedirect("login.jsp");
    }
    if (delete_account!=null && delete_account.equals("true")){
        UserDAO.deleteUserByUsername(username);
        response.sendRedirect("login.jsp");
    }
%>

<%--check parameters invalid--%>
<%
    if (user_logout!=null){
        session.setAttribute("login_status", false);
    }
%>

<%--change session msg by param--%>
<%
    
%>

<%--check session msg--%>
<%
    if (user == null){
        login_status = "false";
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "userMain.jsp");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")){
        response.sendRedirect("login.jsp");
    }
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<%--check parameters--%>
<%
    
%>


<html>
<head>
    <title><%=username%></title>
</head>
<body>
<div>
    用户名：<%=username%><br>
</div>


<div>
    <form action="userMain.jsp" method="post">
        <input type="hidden" name="user_logout">
        <button type="submit">退出登录</button>
    </form>
</div>

<div>
    <form action="shop.jsp">
        <div>
            <button>
                <img src="img/shop.jpg" alt="商店" height="50", width="50">
            </button>
        </div>
    </form>

</div>

<div>
    <form action="userMain.jsp">
        <input type="hidden" name="delete_account" value="true">
        <input type="submit" value="删除账户">
    </form>
</div>
</body>
</html>