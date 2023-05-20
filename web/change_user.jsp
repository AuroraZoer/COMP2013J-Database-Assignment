<%@ page import="dataNoBase.AdminDAO" %>
<%@ page import="dataNoBase.Admin" %>
<%@ page import="dataNoBase.PersonDAO" %>
<%@ page import="dataNoBase.Person" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %><%--
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
  Boolean status = true;
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
  String id_str = request.getParameter("id");
  String new_name = request.getParameter("new_name");
%>

<%--check parameters invalid--%>
<%
  
%>

<%--parameters react--%>
<%
  int type = -1;
  int id = -1;
  try {
    type = Integer.parseInt(type_str);
    id = Integer.parseInt(id_str);
  }catch (Exception ignored){}
  
  if (!action.equals("delete") && !action.equals("create") && !action.equals("modify")) {
    status = false;
  }
  else if (name == null || email==null || id==-1 || type==-1 || password==null) {
    name = name == null? "":name;
    email = email == null? "":email;
    password = password == null? "":password;
    back = true;
  }else if (action==null || new_name == null){
    status = false;
  }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
  if (admin == null) {
    back = true;
  }
  if (!login_status) {
    back = true;
  }
%>

<%--change session--%>
<%
  session.setAttribute("referenced", "change_user");
%>

<%--pre-action--%>
<%
  if (back){
    response.sendRedirect("manage.jsp");
  }

  if (status) {
    switch (action) {
      case "create" ->
              PersonDAO.insertPerson(new Person(id, name, password, email, new Timestamp(new Date().getTime()), type));
      case "delete" -> PersonDAO.deletePersonByName(name);
      case "modify" -> {
        PersonDAO.deletePersonByName(name);
        PersonDAO.insertPerson(new Person(id, name, password, email, new Timestamp(new Date().getTime()), type));
      }
    }
    response.sendRedirect(referenced);
    
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
    <input type="text" name="new_name" placeholder="<%=name%>">
  </label>
  <br>
  <label>id
    <input type="text" name="cid" placeholder="<%=id==-1?"":id%>">
  </label>
  <br>
  <label>Stock
    <input type="text" name="stock" placeholder="<%=type==1?"admin":"customer"%>">
  </label>
  <br>
  <label>Delete
    <input type="radio" name="action" value="delete">
  </label>
  <label>Create
    <input type="radio" name="action" value="create">
  </label>
  <br>
  <label>Modify
    <input type="radio" name="action" value="modify">
  </label>
  <input type="submit" value="confirm">
</form>


</body>
</html>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
