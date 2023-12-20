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
    <style>
        body {
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto; /* Center the table */
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            font-weight: normal;
            font-size: 17px;
        }

       

        button {
            padding: 5px 10px;
            cursor: pointer;
        }

        #submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }

        .submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }

        .Add-new-button {
            padding: 10px 15px;
            font-size: 23px;
            background-color: #00B207; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 30px;
            cursor: pointer;
            width: 800px;
        }

        .icon {
            width: 30px;
            height: 30px;
        }
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div>

    <br><br>
    <table>
        <thead>
        <tr>
            <th>Email</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Country</th>
            <th></th>
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
                    <td><center><br>
                        <a href="/admin/users/user.jsp?id=${user.userId}"><button class="submitBtn">Edit User</button></a>
                        <form method="post" action="/api/admin/users/delete"><br>
                            <input type="hidden" name="userId" value="${user.userId}">
                            <input id="submitBtn" type="submit" value="Delete">
                        </form></center>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    
     <button class="Add-new-button" onclick="window.location.href='/admin/users/add.jsp'">Add New User / Administrator</button>
        <br><br>
        
    <c:if test="${selectedRole.equals('ADMIN')}">
        
        <button class="Add-new-button" onclick="window.location.href='/admin/users/'">See all customers</button>

    </c:if>
    <c:if test="${selectedRole.equals('USER')}">
        <button class="Add-new-button" onclick="window.location.href='/admin/users/?role=ADMIN'">See all administrators</button>
    </c:if>
        
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>

