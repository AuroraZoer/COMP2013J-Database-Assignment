<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
  if (session.isNew()) {
    response.sendRedirect("login.jsp");
  }
%>

<%--recv session msg--%>
<%
  Person person = (Person) session.getAttribute("person");
  Boolean login_status = (Boolean) session.getAttribute("login_status");
  String referenced = (String) session.getAttribute("referenced");
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
  String keyword = request.getParameter("keyword");
  String page_str = request.getParameter("page_num");
  String type = request.getParameter("type");
  Boolean status = true;
%>

<%--check parameters invalid--%>
<%
  int page_num = 1;
  try {
    page_num = Integer.parseInt(page_str);
  } catch (Exception ignored) {}

%>

<%--parameters react--%>
<%
  if (type==null){
    type = "admin";
  }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
  if (person == null) {
    response.sendRedirect("login.jsp");
  } else if (!login_status) {
    response.sendRedirect("login.jsp");
  } else if (person.getType() != 0 && person.getType() != 1) {
    response.sendRedirect("login.jsp");
  }
%>

<%--change session--%>
<%
  session.setAttribute("referenced", "manage");

%>

<%--pre-action--%>
<%

%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<%--初始化--%>
<%
  List<Person> persons = null;
  if (type.equals("customer")) {
    persons =  UserDAO.getUsersByPage(page_num);
  }
  else {
    persons = AdminDAO.getaAdminsByPage(page_num);
  }
%>


<html>
<head>
  <title>Shop</title>
  <link rel="stylesheet" href="css/shop.css">
</head>
<body>

<div class="whole">
  <div class="left_box">
    <div class="left_box_item">
      <div>
        <form action="manage.jsp" method="post">
          <input type="hidden" name="type" value="admin">
          <button type="submit"><span>Admin</span><br></button>
        </form>
      </div>

      <div>
        <form action="manage.jsp" method="post">
          <input type="hidden" name="type" value="customer">
          <button type="submit"><span>Customer</span><br></button>
        </form>
      </div>
    </div>
  </div>

  <div class="mid_box">
    <div class="top_box">
      <div class="outer_search_box">
        <div class="left_input_box">
          Please enter the name of the user you are looking for:
        </div>
        <div class="right_input_box">
          <form action="manage.jsp" method="get">
            <div class="input_wrapper">
              <input type="input_search" name="keyword" width="80000px" height="50px" spellcheck="false"
                     placeholder="name">
            <button type="submit">
              <img src="img/search_icon.png" alt="搜索" width="40px" height="40px">
            </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="main_box">
      <% for (Person each : persons) { %>
      <div class="item_box" id="item_box1">
        <div class="item_left_box">
          <%=each.getId()%> <br>
          <a href="change_user.jsp?name=<%=each.getName()%>&email=<%=each.getEmail()%>&password=<%=each.getPassword()%>&type=<%=each.getType()%>">edit</a>
        </div>
        <div class="item_mid_box">
          <div class="item_top_box">
            <%=each.getName()%> <br>

          </div>
          <div class="item_bottom_box">
            Cid:<%=each.getType()==1?"Customer":"Admin"%> <br>
          </div>
        </div>
        <div class="item_right_box">
          <span class="price">
            <%=each.getEmail()%> <br>
          </span>

          <span class="stock">
              <%=each.getCreateTime()%> <br>
          </span>
        </div>
      </div>
      <% } %>
    </div>

    <div class="pagination_box">
      <div class="last_page">
        <form action="manage.jsp" method="post">
          <input type="hidden" name="type" value="<%=type%>">
          <input type="hidden" name="page_num" value="<%=page_num<=1?1:page_num-1 %>">
          <%if (keyword != null) {%>
          <input type="hidden" name="keyword" value="<%=keyword%>">
          <%}%>
          <input type="submit" value="last page">
        </form>
      </div>

      <div class="next_page">
        <form action="manage.jsp" method="post">
          <input type="hidden" name="type" value="<%=type%>">
          <input type="hidden" name="page_num" value="<%=persons.size()<10?page_num:page_num+1 %>">
          <%if (keyword != null) {%>
          <input type="hidden" name="keyword" value="<%=keyword%>">
          <%}%>
          <input type="submit" value="next page">
        </form>
      </div>
    </div>
  </div>


  <%--    用户界面--%>
  <div>
    <a href="userMain.jsp">
      <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
    </a>
  </div>

  <%--    购物车--%>
  usertype:
  <%=type%>

</div>


</body>
</html>

