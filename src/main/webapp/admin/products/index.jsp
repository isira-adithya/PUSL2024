<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/variables.jsp"%>
<%
    List<Product> products = Product.getProducts();
    pageContext.setAttribute("products", products);
%>
<html>
<head>
    <title>Manage Products</title>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        <table border="1px">
            <thead>
            <tr>
                <th>Product Name</th>
                <th>Product Image</th>
                <th>Product Description</th>
                <th>Product Quantity</th>
                <th>Product Price</th>
                <th>Operations</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${products}" var="product">
                <tr>
                    <td>${fn:escapeXml(product.name)}</td>
                    <td><img src="${fn:escapeXml(product.image)}" width="200px"></td>
                    <td>${fn:escapeXml(product.description)}</td>
                    <td>${fn:escapeXml(product.quantity)}</td>
                    <td>${fn:escapeXml(product.price)}</td>
                    <td>
                        <a href="/admin/products/product.jsp?id=${product.productId}"><button>Edit Product</button></a>
                        <form method="post" action="/api/admin/products/delete">
                            <input type="hidden" name="productId" value="${product.productId}">
                            <input type="submit" value="Delete Product">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
