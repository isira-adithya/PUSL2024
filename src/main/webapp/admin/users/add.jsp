<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@include file="../includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <title>Add New User/Administrator - GreenSuperMarket</title>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div style="margin-left: 25px;">
    <form method="post" action="/api/admin/users/add">
        <p><b>Product Name: </b><input type="text" value="" name="productName"></p>
        <p>
            <b>Product Description: </b>
            <br>
            <textarea name="productDescription"></textarea>
        </p>
        <p><b>Product Price: </b><input type="text" value="" name="productPrice"></p>
        <p><b>Product Quantity: </b><input type="number" inputmode="numeric" value="" name="productQuantity"></p>
        <br><br>
        <input type="submit" value="Submit">
    </form>
</div>
<br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
