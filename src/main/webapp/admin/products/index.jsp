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

        .submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
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
        .icon{
            width:30px;
            height:30px;
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
          .image{
            margin-bottom: 5px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
         .buttons{
            max-width: 300px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
           
            
            
            
        }
        .custom-button{
            width:50px;
            border-radius: 100px;
             text-align: left;
        }
        
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
<div class="container">

    
<div class="table-responsive">
      <table class="table table-bordered">
         
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Product Image</th>
            <th>Product Description</th>
            <th>Product Quantity</th>
            <th>Product Price</th>
            <th>Action</th>
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
        </table><br><br><br><br>
        <form method="post" action="/admin/products/add.jsp">
            <center><button class="Add-new-button">Add New Product</button></center>
        </form>
    </div>
    
    
    
    
</div>


<br><br><br><br><br><br><br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>

