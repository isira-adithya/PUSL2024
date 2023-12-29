<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,@sanuth
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="java.util.List" %>
<%@ page import="com.isiraadithya.greensupermarket.models.*" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = -1;
    int userId = -1;
    Product product;
    int availableQuantity = 0;
    boolean foundProductInCart = false;
    boolean productExistsInWishlist = false;

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

    // Calculating the available product quantity based on their cart if they have one.
    availableQuantity = product.getQuantity();
    if (isLoggedIn){
        userId = (int) session.getAttribute("userId");
        Cart userCart = (Cart) session.getAttribute("cart");
        if (userCart == null){
            userCart = new Cart(userId);
            session.setAttribute("cart", userCart);
        }

        int inCartCount = userCart.getProductQuantity(product.getProductId());
        if (inCartCount != -1){
            foundProductInCart = true;
            availableQuantity = availableQuantity - inCartCount;
        }

        // Checking if the product exists in user's wishlist
        WishList wishlist = WishList.findWishListByUserId(userId);
        productExistsInWishlist = wishlist.doesProductExist(product);
    }

    // Loading comments
    List<Comment> comments = Comment.findCommentsByProductId(id);

    // Loading data to pageContext
    pageContext.setAttribute("product", product);
    pageContext.setAttribute("comments", comments);
    pageContext.setAttribute("userId", session.getAttribute("userId"));
    pageContext.setAttribute("availableQuantity", availableQuantity);
    pageContext.setAttribute("foundProductInCart", foundProductInCart);
    pageContext.setAttribute("productExistsInWishlist", productExistsInWishlist);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
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
        h2 {
            margin-bottom: 20px;
        }
        
        .Deletebutton {
             height: 40px;
             width: 80px;
             border-radius: 100px;
             color: #ffffff;
             background-color: #DBDCDE;
             border: none; /* Remove the border */
             outline: none; /* Remove the outline */
             cursor: pointer;
             margin-top: 1px; /* Adjust as needed */
             margin-bottom: 30px;
             
        }   

        /* Add style for the new comment container */
        .comment-container {
            
            text-align: left;
            margin-top: 20px; /* Adjust as needed */
            margin-bottom: 20px; /* Adjust as needed */
            max-height: 500px; /* Adjust the maximum height as needed */
            overflow-y: auto;
        }

        .comment-heading {
            text-align: center;
            margin-bottom: 10px;
        }
        
        hr{
          border-color: #2C742F;
        }
        
        .icon {
            width: 20px; /* Set the width of the icon */
             height: 20px; /* Set the height of the icon */
             margin-left: 5px; /* Adjust the margin as needed */
        }
        
        #commentInput {
              width: 100%;
              padding: 10px;
              font-size: 16px;
              border: 1px solid #ccc;
              border-radius: 5px;
              margin-bottom: 10px;
              box-sizing: border-box;
              resize: vertical; /* Allow vertical resizing */
        }

        #submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 100px;
        }

        #submitBtn:hover {
            background-color: #45a049; /* Darker green on hover */

         } 
         .wishlist-button {
            display: inline-block;
        }

        .wishlist-button img {
            cursor: pointer;
        }

        .addToCart-button {
            height: 38px;
            width: 60%;
            border-radius: 100px;
            color: #ffffff;
            background-color: #00b207;
            margin-left: 20px;
            margin-right: 25px; /* Add margin-right to create space */
            border: none;
            display: inline-block;
        }
        .addToCart-button:hover {
            background-color: #45a049; /* Darker green on hover */

        }

        
    
    </style>

    <!-- For Rating Stars -->
    <style>
        div.stars {
            width: 180px;
        }

        input.star { display: none; }

        label.star {

            float: right;

            padding: 5px;

            font-size: 24px;

            color: #4CAF50;

            transition: all .2s;

        }

        label.star-small {
            float: right;

            padding: 3px;

            font-size: 15px;

            color: black;
        }

        label.star-small:before {

            content: '\f006';

            font-family: FontAwesome;

        }



        input.star:checked ~ label.star:before {

            content: '\f005';

            color: #4CAF50;

            transition: all .25s;

        }


        input.star-5:checked ~ label.star:before {

            color: #4CAF50;

            text-shadow: 0 0 20px #952;

        }



        input.star-1:checked ~ label.star:before { color: #F62; }



        label.star:hover { transform: rotate(-15deg) scale(1.3); }



        label.star:before {

            content: '\f006';

            font-family: FontAwesome;

        }
        /* For Rating Stars - Responsive Styles */
@media screen and (max-width: 600px) {
    div.stars {
        width: 80%; /* Adjust the width to fit the smaller screen */
    }

    label.star {
        font-size: 20px; /* Adjust the font size of the stars for smaller screens */
    }

    label.star-small {
        font-size: 12px; /* Adjust the font size of the stars for smaller screens */
    }
}



        
    </style>
    
</head>
<body>
<%@include file="../includes/header.jsp"%>
    
   
    <div >
        <img src="\uploads\images\products\Breadcrumbs.png" alt="Vege Image" class="image" >
    </div>
    
<div class="container mt-5">
  <div class="row">
    <!-- Image on the left -->   
   <div class="col-md-5">
      <img src="${fn:escapeXml(product.image)}" alt="Product Image" class="img-fluid">
    </div>
    
    <!-- Description and prices on the right -->
    <div class="col-md-7">
      <h2>${fn:escapeXml(product.name)}</h2>
      <h5 style="color:#00b207;">${fn:escapeXml(product.price)}</h5>
      
      <hr>
      <p>${fn:escapeXml(product.description)}</p>

      <hr>
        <c:if test="${availableQuantity <= 0}">
            <c:if test="${foundProductInCart == true}">
                <b><i>You have added the maximum available quantity to your cart.</i></b><br>
                <a href="/user/cart.jsp" class="btn btn-primary btn-sm my-2">Visit Cart</a>
            </c:if>
            <c:if test="${foundProductInCart == false}">
                <p>We are sorry. 😔 </p>
                <p>This product is currently unavailable in our inventory.</p>
                <p class="mt-5">Please visit us later to order this product.</p>

                <a href="/products/" class="btn btn-primary btn-sm my-2">Go Back</a>
            </c:if>
        </c:if>
        <c:if test="${availableQuantity > 0}">
            <small>Only ${availableQuantity} are available in Stock</small>
            <hr>
            <c:if test="${userId != null}">
                <form action="/api/user/cart/addItem" method="post">
                    <input type="number" name="quantity" inputmode="numeric" value="1" min="1" max="${availableQuantity}">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <button type="submit" class="addToCart-button" style="position: relative;">
                        Add to Cart                        
                    </button>

                    <!-- wishlist icon -->
                    <div class="wishlist-button">
                        <c:if test="${productExistsInWishlist == true}">
                            <img onclick="document.getElementById('addToWishlistForm').submit()" src="/uploads/images/navbar/removefromwishlist.png" width="33px">
                        </c:if>
                        <c:if test="${productExistsInWishlist == false}">
                            <img onclick="document.getElementById('addToWishlistForm').submit()" src="/uploads/images/navbar/addtowishlist.png" width="33px">
                        </c:if>
                    </div>
                </form>

                <c:if test="${productExistsInWishlist == true}">
                    <form id="addToWishlistForm" method="post" action="/api/user/wishlist/deleteProduct" style="display: inline-block;">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <input type="hidden" name="fromProductPage" value="true">
                    </form>
                </c:if>
                <c:if test="${productExistsInWishlist == false}">
                    <form id="addToWishlistForm" method="post" action="/api/user/wishlist/addProduct" style="display: inline-block;">
                        <input type="hidden" name="productId" value="${product.productId}">
                    </form>
                </c:if>

            </c:if>
        </c:if>
    </div>              
  </div>
      <br><br><br><br>
      
   <div class="row">
    <div class="col-md-12 comment-heading">
      <h2>Comments Section</h2> <br>
    </div>
  </div>   
      
    
      
  <div class="row">
    <c:if test="${comments.size() > 0}">
        <div id="comments" class="col-md-8 mx-auto comment-container">
            <c:forEach items="${comments}" var="comment">
                <div class="col-md-12">
                    <div>
                        <c:if test="${comment.starCount > 0}">
                            <c:forEach var="i" begin="1" end="${comment.starCount}">
                                <label class="star-small"></label>
                            </c:forEach>
                        </c:if>
                        <p><strong>${fn:escapeXml(comment.user.fullName)}<br><br></strong>${fn:escapeXml(comment.content)} .</p>
                        <hr>
                    </div>
                    <c:if test="${userId == comment.user.userId}">
                        <form action="/api/user/comments/delete" method="post">
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                           <button type="submit" class="Deletebutton">
                                <!-- delete icon -->
                                <img src="\uploads\images\navbar\delete.png" alt="delete icon" class="icon">
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${comments.size() <= 0}">
        <div id="comments" class="col-md-8 mx-auto comment-container">
            <p>No Comments Found.</p>
        </div>
    </c:if>
    <c:if test="${userId != null}">
        <div class="col-md-8 mx-auto">
            <form method="post" action="/api/user/comments/add">
                <input type="hidden" name="productId" value="${product.productId}"><br><br><br><br><h4>Give us your feedback</h4> <br>
                <textarea id="commentInput" placeholder="Add your comment..." name="comment"></textarea>

                <div class="row">
                    <div class="col-2">

                    </div>
                    <div class="row mt-2 text-right mt-2">
                        <h5>Give us a rating</h5>
                    </div>
                    <div class="col-6">
                        <div class="stars">
                            <input class="star star-5" id="star-5" type="radio" name="star" value="5"/>

                            <label class="star star-5" for="star-5"></label>

                            <input class="star star-4" id="star-4" type="radio" name="star" value="4"/>

                            <label class="star star-4" for="star-4"></label>

                            <input class="star star-3" id="star-3" type="radio" name="star" value="3"/>

                            <label class="star star-3" for="star-3"></label>

                            <input class="star star-2" id="star-2" type="radio" name="star" value="2"/>

                            <label class="star star-2" for="star-2"></label>

                            <input class="star star-1" id="star-1" type="radio" name="star" value="1"/>

                            <label class="star star-1" for="star-1"></label>
                        </div>
                    </div>

                </div>
                <div class="row">
                    <div class="col-4"></div>
                    <div class="col-4"></div>
                    <div class="col-4 text-right"><input id="submitBtn" type="submit" class="mb-4" value="Submit"></div>
                </div>
            </form>
        </div>
    </c:if>
  </div>
</div>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
