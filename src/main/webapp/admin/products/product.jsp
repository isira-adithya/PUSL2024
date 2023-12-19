<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@include file="../includes/variables.jsp"%>
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
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div style="margin-left: 25px;">
    <form method="post" action="/api/admin/products/update" enctype="multipart/form-data">
        <img width="500px" src="${fn:escapeXml(product.image)}">
        <p><b>Product Name: </b><input type="text" value="${fn:escapeXml(product.name)}" name="productName"></p>
        <p>
            <b>Product Description: </b>
            <br>
            <textarea name="productDescription">${fn:escapeXml(product.description)}</textarea>
        </p>
        <p><b>Product Price: </b><input type="text" value="${fn:escapeXml(product.price)}" name="productPrice"></p>
        <p><b>Product Quantity: </b><input type="number" inputmode="numeric" value="${fn:escapeXml(product.quantity)}" name="productQuantity"></p>

        <br>
        <p>Select a image from your computer, if you need to replace the current image</p>
        <input type="file" name="imageFile">
        <input type="hidden" name="productId" value="${product.productId}">
        <br><br>
        <input type="submit" value="Update">
    </form>
</div>
<br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
