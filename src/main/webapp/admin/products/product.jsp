<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Analytics" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Comment" %>
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

    // Loading Analytics
    double averageRating = Analytics.getAverageRatingOfAProduct(product.getProductId());
    int reviewCount = Comment.getCommentCountByProductId(product.getProductId());

    // Loading data to pageContext
    pageContext.setAttribute("product", product);
    pageContext.setAttribute("userId", session.getAttribute("userId"));
    pageContext.setAttribute("averageRating", averageRating);
    pageContext.setAttribute("reviewCount", reviewCount);
%>
<html>
<head>
    <style>

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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <title>Manage Product - Green SuperMarket</title>
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

        #analyticsContainer {
            max-width: 600px;
            margin: 20px auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
        }

        #analyticsContainer:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

        .content{
            width: 420px;
        }

        .ratings{
            background-color:#fff;
            padding: 54px;
        }

        .product-rating{
            font-size: 50px;
        }

        .stars i{

            font-size: 18px;
            color: #28a745;
        }

        .rating-text{
            margin-top: 10px;
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
        .visibility-message-container {
        max-width: 600px; /* Adjust the width as needed */
        margin: 20px auto;
        padding: 15px;
        border: 1.5px solid #000000;
        border-radius: 5px;
        background-color: transparent; /* Set background color to transparent */
    }

    .visibility-message-container:hover {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        transition: box-shadow 0.5s ease;
    }
    .image{
            margin-bottom: 5px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
    
    </style>
</head>
<body>
    <%@include file="../includes/header.jsp"%><br>
        <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
        </div>
    <div class="container">
        <center><h3>Manage Product - ${fn:escapeXml(product.name)}</h3></center><br>
        <div id="analyticsContainer">
            <div class="d-flex justify-content-center">
                <div class="content text-center">
                    <h4>Customer Feedback</h4>
                    <div class="ratings">
                        <span class="product-rating">${averageRating}</span><span>/5</span>
                        <div class="stars">
                            <c:if test="${Math.round(averageRating) > 0}">
                                <c:forEach var="i" begin="1" end="${Math.round(averageRating)}">
                                    <i class="fa fa-star"></i>
                                </c:forEach>
                            </c:if>
                            <c:if test="${Math.round(averageRating) <= 0}">
                                <small>No Ratings Found</small>
                            </c:if>
                        </div>
                        <div class="rating-text">
                            <span>${reviewCount} reviews</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <form id="updateProductForm" method="post" action="/api/admin/products/update" enctype="multipart/form-data">
            <center><img width="400px" src="${fn:escapeXml(product.image)}"></center>
            <div class="mb-3">
                <label for="productName" class="form-label"><b>Name:</b></label>
                <input type="text" class="form-control" id="productName" name="productName" value="${fn:escapeXml(product.name)}">
            </div>
            <div class="mb-3">
                <label for="productDescription" class="form-label"><b>Product Short Description:</b></label>
                <textarea class="form-control" id="productShortDescription" name="productShortDescription">${fn:escapeXml(product.shortDescription)}</textarea>
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
        <div class="alert <%if (product.getVisibility()) {out.print("alert-info");} else {out.print("alert-warning");}%> text-center visibility-message-container" role="alert">
            
        <form method="post" action="/api/admin/products/change-visibility">
            <input type="hidden" name="productId" value="${product.productId}">
             <div>
             <c:if test="${product.visibility}">
                <p>Do you want to <i><b>hide</b></i> this product from your customers?</p>
                <input type="submit" class="btn btn-danger btn-sm" value="Hide">
             </c:if>
            <c:if test="${!product.visibility}">
             <p>Do you want to <i><b>show</b></i> this product to your customers?</p>
             <input type="submit" class="btn btn-primary btn-sm" value="Show">
        </c:if>
    </div>
</form>
<!-- ... your existing code ... -->

        </div>

    </div>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>

