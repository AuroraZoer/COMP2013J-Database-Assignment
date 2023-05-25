<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="dataNoBase.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

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
  String type_str = request.getParameter("type");
  String email = request.getParameter("email");
  String password = request.getParameter("password");
  String delete_name = request.getParameter("delete_name");
  String second = request.getParameter("second");
%>

<%--NullPointerException && NumberFormatException--%>
<%
  int type = -1;
  try {
    type = Integer.parseInt(type_str);
  }catch (Exception ignored){
  }
%>

<%--parameters invalid--%>
<%

%>

<%--parameters react--%>
<%
  if (name!=null && password!=null && email!=null && second!=null) {
    if (type==1){
      UserDAO.deleteUserByUsername(name);
      UserDAO.insertUser(new User(1, name, password, email, null));
    }
    if (type==0){
      AdminDAO.deleteAdminByUsername(name);
      AdminDAO.insertAdmin(new Admin(1, name, password, email, null));
    }
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect(referenced);
    return;
  }
  else if (delete_name != null){
    if (type==1){
      UserDAO.deleteUserByUsername(delete_name);
    }
    if (type==0){
      AdminDAO.deleteAdminByUsername(delete_name);
    }
    session.setAttribute("referenced", "change_user.jsp");
    response.sendRedirect(referenced);
    return;
  }
%>

<%--pre-action--%>
<%

%>


<html>
<head>
  <title>Edit User</title>
  <link rel="stylesheet" href="css/commodity_admin.css">
</head>
<body>
<div class="container">
<form action="change_user.jsp">
  <div class="line">
  <label>New Name
    <input type="text" name="name" value="<%=name==null?"":name%>">
  </label>
  </div>
  <div class="line">
  <label>Type
    <input type="text" name="type" value="<%=type==-1?"":type%>">
  </label>
  </div>
  <div class="line">
  <label>Email
    <input type="text" name="email" value="<%=email==null?"":email%>">
  </label>
  </div>
  <div class="line">
  <label>Password
    <input type="text" name="password" value="<%=password==null?"":password%>">
  </label>
  </div>
  <div class="line">
    <input type="hidden" name="second" value="true">
  </div>
  <div class="button">
    <input type="submit" value="modify">
  </div>
  <a href="<%=referenced%>">Click here to return</a>
</form>
</div>
</body>
</html>