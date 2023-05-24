<%@ page import="dataNoBase.UserDAO" %>
<%@ page import="dataNoBase.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--no session--%>
<%
    if (session.isNew()){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
    Person person = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
//    用户信息错误，重新登陆
    if (person == null){
        response.sendRedirect("login.jsp");
        return;
    }
    if (login_status==null || !login_status){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--recv parameters--%>
<%
    String user_logout = request.getParameter("user_logout");
    String delete_account = request.getParameter("delete_account");
%>

<%--parameters react--%>
<%
//    退出登录操作
    if (user_logout!=null){
        session.removeAttribute("login_status");
        session.removeAttribute("person");
        session.removeAttribute("referenced");
        response.sendRedirect("login.jsp");
        return;
    }
//    删除账户操作
    if (delete_account!=null && delete_account.equals("true")){
        UserDAO.deleteUserByUsername(person.getName());
        session.removeAttribute("login_status");
        session.removeAttribute("person");
        session.removeAttribute("referenced");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--pre-action--%>
<%

%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<html>
<head>
    <title><%=person.getName()%></title>
    <link rel="stylesheet" href="css/userMain.css">
</head>
<body>
<div class="container">
    <div>
        <a href="<%=referenced%>">Click here to return</a>
    </div>
    <div class="text">
        <div class="line">
            Welcome <%=person.getName()%>
        </div>
        <div class="line">
            Identity: <%=person.getType()==1?"Customer":"Admin"%>
        </div>
        <div class="line">
            Email: <%=person.getEmail()%>
        </div>
        <div class="line">
            Cid: <%=person.getId()%>
        </div>
    </div>
<%--    修改密码--%>
    <div class="line">
        <a href="change_password.jsp">Click here to modify password</a>
    </div>
<%--    退出登录按钮--%>
    <div class="user_button">
        <form action="userMain.jsp" method="post">
            <input type="hidden" name="user_logout">
            <button type="submit">Log Out</button>
        </form>
    </div>
<%--    删除账户按钮--%>
    <div class="delete_button">
        <%if (person.getType()==1){%>
        <form action="userMain.jsp" method="post">
            <input type="hidden" name="delete_account" value="true">
            <input type="submit" value="Delete Account">
        </form>
        <%}%>
    </div>
</div>
</body>
</html>