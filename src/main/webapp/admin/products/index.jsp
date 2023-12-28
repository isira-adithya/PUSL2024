<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/includes/variables.jsp"%>
<%
    List<Product> products = Product.getProducts();
    pageContext.setAttribute("products", products);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <style>
        body {
            text-align: center;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            text-align: center;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
            font-weight: normal;
            font-size: 17px;
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
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }

        .submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }

        .button {
            padding-left: 150px;
            padding-right: 10px;
        }

        .icon {
            width: 30px;
            height: 30px;
        }

        @media only screen and (max-width: 600px) {
            table {
                font-size: 12px;
            }

            .submitBtn,
            #submitBtn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div>
    <br>
   

    <table>
         
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
                <td><center><img src="${fn:escapeXml(product.image)}" width="200px"></center></td>
                <td>${fn:escapeXml(product.description)}</td>
                <td>${fn:escapeXml(product.quantity)}</td>
                <td>${fn:escapeXml(product.price)}</td>
                <td><center>
                    <a href="/admin/products/product.jsp?id=${product.productId}">
                        <button class="submitBtn">Edit Product</button>
                    </a>
                    <form id="deleteProduct${product.productId}Form" method="post" action="/api/admin/products/delete"><br>
                        <input type="hidden" name="productId" value="${product.productId}">
                    </form>
                    <button id="submitBtn"
                            onclick="if(confirm('Are you sure?')){document.getElementById('deleteProduct${product.productId}Form').submit()}">Delete Product
                    </button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
        
    </table>
    <div class="button">
        <div class="d-grid gap-2">
            <form method="post" action="/admin/products/add.jsp">
                <input type="submit" class="btn btn-primary" style="background-color:#00B207; " value="Add New Product">
            </form>
        </div>
    </div>
</div>

<br><br><br><br><br><br><br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
