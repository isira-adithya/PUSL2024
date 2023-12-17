<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/variables.jsp"%>
<%
    List<User> users = User.getUsers();
    pageContext.setAttribute("users", users);
    String selectedRole = "USER";
    if (request.getParameterMap().containsKey("role")){
        if (request.getParameter("role").equals("ADMIN")){
            selectedRole = "ADMIN";
        }
    }
    pageContext.setAttribute("selectedRole", selectedRole);
%>
<html>
<head>
    <title>Manage Users</title>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div>
    <a href="/admin/users/add.jsp">Add New User / Administrator</a> <br><br>
    <c:if test="${selectedRole.equals('ADMIN')}">
        <a href="/admin/users/">See all customers</a>
    </c:if>
    <c:if test="${selectedRole.equals('USER')}">
        <a href="/admin/users/?role=ADMIN">See all administrators</a>
    </c:if>

    <br><br>
    <table border="1px">
        <thead>
        <tr>
            <th>Email</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Country</th>
            <th>Operations</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${users}" var="user">
            <c:if test="${user.role.equals(selectedRole)}">
                <tr>
                    <td>${fn:escapeXml(user.email)}</td>
                    <td>${fn:escapeXml(user.firstname)}</td>
                    <td>${fn:escapeXml(user.lastname)}</td>
                    <td>${fn:escapeXml(user.country)}</td>
                    <td>
                        <a href="/admin/users/user.jsp?id=${user.userId}"><button>Edit User</button></a>
                        <form method="post" action="/api/admin/users/delete">
                            <input type="hidden" name="userId" value="${user.userId}">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
