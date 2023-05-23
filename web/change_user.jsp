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

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval() < 0) {
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--sessionn update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
  Admin admin = (Admin) session.getAttribute("person");
  Boolean login_status = (Boolean) session.getAttribute("login_status");
  String referenced = (String) session.getAttribute("referenced");
  boolean status = true;
%>

<%--session invalid--%>
<%
  if (admin == null){
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect("login.jsp");
    return;
  }
  if (admin.getType()!=0){
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect(referenced);
  }
  if (login_status==null || !login_status){
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect("login.jsp");
    return;
  }
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

<%--NullPointerException && NumberFormatException--%>
<%
  int type = -1;
  try {
    type = Integer.parseInt(type_str);
  }catch (Exception ignored){}

  name = name==null?"":name;
  email = email==null?"":email;
  password = password==null?"":password;
  new_name = new_name==null?"":new_name;
%>

<%--parameters invalid--%>
<%
  if (type!=0 && type!=1) {
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect("manage.jsp");
    return;
  }
%>

<%--parameters react--%>
<%
  if (action!=null && action.equals("modify")) {
    if (type==1){
      UserDAO.deleteUserByUsername(name);
      UserDAO.insertUser(new User(1, new_name, password, email, null));
    }
    if (type==0){
      AdminDAO.deleteAdminByUsername(name);
      AdminDAO.insertAdmin(new Admin(1, new_name, password, email, null));
    }
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect("manage.jsp");
    return;
  }
%>

<%--pre-action--%>
<%

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
  <input type="submit" value="modify">
</form>

</body>
</html>