<%--
  Created by IntelliJ IDEA.
  User: zzy13
  Date: 2023/5/20
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="dataNoBase.*" %>
<%@ page import="java.sql.Timestamp" %><%--
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
  String category_str = request.getParameter("category_str");
  String old_person_name = request.getParameter("old_person_name");
  String person_name = request.getParameter("person_name");
  String person_email = request.getParameter("person_email");
  String person_id_str = request.getParameter("person_id");
  String person_type = request.getParameter("person_type");
  String person_password = request.getParameter("person_password");
  String operation = request.getParameter("operation");
  String type = request.getParameter("type");
  int person_id = -1;
  int person_type_num = -1;
  Boolean status = true;
%>

<%--check parameters invalid--%>
<%
  int page_num = 1;
  int category_num = 1;
  try {
    page_num = Integer.parseInt(page_str);
  } catch (Exception ignored) {}
  try {
    category_num = Integer.parseInt(category_str);
  } catch (Exception ignored) {}

%>

<%--parameters react--%>
<%
  try{
    person_id = Integer.parseInt(person_id_str);
    person_type_num = Integer.parseInt(person_type);
  }catch (Exception e){
    status = false;
  }
  if (!operation.equals("delete") && !operation.equals("create") && !operation.equals("modify")) {
    status = false;
  }
  else if (person_name == null || person_email==null || person_id==-1 || person_type_num==-1 || person_password==null || old_person_name==null) {
    person_name = person_name == null? "":person_name;
    person_email = person_email == null? "":person_email;
    person_type_num = person_type_num == -1? 0:person_type_num;
    old_person_name = old_person_name == null? "":old_person_name;
    status = false;
  }
  else if (type==null || (!type.equals("customer") && !type.equals("admin"))) {
    type = "customer";
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
  } else if (person_id==-1 || person_type_num == -1){
    status = false;
  }
%>

<%--change session--%>
<%
  session.setAttribute("referenced", "manage");

%>

<%--pre-action--%>
<%
  if (status) {
    switch (operation) {
      case "create" ->
              PersonDAO.insertPerson(new Person(person_id, person_name, person_password, person_email, new Timestamp(new java.util.Date().getTime()), person_type_num));
      case "delete" -> PersonDAO.deletePersonByName(person_name);
      case "modify" -> {
        PersonDAO.deletePersonByName(old_person_name);
        PersonDAO.insertPerson(new Person(person_id, person_name, person_password, person_email, new Timestamp(new java.util.Date().getTime()), person_type_num));
      }
    }

//    response.sendRedirect(referenced);
  }
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
//  List<Commodity> commodities = null;
//  if (keyword == null)
//    commodities = CommodityDAO.getCommoditiesByCategory(categories.get(category_num - 1).getName(), page_num);
//  else
//    commodities = CommodityDAO.getCommoditiesByCategory(keyword, page_num);
%>


<html>
<head>
  <title>Shop</title>
  <link rel="stylesheet" href="css/shop.css">
<%--  <style>--%>
<%--    #cate<%=category_num%> {--%>
<%--      /*    高亮显示span*/--%>
<%--    }--%>
<%--  </style>--%>


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
        <div class="inner_search_box">
          <form action="manage.jsp" method="get">
            <label>
              <input type="search" name="keyword" width="300px" height="50px" spellcheck="false"
                     placeholder="员工姓名">
            </label>
            <button type="submit">
              <img src="img/search_icon.png" alt="搜索" width="50px" height="50px">
            </button>
          </form>
        </div>
      </div>
    </div>
    <div class="main_box">
      <% for (Person each : persons) { %>
      <div class="item_box" id="item_box1">
        <div class="item_left_box">
          <%=each.getType()==1?"Customer":"Admin"%> <br>
          <a href="commodity_admin.jsp?category=<%=commodity.getCategory()%>&cid=<%=commodity.getCid()%>&name=<%=commodity.getItemName()%>&price=<%=commodity.getPrice()%>&stock=<%=commodity.getStock()%>">edit</a>
        </div>
        <div class="item_mid_box">
          <div class="item_top_box">
            <%=commodity.getItemName()%> <br>

          </div>
          <div class="item_bottom_box">
            Cid:<%=commodity.getCid()%> <br>
          </div>
        </div>
        <div class="item_right_box">
                    <span class="price">
                        ¥<%=commodity.getPrice()%> <br>
                    </span>

          <span class="stock">
                        Stock :<%=commodity.getStock()%> <br>
                    </span>
        </div>
      </div>
      <% } %>
    </div>

    <div class="pagination_box">
      <div class="last_page">
        <form action="manage.jsp" method="post">
          <input type="hidden" name="category_str" value="<%=category_num%>">
          <input type="hidden" name="page_num" value="<%=page_num<=1?1:page_num-1 %>">
          <%if (keyword != null) {%>
          <input type="hidden" name="keyword" value="<%=keyword%>">
          <%}%>
          <input type="submit" value="last page">
        </form>
      </div>

      <div class="next_page">
        <form action="manage.jsp" method="post">
          <input type="hidden" name="category_str" value="<%=category_num%>">
          <input type="hidden" name="page_num" value="<%=commodities.size()<10?page_num:page_num+1 %>">
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
  <%=user_type%>

</div>


</body>
</html>

