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
        wishList = WishList.findWishListByUserId(userId);
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
        th {
            text-align: center;
        }

        td {
            text-align: center;
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
            <img src="/uploads/images/common/wishlist-image.png" class="not-found-img mb-3">
            <h3>Your wishlist is empty</h3>
            <a href="/products">Visit Our Products</a>
        </div>
    </c:if>
    <c:if test="${wishlistDetailList.size() > 0}">
        <div class="mx-5">
            <h3 class="text-center mb-4">Your Wishlist</h3>
            <div class="container">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col" style="text-align: center;">Product</th>
                        <th scope="col" style="text-align: center;">Description</th>
                        <th scope="col" style="text-align: center;">Price</th>
                        <th scope="col" style="text-align: right;">Operations</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${wishlistDetailList}" var="wishListItem">
                        <c:if test="${wishListItem.product.visibility == true}">
                            <tr>
                                <td>
                                    <img src="${wishListItem.product.image}" width="75px">
                                    <p>${wishListItem.product.name}</p>
                                </td>
                                <td>${fn:escapeXml(wishListItem.product.shortDescription)}</td>
                                <td>$${wishListItem.product.price}</td>
                                <td style="text-align: right;">
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
            </div>
        </div>
    </c:if>


    
              
       <script>
        function addToCart(product) {
            // You can add your cart functionality here
            alert(product + " added to cart!");
        }
    </script>
      
   

<div style="margin-top:25px;"></div>
<%@include file="/includes/footer.jsp"%>
</body>
</html>
