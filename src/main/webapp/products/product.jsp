<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = -1;
    Product product;
    if (request.getParameterMap().containsKey("id")){
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException ex){
            id = -1;
        }
    }
    if (id >= 0){
        product = Product.findProductById(id);
        if (product.getName().equals("NULL")){
            response.sendRedirect("/products/");
            return;
        }
    } else {
        response.sendRedirect("/products/");
        return;
    }
%>
<html>
<head>
    <title><% out.print(XSSPreventor.encodeToHtmlEntities(product.getName())); %> - Green SuperMarket</title>
</head>
<body>
    <img width="500px" src="<% out.print(XSSPreventor.encodeToHtmlEntities(product.getImage())); %>">
    <p><b>Product Name: </b><% out.print(XSSPreventor.encodeToHtmlEntities(product.getName())); %></p>
    <p><b>Product Description: </b><% out.print(XSSPreventor.encodeToHtmlEntities(product.getDescription())); %></p>
    <p><b>Product Price: </b><% out.print(product.getPrice()); %>$</p>
    <p><b>Product Quantity: </b><% out.print(product.getQuantity()); %></p>
</body>
</html>
