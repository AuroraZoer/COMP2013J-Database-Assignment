<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
  if (session.isNew()) {
    session.setAttribute("referenced", "manage.jsp");
    response.sendRedirect("login.jsp");
  }
%>

<%--session outdate--%>
<%
  if (session.getMaxInactiveInterval() < 0) {
    session.setAttribute("referenced", "manage.jsp");
    response.sendRedirect("login.jsp");
  }
%>

<%--sessionn update--%>
<%
  session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
  Person person = (Person) session.getAttribute("person");
  Boolean login_status = (Boolean) session.getAttribute("login_status");
  String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
  if (person == null) {
    session.setAttribute("referenced", "manage.jsp");
    response.sendRedirect("login.jsp");
    return;
  } else if (login_status==null || !login_status) {
    session.setAttribute("referenced", "manage.jsp");
    response.sendRedirect("login.jsp");
    return;
  } else if (person.getType() != 0 && person.getType() != 1) {
    session.setAttribute("referenced", "manage.jsp");
    response.sendRedirect("login.jsp");
    return;
  }
%>

<%--recv parameters--%>
<%
  String keyword = request.getParameter("keyword");
  String page_str = request.getParameter("page_num");
  String type = request.getParameter("type");
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

%>

<%--pre-action--%>
<%
  session.setAttribute("referenced", "manage.jsp");

  if (type==null){
    type = "admin";
  }

  List<Person> persons = new ArrayList<>();
  if (keyword==null) {
    if (type.equals("customer")) {
      persons = UserDAO.getUsersByPage(page_num);
    } else {
      persons = AdminDAO.getaAdminsByPage(page_num);
    }
  }else {
    Person person1 = null;
      if (type.equals("customer")) {
        person1 = UserDAO.getUserByUsername(keyword);
      }
      if (type.equals("admin")){
        person1 = AdminDAO.getAdminByUsername(keyword);
      }

    if (person1 != null)
      persons.add(person1);
  }
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>

<html>
<head>
  <title>Manage User</title>
  <link rel="stylesheet" href="css/manage.css">
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
      <a href="shop.jsp">Click here to manage commodities</a>
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
            <label>
              <input type="input_search" name="keyword" width="300px" height="50px" spellcheck="false"
                     placeholder="name">
            </label>
            <input type="hidden" name="type" value="<%=type%>">
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
          <br>
          <a href="change_user.jsp?delete_name=<%=each.getName()%>&type=<%=each.getType()%>">delete</a>
        </div>
        <div class="item_mid_box">
          <div class="item_top_box">
            <%=each.getName()%> <br>

          </div>
          <div class="item_bottom_box">
            User type: <%=each.getType()==1?"Customer":"Admin"%> <br>
          </div>
        </div>
        <div class="item_right_box">
          <span class="stock">
            Email: <%=each.getEmail()%> <br><br>
          </span>

          <span class="stock">
             Create time: <%=each.getCreateTime()%> <br>
          </span>
        </div>
      </div>
      <% } %>
    </div>

    <div class="pagination_box">
      <div class="create_button">
        <a href="change_user.jsp">
          <img src="img/add.png" alt="add" height="50" width="50">
        </a>
      </div>
      <div class="page">
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
  </div>

  <div class="right_box">
  <%--    用户界面--%>
    <div class="user">
    <a href="userMain.jsp">
      <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
    </a>
  </div>
  <%=person.getType()==1?"customer":"admin"%>

</div>
</div>

</body>
</html>

