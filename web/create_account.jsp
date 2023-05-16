<%@ page import="dataNoBase.UserDAO" %>
<%@ page import="dataNoBase.User" %>
<%@ page import="java.sql.Timestamp" %><%--
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
    session.setAttribute("login_status", "true");
  }
%>

<%--recv session msg--%>
<%
  String login_status = (String) session.getAttribute("login_status");
  String uid = (String) session.getAttribute("uid");
  String referenced = (String) session.getAttribute("referenced");
%>

<%--session outdate--%>
<%
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
  String user_type = request.getParameter("usertype");
  String confirm = request.getParameter("confirm");
  String email = request.getParameter("email");
%>

<%--parameters react--%>
<%
  if (username==null){login_status="false";}
  if (password==null){login_status="false";}
  if (user_type==null){login_status="false";}
  if (confirm==null){login_status="false";}
  if (confirm==null){login_status="false";}
%>

<%--check parameters invalid--%>
<%
  if (username==null){username="null";}
  if (password==null){password="null";}
  if (user_type==null){user_type="null";}
  if (confirm==null){confirm = "null";}
  if (email==null){email = "";}
%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
  if (!referenced.equals("login")){
    login_status = "false";
    if (!user_type.equals("user")){login_status="false";}
    if (!confirm.equals(password)){login_status = "false";}
  }
%>

<%--change session--%>
<%
  session.setAttribute("login_status", login_status);
  session.setAttribute("uid", uid);
  session.setAttribute("referenced", "create_account");
%>

<%--pre-action--%>
<%
  Boolean need_login = !login_status.equals("true");
  if (!need_login){
    User user = new User(1,username,password,email,new Timestamp(new java.util.Date().getTime()));
    UserDAO.insertUser(user);
//    the bug may occur when MYSQL fail to insert user while jsp already use the user data.
    session.setAttribute("user", user);
    response.sendRedirect("shop.jsp");
  }
%>


<html>
<head>
    <title>Create Your Account!</title>
  <link rel="stylesheet" href="css/login.css">
</head>
<body>
<div class="container">
  <div class="login_box">
    <form action="create_account.jsp" method="post">
      <label class="username_box">Email:
        <input type="text" name="email" size="40" maxlength="20">
      </label><br>
      <label class="username_box">Username:
        <input type="text" name="username" size="30" maxlength="20">
      </label><br>
      <label class="password_box">Password:
        <input type="password" name="password" size="30" maxlength="20">
      </label><br>
      <label class="password_box">Confirm Password:
        <input type="password" name="confirm" size="30" maxlength="20">
      </label><br>
      <input type="hidden" name="uid" value="admin">
      <input type="submit" name="submit" value="sign up">
    </form>
  </div>
</div>
</body>
</html>
