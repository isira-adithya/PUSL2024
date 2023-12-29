<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <title>Add New Product - Green SuperMarket</title>
    <style>
        #addProductForm {
            max-width: 600px;
            margin:  auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
        }

        #addProductForm:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.6s ease;
        }

        #submitBtn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            text-decoration: none;
            color: #ffffff;
            background-color: #00b207;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }

        #submitBtn:hover {
            background-color: #45a049;
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
    }
}
        
        
    </style>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
    
<center><h2>Add New Product</h2></center><br>
    <div class="container">
        <form id="addProductForm" method="post" action="/api/admin/products/add" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="productName" class="form-label"><b>Product Name:</b></label>
                <input type="text" class="form-control" id="productName" name="productName">
            </div>
            <div class="mb-3">
                <label for="productDescription" class="form-label"><b>Product Short Description:</b></label>
                <textarea class="form-control" id="productShortDescription" name="productShortDescription"></textarea>
            </div>
            <div class="mb-3">
                <label for="productDescription" class="form-label"><b>Product Description:</b></label>
                <textarea class="form-control" id="productDescription" name="productDescription"></textarea>
            </div>
            <div class="mb-3">
                <label for="productPrice" class="form-label"><b>Product Price:</b></label>
                <input type="text" class="form-control" id="productPrice" name="productPrice">
            </div>
            <div class="mb-3">
                <label for="productQuantity" class="form-label"><b>Product Quantity:</b></label>
                <input type="number" class="form-control" inputmode="numeric" id="productQuantity" name="productQuantity">
            </div>
            <div class="mb-3">
                <label for="imageFile" class="form-label"><b>Select a product image:</b></label>
                <input type="file" class="form-control" id="imageFile" name="imageFile">
            </div>
            <button type="submit" id="submitBtn">Submit</button>
        </form>
    </div><br><br><br>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>

