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

<%--recv session msg--%>
<%
    String uid = (String)session.getAttribute("uid");
    String login_status = (String) session.getAttribute("login_status")
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

    String login_status = (String) session.getAttribute("login_status");
    String uid = (String) session.getAttribute("uid");


%>

<%--parameters react--%>
<%

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

<%--check uid--%>
<%

%>

<%--pre-action--%>
<%

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
