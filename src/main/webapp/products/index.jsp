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

    pageContext.setAttribute("products", products);
    pageContext.setAttribute("searchQuery", searchQuery);
    pageContext.setAttribute("msg", msg);
%>
<html>
<head>
    <title>Products - GreenSuperMarket</title>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <center>
        <p><b>${fn:escapeXml(msg)}</b></p>
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
            <c:forEach items="${products}" var="product">
                <tr>
                    <td>${fn:escapeXml(product.name)}</td>
                    <td><img width="200px" src="${fn:escapeXml(product.image)}"></td>
                    <td>${fn:escapeXml(product.description)}</td>
                    <td>${product.quantity}</td>
                    <td>${product.price}$</td>
                    <td><a href="/products/product.jsp?id=${product.productId}">Open</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </center>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
