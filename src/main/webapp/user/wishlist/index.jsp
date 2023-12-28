<%@ page import="com.isiraadithya.greensupermarket.models.WishList" %>
<%@ page import="com.isiraadithya.greensupermarket.models.WishlistDetail" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya, @thiyara
  Date: 12/19/2023
  Time: 3:00 AM
--%>
<%@include file="/includes/variables.jsp"%>
<%
    int userId = (int) session.getAttribute("userId");
    WishList wishList = WishList.findWishListByUserId(userId);
    if (wishList.getUserId() == -1){
        wishList = new WishList(userId);
        wishList.saveWishlist();
    }
    List<WishlistDetail> wishlistDetailList = wishList.getWishlistDetails();
    pageContext.setAttribute("wishlistDetailList", wishlistDetailList);
%>
<html>
<head>
    <title>WishList - GreenSuperMarket</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  
  <style>
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
        table {
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid black;
            padding: 15px ;
            text-align: left;
        }
        button.addToCart {
            background-color: #00B207;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 2px 2px;
            cursor: pointer;
        }

       .not-found-img {
           width: 500px;
       }
    </style>

</head>
<body>
    <%@include file="/includes/header.jsp"%>
    <div>
    <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
    
    <c:if test="${wishlistDetailList.size() <= 0}">
        <div class="align-items-center text-center justify-content-center my-5">
            <img src="/uploads/images/common/not-found.jpeg" class="not-found-img">
            <h3>Your wishlist is empty</h3>
            <a href="/products">Visit Our Products</a>
        </div>
    </c:if>
    <c:if test="${wishlistDetailList.size() > 0}">
    <img src = "/uploads/images/products/Breadcrumbs.png" class="image">
    <center><br>
        <h3>Wish List</h3>
        <table border="1" width ="70%" >
            <thead>
            <tr>
                <th>Product Name</th>
                <th>Price</th>
                <th>Operations</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${wishlistDetailList}" var="wishListItem">
                <c:if test="${wishListItem.product.visibility == true}">
                    <tr>
                        <td>${wishListItem.product.name}</td>
                        <td>$10.99</td>
                        <td>
                            <a href="/products/product.jsp?id=${wishListItem.product.productId}" class="btn btn-primary btn-sm">View</a>
                            <button onclick="document.getElementById('removeProduct${wishListItem.product.productId}Form').submit()" type="submit" class="btn btn-danger btn-sm">Remove</button>
                            <form id="removeProduct${wishListItem.product.productId}Form" action="/api/user/wishlist/deleteProduct" method="post">
                                <input type="hidden" name="productId" value="${wishListItem.product.productId}">
                            </form>
                        </td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </c:if>


    
              
       <script>
        function addToCart(product) {
            // You can add your cart functionality here
            alert(product + " added to cart!");
        }
    </script>
      
   
                </center>
<div style="margin-top:25px;"></div>
<%@include file="/includes/footer.jsp"%>
</body>
</html>
