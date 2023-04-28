<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/25
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session--%>
<%--no session--%>
<%
  if (session.isNew()){
    session.setAttribute("login_status", "false");
  }
%>

<%--recv session msg--%>
<%
  String login_status = (String) session.getAttribute("login_status");
  String uid = (String) session.getAttribute("uid")wwwwwwwwadddwwwwwwwwawa22222
%>

<%--session outdate--w22
  if (session.getMaxInactiveInterval()<0){
    login_status = "false";
  }
%>

<%--session update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  String user_type = request.getParameter("user_type");
%>

<%--parameters react--%>
<%
  if (username==null){login_status="false";}
  if (password==null){login_status="false";}
  if (user_type==null){login_status="false";}
%>

<%--check parameters invalid--%>
<%
  if (username==null){username="null";}
  if (password==null){password="null";}
  if (user_type==null){user_type="null";}
  if (!user_type.equals("admin")&&!user_type.equals("user")){login_status="null";}
%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%

%>

<%--change session--%>
<%
  session.setAttribute("login_status", login_status);
  session.setAttribute("uid", uid);
  session.setAttribute("referenced", "login.jsp");
%>

<%--pre-action--%>
<%
  Boolean need_login = !login_status.equals("true");
%>


<html>
<head>
    <title>Create Your Account!</title>
</head>
<body>

</body>
</html>
