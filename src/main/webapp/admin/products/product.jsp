<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = -1;
    Product product;

    // Only allowing numbers
    if (request.getParameterMap().containsKey("id")){
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException ex){
            id = -1;
        }
    }

    // Validating the product id
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

    // Loading data to pageContext
    pageContext.setAttribute("product", product);
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <title>${fn:escapeXml(product.name)} - Green SuperMarket</title>
    <style>
        #comments {
            max-width: 600px;
            margin: 20px;
        }

        .comment {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .commenter {
            font-weight: bold;
        }

        #commentInput {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            box-sizing: border-box;
        }

        #submitBtn {
            padding: 8px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        #submitBtn:hover {
            background-color: #45a049;
        }
    </style>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <title>Update Product - Green SuperMarket</title>
    <style>
        #updateProductForm {
            max-width: 600px;
            margin: 20px auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
        }

        #updateProductForm:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

        #submitBtn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            text-decoration: none;
            color: #ffffff;
            background-color: #4caf50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
            width: 100px;
        }

        #submitBtn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%@include file="../includes/header.jsp"%><br>
    
    <div class="container">
        <center><h1>Edit Product</h1></center><br>
        <form id="updateProductForm" method="post" action="/api/admin/products/update" enctype="multipart/form-data">
            <center><img width="400px" src="${fn:escapeXml(product.image)}"></center>
            <div class="mb-3">
                <label for="productName" class="form-label"><b>Name:</b></label>
                <input type="text" class="form-control" id="productName" name="productName" value="${fn:escapeXml(product.name)}">
            </div>
            <div class="mb-3">
                <label for="productDescription" class="form-label"><b>Description:</b></label>
                <textarea class="form-control" id="productDescription" name="productDescription">${fn:escapeXml(product.description)}</textarea>
            </div>
            <div class="mb-3">
                <label for="productPrice" class="form-label"><b>Price:</b></label>
                <input type="text" class="form-control" id="productPrice" name="productPrice" value="${fn:escapeXml(product.price)}">
            </div>
            <div class="mb-3">
                <label for="productQuantity" class="form-label"><b>Quantity:</b></label>
                <input type="number" class="form-control" inputmode="numeric" id="productQuantity" name="productQuantity" value="${fn:escapeXml(product.quantity)}">
            </div>
            <div class="mb-3">
                <label for="imageFile" class="form-label"><b>Select a new image:</b></label>
                <input type="file" class="form-control" id="imageFile" name="imageFile">
            </div>
            <input type="hidden" name="productId" value="${product.productId}">
            <center><button type="submit" id="submitBtn">Update</button></center>
        </form>
    </div>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>

