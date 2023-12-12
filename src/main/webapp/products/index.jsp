<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 12/9/2023
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String searchQuery = "";
    String msg = "";
    List<Product> products = new ArrayList<Product>();

    if (request.getParameterMap().containsKey("msg")){
        msg = request.getParameter("msg");
    }

    if (request.getParameterMap().containsKey("searchQuery")){
        searchQuery = request.getParameter("searchQuery");
    }

    if (searchQuery.isBlank()){
        products = Product.getProducts();
    } else {
        products = Product.findProductsByName(searchQuery);
    }

    if (products.size() <= 0){
        response.sendRedirect("/products/?msg=No Products Found");
        return;
    }
%>
<html>
<head>
    <title>Products - GreenSuperMarket</title>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <center>
        <form action="/products/" method="get">
            <label>Search</label>
            <input type="text" name="searchQuery" value="<% out.print(XSSPreventor.encodeToHtmlEntities(searchQuery)); %>">
            <input type="submit" value="Submit">
        </form>
        <p><b><% out.print(XSSPreventor.encodeToHtmlEntities(msg)); %></b></p>
        <br>
        <br>
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
                for (int i = 0; products.size() > i; i++){
            %>
            <tr>
                <td><% out.print(XSSPreventor.encodeToHtmlEntities(products.get(i).getName())); %></td>
                <td><img width="200px" src="<% out.print(XSSPreventor.encodeToHtmlEntities(products.get(i).getImage())); %>"></td>
                <td><% out.print(XSSPreventor.encodeToHtmlEntities(products.get(i).getDescription())); %></td>
                <td><% out.print(products.get(i).getQuantity()); %></td>
                <td><% out.print(products.get(i).getPrice()); %>$</td>
                <td><a href="/products/product.jsp?id=<% out.print(products.get(i).getProductId()); %>">Open</a></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </center>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
