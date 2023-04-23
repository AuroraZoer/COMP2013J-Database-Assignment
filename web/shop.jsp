<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/21
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
    if (session.isNew()){
        session.setAttribute("login_status", "true");
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

<%--change session--%>
<%
    session.setAttribute("referenced", "shop.jsp");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")){
        response.sendRedirect("");
    }
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>




<html>
<head>
    <title>Shop</title>
    <script type="text/javascript" language="javascript">
        document.getElementById("select_button").onclick = function (){
        //     onclick事件
            
        }
    </script>



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
                    <label>
                        <input type="search" name="keyword">
                    </label>
                </form>
            </div>
            
            <div class="select">
                <button id="select_button">
                <img src="/img/select_icon.jpg" alt="筛选" height="50" width="50">
                </button>
            </div>
        </div>
        
    </div>
    
    
    
    
</div>




</body>
</html>
