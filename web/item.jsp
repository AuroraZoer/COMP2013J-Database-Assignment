<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/24
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
  if (session.isNew()){
    response.sendRedirect("login.jsp");
  }
%>

<%--recv session msg--%>
<%
  String uid = (String)session.getAttribute("uid");
  String login_status = (String) session.getAttribute("login_status");
%>

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval()<0){
    session.setAttribute("login_status", "true");
  }
%>

<%--sessionn update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
  String item = request.getParameter("item_id");
%>

<%--parameters react--%>
<%
  if (item==null){
    item="null";
  }
%>

<%--check parameters invalid--%>
<%

%>

<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
  if (uid == null){
    login_status = "false";
  }
%>

<%--change session--%>
<%
  session.setAttribute("referenced", "userMain.jsp");
%>

<%--pre-action--%>
<%
  if (!login_status.equals("true")){
    response.sendRedirect("login.jsp");
  }
  session.setAttribute("referenced", "item");
  
%>
<html>
<head>
    <title><%=item%>></title>
</head>
<body>
  this is Item
</body>
</html>
