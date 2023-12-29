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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
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
            text-align: justify-all;
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

        .Add-new-button{
            padding: 10px 15px;
            font-size: 23px;
            background-color: #00B207; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 30px;
            cursor: pointer;
            width: 40%;
        }

        @media only screen and (max-width: 600px) {
            table {
                font-size: 12px;
            }
        }
    .image {
      margin-bottom: 60px;
      width: 100%;
      height: 130px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
      background-image: url("/uploads/images/products/Breadcrumbs.png");
      background-size: cover;
      background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }}
        
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
<div class="container">

    
<div class="table-responsive">
    <br>
      <table class="table table-bordered">
         
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Product Image</th>
            <th>Product Description</th>
            <th>Product Quantity</th>
            <th>Product Price</th>
            <th colspan="2">Actions</th>
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
                        <a class="btn btn-primary my-2 py-2" href="/admin/products/product.jsp?id=${product.productId}">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </a>
                    </td>
                    <td>
                        <button class="btn btn-danger my-2 py-2" onclick="if(confirm('Are you sure?')){document.getElementById('deleteProduct${product.productId}Form').submit()}">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                        <form id="deleteProduct${product.productId}Form" method="post" action="/api/admin/products/delete"><br>
                            <input type="hidden" name="productId" value="${product.productId}">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
        </table><br><br><br><br>
        
    </div>
    <form method="post" action="/admin/products/add.jsp">
            <center><button class="Add-new-button">Add New Product</button></center>
        </form>
    
    
    
</div>


<br><br><br><br><br><br><br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>

