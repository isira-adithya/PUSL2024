<%-- 
    Document   : index
    Created on : Dec 6, 2023, 10:10:22 PM
    Author     : isira_adithya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
    <%@include file="includes/header.jsp"%>
        <a href="/login.jsp">Customer Login</a> <br>
        <a href="/signup.jsp">Customer Signup</a> <br>
        <a href="/user/profile.jsp">Customer Profile</a> <br>
        <a href="/forgotpassword.jsp">Customer Forgot Password</a> <br>
        <a href="/logout.jsp">Logout</a> <br>

        <hr>

        <a href="/products">Products</a> <br>
    <%@include file="includes/footer.jsp"%>
    </body>
</html>
