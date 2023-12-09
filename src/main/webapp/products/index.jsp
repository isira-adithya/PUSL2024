<%@ page import="com.isiraadithya.greensupermarket.models.Product" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 12/9/2023
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Product[] products = Product.getProducts();
    if (products.length <= 0){
        response.setHeader("X-Debug", "No Products Available");
        response.sendRedirect("/");
        return;
    }
%>
<html>
<head>
    <title>Products - GreenSuperMarket</title>
</head>
<body>
    
</body>
</html>
