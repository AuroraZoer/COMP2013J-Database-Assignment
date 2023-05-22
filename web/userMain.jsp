<%@ page import="dataNoBase.User" %>
<%@ page import="dataNoBase.UserDAO" %>
<%@ page import="dataNoBase.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        session.setAttribute("referenced", "userMain.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("referenced", "userMain.jsp");
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
%>

<%--session invalid--%>
<%
//    用户信息错误，重新登陆
    if (person == null){
        session.setAttribute("referenced", "userMain.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
    if (login_status==null || !login_status){
        session.setAttribute("referenced", "userMain.jsp");
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
        response.sendRedirect("login.jsp");
        return;
    }
//    删除账户操作
    if (delete_account!=null && delete_account.equals("true")){
        UserDAO.deleteUserByUsername(person.getName());
        session.setAttribute("login_status", false);
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
    <link rel="stylesheet" href="css/userMain.css">
    <title><%=person.getName()%>
    </title>
</head>
<body>
<div class="container">
    <div>
        用户名：<%=person.getName()%><br>
</div>


    <div>
        <form action="shop.jsp">
            <div>
                <button>
                    <img src="img/shop.jpg" alt="商店" height="50" width="50">
                </button>
            </div>
        </form>

    </div>

    <div>
        <div>
            Welcome <%=person.getName()%>
        </div>
        <div>
            Identity:<%=person.getType()==1?"Admin":"Customer"%>
        </div>
        <div>
            Email:<%=person.getEmail()%>
        </div>
        <div>
            Cid:<%=person.getId()%>
        </div>

    </div>


<%--    修改密码--%>
    <div>
        <a href="change_password.jsp">Click here to modify password</a>
    </div>


<%--    退出登录按钮--%>
    <div>
        <form action="userMain.jsp" method="post">
            <input type="hidden" name="user_logout">
            <button type="submit">退出登录</button>
        </form>
    </div>

<%--    删除账户按钮--%>
    <div>
        <%if (person.getType()==1){%>
        <form action="userMain.jsp" method="post">
            <input type="hidden" name="delete_account" value="true">
            <input type="submit" value="删除账户">
        </form>
        <%}%>
    </div>
</div>
</body>
</html>