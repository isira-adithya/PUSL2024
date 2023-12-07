<%@ page import="com.isiraadithya.greensupermarket.models.User" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/7/2023
  Time: 9:47 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user_email = (String) session.getAttribute("email");
    User currentUser = User.FindUserByEmail(user_email);
%>
<html>
<head>
    <title>Profile</title>
</head>
<body>
    <form>
        <h3>Personal Information</h3>
        <label>Email: </label>
        <input type="text" disabled name="email" value="<%=currentUser.email%>"> <br>
        <label>First Name: </label>
        <input type="text" disabled name="firstname" value="<%=currentUser.firstname%>"> <br>
        <label>Last Name: </label>
        <input type="text" disabled name="lastname" value="<%=currentUser.lastname%>"> <br>
        <label>Phone: </label>
        <input type="text" disabled name="phone" value="<%=currentUser.phone%>"> <br>
        <hr>
        <h3>Address</h3>
        <label>Street/No: </label>
        <input type="text" disabled name="street_address" value="<%=currentUser.street_address%>"> <br>
        <label>City: </label>
        <input type="text" disabled name="city" value="<%=currentUser.city%>"> <br>
        <label>State: </label>
        <input type="text" disabled name="state" value="<%=currentUser.state%>"> <br>
        <label>Country: </label>
        <input type="text" disabled name="country" value="<%=currentUser.country%>"> <br>
        <label>Postal Code: </label>
        <input type="text" disabled name="postalcode" value="<%=currentUser.postalcode%>"> <br>
    </form>
</body>
</html>
