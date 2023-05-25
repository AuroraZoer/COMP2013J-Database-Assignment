<%@ page import="dataNoBase.Person" %>
<%@ page import="dataNoBase.AdminDAO" %>
<%@ page import="dataNoBase.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
  if (session.isNew()){
    session.setAttribute("referenced", "change_password.jsp");
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval() < 0) {
    session.setAttribute("referenced", "change_password.jsp");
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--session update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
  boolean login_status = (boolean) session.getAttribute("login_status");
  String referenced = (String) session.getAttribute("referenced");
  Person person = (Person) session.getAttribute("person");
%>

<%--session invalid--%>
<%
  if (!login_status){
    response.sendRedirect("login.jsp");
    return;
  }

  if (person == null){
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--recv parameters--%>
<%
  String password = request.getParameter("password");
  String confirm = request.getParameter("confirm");
%>

<%--parameters invalid--%>
<%

%>

<%--NullPointerException && NumberFormatException--%>
<%

%>

<%--parameters react--%>
<%
  if (confirm!=null && confirm.equals(password)) {
    if (person.getType() == 0) {
      AdminDAO.updateAdminPassword(person.getName(), password);
      session.setAttribute("person", AdminDAO.getAdminByUsername(person.getName()));
    }else {
      UserDAO.updateUserPassword(person.getName(), password);
      session.setAttribute("person", UserDAO.getUserByUsername(person.getName()));
    }
    session.setAttribute("referenced", "change_password.jsp");
    response.sendRedirect("userMain.jsp");
    return;
  }
%>

<%--pre-action--%>
<%

%>

<%--page--%>
<%--=========================================================================================================================================--%>


<html>
<head>
  <link rel="stylesheet" href="css/login.css">
  <title>Change password</title>
</head>
<body>


<div class="container">
  <h1>COMP2013J Databases and Info Sys</h1>
  <h2>Group3 Assignment</h2>
  <div class="login_box">
    <form action="change_password.jsp" method="post">
      <label class="username_box">Password:
        <input type="text" name="password" size="30" maxlength="20">
      </label><br>
      <label class="password_box">Confirm:
        <input type="password" name="confirm" size="30" maxlength="20">
      </label><br>

      <input type="submit" name="submit" value="Modify">
    </form>
  </div>
</div>
<%=password%>
<%=confirm%>
<%=person.getName()%>

</body>
</html>
