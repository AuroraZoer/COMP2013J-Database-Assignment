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

<%--recv session msg--%>
<%
    String uid = (String)session.getAttribute("uid");
    String login_status = (String) session.getAttribute("login_status");
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
%>

<%--parameters react--%>
<%

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
    if (uid == null){
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
    <title><%=request.getParameter("username")%></title>
</head>
<body>
<div>
    用户名：<%=request.getParameter("username")%><br>
    uid：<%=uid%><br>
    信息：<%=request.getParameter("msg")%>
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
</body>
</html>