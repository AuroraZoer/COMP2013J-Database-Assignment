<%@ page import="dataNoBase.PersonDAO" %>
<%@ page import="dataNoBase.Person" %><%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/19
  Time: 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session--%>
<%--no session--%>
<%
  if (session.isNew()){
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval() < 0) {
    response.sendRedirect("login.jsp");
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
  if (confirm==null || password==null){
    response.sendRedirect(referenced);
    return;
  }
%>

<%--NullPointerException && NumberFormatException--%>
<%

%>

<%--parameters react--%>
<%

%>

<%--set referenced--%>
<%
  session.setAttribute("referenced", "change_password.jsp");
%>

<%--pre-action--%>
<%
  if (login_status){
    PersonDAO.deletePersonByName(person.getName());
    PersonDAO.insertPerson(new Person(person.getId(), person.getName(), password, person.getEmail(), person.getCreateTime(), person.getType()));
    session.setAttribute("person", PersonDAO.getPersonByName(person.getName()));
    response.sendRedirect("userMain.jsp");
  }
%>


<html>
<head>
  <link rel="stylesheet" href="css/login.css">
  <title>Login</title>
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

      <input type="submit" name="submit" value="Login">
    </form>
    <a href="create_account.jsp">Click to create an account</a>
  </div>
</div>

<%--test--%>
<%=login_status%>
<%=password%>


</body>
</html>
