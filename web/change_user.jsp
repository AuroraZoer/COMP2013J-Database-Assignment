<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="dataNoBase.*" %><%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/20
  Time: 13:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  if (session.isNew()) {
    response.sendRedirect("login.jsp");
  }
%>

<%--recv session msg--%>
<%
  Admin admin = (Admin) session.getAttribute("person");
  Boolean login_status = (Boolean) session.getAttribute("login_status");
  String referenced = (String) session.getAttribute("referenced");
  boolean back = false;
  boolean status = true;
%>

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval() < 0) {
    response.sendRedirect("login.jsp");
  }
%>

<%--sessionn update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
  String name = request.getParameter("name");
  String action = request.getParameter("action");
  String type_str = request.getParameter("type");
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  String new_name = request.getParameter("new_name");
%>

<%--check parameters invalid--%>
<%
  
%>

<%--parameters react--%>
<%
  int type = -1;
  try {
    type = Integer.parseInt(type_str);
  }catch (Exception ignored){}
  

  if (name == null || email==null || password==null) {
    name = name == null? "":name;
    email = email == null? "":email;
    password = password == null? "":password;
    back = true;
  }if (type!=0 && type!=1){
    back = true;
  if (action==null){
    status = false;
  }else if (!action.equals("delete") && !action.equals("create") && !action.equals("modify")) {
    status = false;
  } if (new_name==null){
    status = false;
  }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
  if (admin == null) {
//    back = true;
  }
  if (!login_status) {
//    back = true;
  }
%>

<%--change session--%>
<%
  session.setAttribute("referenced", "change_user");
%>

<%--pre-action--%>
<%
//  if (back){
//    response.sendRedirect("manage.jsp");
//    return;
//  }

  if (status) {
    switch (action) {
      case "create":
//        set param from admindao/userdao
        if (type == 0)
          AdminDAO.insertAdmin(new Admin(1, new_name, password, email, new Timestamp(new Date().getTime())));
        else
          UserDAO.insertUser(new User(1, new_name, password, email, new Timestamp(new Date().getTime())));
        break;
      case "delete":
        if (type == 0) {
          AdminDAO.deleteAdminByUsername(name);
        }
        else {
          UserDAO.deleteUserByUsername(name);
        }
       break;
      case "modify":
        if (type == 0) {
          AdminDAO.deleteAdminByUsername(name);
          AdminDAO.insertAdmin(new Admin(1, new_name, password, email, new Timestamp(new Date().getTime())));
        }else {
          UserDAO.deleteUserByUsername(name);
          UserDAO.insertUser(new User(1, new_name, password, email, new Timestamp(new Date().getTime())));
        }
        break;
    }
    response.sendRedirect("manage.jsp");
    return;
  }
%>
<%--session事件--%>
<%--=========================================================================================================================================--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>

<form action="change_user.jsp">
  <label>New Name
    <input type="text" name="new_name" value="<%=name%>">
  </label>
  <br>
  <label>Type
    <input type="text" name="type" value="<%=type%>">
  </label>
  <br>
  <label>Email
    <input type="text" name="email" value="<%=email%>">
  </label>
  <br>
  <label>Password
    <input type="text" name="password" value="<%=password%>">
  </label>
  <br>
  <label>Delete
    <input type="radio" name="action" value="delete">
  </label>
  <label>Create
    <input type="radio" name="action" value="create">
  </label>
  <label>Modify
    <input type="radio" name="action" value="modify">
  </label>
  <input type="hidden" name="name" value="<%=name%>">
  <input type="submit" value="confirm">
</form>

<%=name%>
<%=new_name%>

<%=email%>
<%=action%>
<%=type%>


</body>
</html>