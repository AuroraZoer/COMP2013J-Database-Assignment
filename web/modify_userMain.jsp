<%@ page import="dataNoBase.*" %><%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/19
  Time: 9:26
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
    String email = request.getParameter("email");
    String name = request.getParameter("name");
%>

<%
    if (person == null) {
        response.sendRedirect("userMain.jsp");
        return;
    }
%>
<%--parameters react--%>
<%
    if (email == null) {
        login_status = false;
    }else if (name == null) {
        login_status = false;
    }else if (!referenced.equals("modify_userMain")) {
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
    session.setAttribute("referenced", "modify_userMain");
%>

<%--pre-action--%>
<%
    if (login_status){
        if (person.getType()==1) {
            UserDAO.deleteUserByUsername(person.getName());
            UserDAO.insertUser(new User(person.getId(), name, person.getPassword(), email, person.getCreateTime()));
            session.setAttribute("person", UserDAO.getUserByUsername(person.getName()));
            response.sendRedirect("userMain.jsp");
            return;
        }else {
            AdminDAO.deleteAdminByUsername(person.getName());
            AdminDAO.insertAdmin(new Admin(person.getId(), name, person.getPassword(), email, person.getCreateTime()));
            session.setAttribute("person", AdminDAO.getAdminByUsername(person.getName()));
            response.sendRedirect("userMain.jsp");
            return;
        }
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="modify_userMain.jsp">
    <label>Name:
        <input type="text" name="name" placeholder="<%=person.getName()%>">
    </label>
    <br>
    <label>Email:
        <input type="text" name="email" placeholder="<%=person.getName()%>">
    </label>
    <input type="submit" value="modify">
</form>

</body>
</html>
