<%@ page import="dataNoBase.User" %>
<%@ page import="dataNoBase.UserDAO" %>
<%@ page import="dataNoBase.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        response.sendRedirect("login.jsp");
    }
%>

<%--recv session msg--%>
<%
    Person person = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
%>

<%

%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        response.sendRedirect("login.jsp");
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
        response.sendRedirect("login.jsp");
    }
    if (delete_account!=null && delete_account.equals("true")){
        UserDAO.deleteUserByUsername(person.getName());
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
    if (person == null){
        response.sendRedirect("login.jsp");
    }
    if (!login_status){
        response.sendRedirect("login.jsp");
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "userMain.jsp");
%>

<%--pre-action--%>
<%

%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<%--check parameters--%>
<%
    
%>


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
        <form action="userMain.jsp" method="post">
            <input type="hidden" name="user_logout">
            <button type="submit">退出登录</button>
        </form>
</div>

    <div>
        <form action="shop.jsp">
            <div>
                <button>
                    <img src="img/shop.jpg" alt="商店" height="50" , width="50">
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

        <a href="change_password.jsp"></a>

    </div>

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