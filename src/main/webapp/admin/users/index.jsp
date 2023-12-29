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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
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
        
         .buttons{
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            
            
            
        }
        
    .image {
      margin-bottom: 60px;
      width: 100%;
      height: 130px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
      background-image: url("/uploads/images/products/Breadcrumbs.png");
      background-size: cover;
      background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }
}
        
    </style>
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

         .buttons{
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;



        }

    .image {
      margin-bottom: 60px;
      width: 100%;
      height: 130px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
      background-image: url("/uploads/images/products/Breadcrumbs.png");
      background-size: cover;
      background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }
}

    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
        <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
        </div>

<div class="container">

    <div class="buttons">
        <div class="row">

            <button class="btn btn-primary col mx-2" onclick="window.location.href='/admin/users/add.jsp'">
                Add New User / Administrator
            </button>
            <c:if test="${selectedRole.equals('ADMIN')}">
                <button class="btn btn-secondary col mx-2" onclick="window.location.href='/admin/users/'">
                    See All Customers
                </button>
            </c:if><br>
            <c:if test="${selectedRole.equals('USER')}">
                <button class="btn btn-secondary col mx-2" onclick="window.location.href='/admin/users/?role=ADMIN'">
                    See All Administrators
                </button>
            </c:if>
        </div>
    </div>

    <div class="table-responsive mb-5">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Email</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Country</th>
            <th colspan="2">Actions</th>
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
                            <a class="btn btn-primary text-center" href="/admin/users/user.jsp?id=${user.userId}">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </a>
                    </td>
                    <td>
                        <button class="btn btn-danger text-center" onclick="if(confirm('Are you sure?')){document.getElementById('deleteUser${user.userId}Form').submit()}">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </td>
                    <form id="deleteUser${user.userId}Form" method="post" action="/api/admin/users/delete">
                        <input type="hidden" name="userId" value="${user.userId}">
                    </form>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    </div>
    
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>


                    
                      
                        
                    

