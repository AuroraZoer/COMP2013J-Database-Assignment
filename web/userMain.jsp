<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/18
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String uid = request.getParameter("uid");%>
<html>
<head>
    <title><%=request.getParameter("username")%></title>
</head>
<body>
<div>
    用户名：<%=request.getParameter("username")%><br>
    uid：<%=request.getParameter("uid")%><br>
    信息：<%=request.getParameter("msg")%>
</div>

收藏夹：<%=UserDAO.getSCJ(uid)%>
</body>
</html>
