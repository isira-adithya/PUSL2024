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
    <style>
body {
    text-align: center;
}

table {
    width: 80%;
    margin: 20px auto; /* Center the table */
    border-collapse: collapse;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

img {
    max-width: 100%;
    height: auto;
}

button {
    padding: 5px 10px;
    cursor: pointer;
}
#submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }
</style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        <a href="/admin/products/add.jsp">Add New Product</a>
        <br><br>
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
                    <td><center><img src="${fn:escapeXml(product.image)}" width="200px"></center></td>
                    <td>${fn:escapeXml(product.description)}</td>
                    <td>${fn:escapeXml(product.quantity)}</td>
                    <td>${fn:escapeXml(product.price)}</td>
                    <td>
                        <a href="/admin/products/product.jsp?id=${product.productId}"><button>Edit Product</button></a>
                        <form method="post" action="/api/admin/products/delete"><br>
                            
                            <input type="hidden" name="productId" value="${product.productId}">
                            
                            <input id="submitBtn" type="submit" value="Delete Product">
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
