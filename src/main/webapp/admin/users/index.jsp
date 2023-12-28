<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/includes/variables.jsp"%>
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

        .table {
            width: 80%;
            margin: 20px auto; /* Center the table */
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
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
        
         .buttons{
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            
            
            
        }
        .custom-button{
            width:150px;
            border-radius: 100px;
            
        }


       

        .icon {
            width: 30px;
            height: 30px;
        }
        .image{
            margin-bottom: 5px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
        
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
        <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
        </div>

<div
 
class="container">

    
<div class="table-responsive">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Email</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Country</th>
            <th>Actions</th>
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
                        <center>
                            <br>
                            <a href="/admin/users/user.jsp?id=${user.userId}"><button class="submitBtn">Edit User</button></a>
                            <form id="deleteUser${user.userId}Form" method="post" action="/api/admin/users/delete"><br>
                                <input type="hidden" name="userId" value="${user.userId}">
                            </form>
                            <button onclick="if(confirm('Are you sure?')){document.getElementById('deleteUser${user.userId}Form').submit()}" id="submitBtn">Delete</button>
                        </center>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    
    <div class="buttons">
        <div class="row">
            
        <button class="btn btn-primary col mx-2 "  onclick="window.location.href='/admin/users/add.jsp'" style="background-color: #00B207;">
        Add New User / Administrator                 
        </button>
            
            
            
    <c:if test="${selectedRole.equals('ADMIN')}">
        
        <button class="btn btn-primary "  onclick="window.location.href='/admin/users/?role=ADMIN'" style="background-color: #00B207;">
        See All Administrators                  
        </button>

    </c:if><br>
    <c:if test="${selectedRole.equals('USER')}">
          
                        <button class="btn btn-primary col mx-2"  onclick="window.location.href='/admin/users/'" style="background-color: #00B207;">
                            See All Customers
                        </button>
    </c:if>
    </div>
   </div>     
</div>
    
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>


                    
                      
                        
                    

