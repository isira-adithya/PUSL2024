<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@include file="../includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <title>Add new product- Green SuperMarket</title>
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
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div style="margin-left: 25px;">
    <form method="post" action="/api/admin/products/update" enctype="multipart/form-data">
        <p><b>Product Name: </b><input type="text" value="" name="productName"></p>
        <p>
            <b>Product Description: </b>
            <br>
            <textarea name="productDescription"></textarea>
        </p>
        <p><b>Product Price: </b><input type="text" value="" name="productPrice"></p>
        <p><b>Product Quantity: </b><input type="number" inputmode="numeric" value="" name="productQuantity"></p>
        <br>
        <p>Select a product image</p>
        <input type="file" name="imageFile">
        <br><br>
        <input type="submit" value="Update">
    </form>
</div>
<br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
