<%@ page import="dataNoBase.PersonDAO" %>
<%@ page import="dataNoBase.Person" %><%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/19
  Time: 8:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%

%>

<%--recv session msg--%>
<%
  Boolean login_status = true;
  String referenced = (String) session.getAttribute("referenced");
  Person person = (Person) session.getAttribute("person");
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

<%--recv parameters--%>
<%
  String password = request.getParameter("password");
  String confirm = request.getParameter("confirm");
%>

<%

%>
<%--parameters react--%>
<%
  if (confirm == null) {
    login_status = false;
  }else if (password == null) {
    login_status = false;
  }else if (!referenced.equals("change_password")) {
    login_status = false;
  }
  if (confirm == null) {
    login_status = false;
  }

%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%

%>

<%--change session--%>
<%
  session.setAttribute("referenced", "change_password");
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
