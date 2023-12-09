<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 12/9/2023
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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
    <table border="1px">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Product Image</th>
            <th>Product Description</th>
            <th>Product Quantity</th>
            <th>Product Price</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <%
            for (int i = 0; products.length > i; i++){
        %>
            <tr>
                <td><% out.print(XSSPreventor.encodeToHtmlEntities(products[i].getName())); %></td>
                <td><img width="200px" src="<% out.print(XSSPreventor.encodeToHtmlEntities(products[i].getImage())); %>"></td>
                <td><% out.print(XSSPreventor.encodeToHtmlEntities(products[i].getDescription())); %></td>
                <td><% out.print(products[i].getQuantity()); %></td>
                <td><% out.print(products[i].getPrice()); %></td>
                <td><a href="/products/product.jsp?id=<% out.print(products[i].getProductId()); %>">Open</a></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</body>
</html>
