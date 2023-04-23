<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/21
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--no session--%>
<%
    if (session.isNew()){
        session.setAttribute("login_status", "true");
    }
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

<%--recv session msg--%>
<%
    String login_status = (String) session.getAttribute("login_status");
    String uid = (String) session.getAttribute("uid");

%>

<%--check session msg--%>
<%
    Boolean need_login = login_status.equals("false");
%>

<%--session invalid--%>
<%

%>

<%--recv parameters--%>
<%

%>

<%--check parameters--%>
<%

%>

<%--parameter invalid--%>
<%
    
%>

<%--add new session--%>
<%
    session.setAttribute("referenced", "shop.jsp");
%>




<html>
<head>
    <title>Shop</title>
</head>
<body>

<div class="whole">
    <div class="left_box">
        <div class="left_box_item">
            
            
        </div>
    </div>
    
    <div class="mid_box">
        <div class="top_box">
            <div class="search_box">
                <form action="shop.jsp">
                    <input type="search" name="keyword" value="">
                </form>
            </div>
        </div>
        
    </div>
    
    
    
    
</div>




</body>
</html>
