<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 13:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
if (true) {
    String[] data = getUserDAO(username, password);
    String name = data[0];
    String uid = data[1];
    String msg = data[2];
}
    %>
<form action="userMain.jsp">
    <input type="hidden" name="username" value="<%=name%>">
    <input type="hidden" name="uid" value="<%=uid%>">
    <input type="hidden" name="msg" value="<%=msg%>">
</form>
</body>
</html>
