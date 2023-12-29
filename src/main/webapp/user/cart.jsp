<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 6:34 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int userId = (int) session.getAttribute("userId");
    Cart userCart = (Cart) session.getAttribute("cart");
    if (userCart == null){
        userCart = new Cart(userId);
        session.setAttribute("cart", userCart);
    }
    boolean isCartEmpty = userCart.isEmpty();
    pageContext.setAttribute("userCart", userCart);
    pageContext.setAttribute("isCartEmpty", isCartEmpty);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #ffffff;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .main-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            max-width: 1300px;
            margin: 50px auto;
        }

        .cart-container {
            width: 100%; /* Make the cart container full width */
            max-width: 900px; /* Set a max width for the cart container */
            height:auto; /* Set a fixed height for the cart container */
            overflow-y: auto; /* Add vertical scrolling */
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
        }

        .additional-container {
            width: 320px;
            height: 350px; /* Set the desired height */
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 20px;
            
            justify-content: space-between;
            align-items: flex-start;
        }
        .containerprices{
            display: flex;

        }

        p {
            color: #666666;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #dee2e6;
            border-radius: 10px;
        }

        th,
        td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }

        th {
            background-color: #ffffff;
            border-bottom: 2px solid #dee2e6;
            color: #808080;
        }

        .total {
            margin-top: 20px;
            text-align: right;
        }

        form {
            margin: 10px 0;
        }

        .Removebutton {
            height: 35px;
            width: 40px;
            border-radius: 100px;
            border: none;
            outline: none;
            cursor: pointer;
            margin-top: -10px;
            background-color: #ffffff;
        }

        .icon {
            width: 32px;
            height: 32px;
        }

        .not-found-img {
            width: 500px;
        }

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                align-items: center;
            }

            .cart-container {
                margin: 10px;
                height: auto; /* Set auto height for smaller screens */
            }

            .not-found-img {
                width: 300px;
            }
        }

        .product-img {
            height: 70px;
            width: 70px;
        }
        
        .pricing {
            
            text-align: right;
            
        }
        .cart-total{
            
            border: none;
        }
        .btn {
             height: 35px;
             width: 100%;
             border-radius: 100px;
             color: #ffffff;
             background-color: #00b207;
             
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
    <br><br>
    <div class="col-md-3">
            <div
                    style="width: 220px; height: 306px; padding-bottom: 12px; background: white; border-radius: 8px; border: 1px #E6E6E6 solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                <div
                        style="padding-top: 24px; padding-bottom: 16px; padding-left: 20px; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                    <div
                            style="color: #1A1A1A; font-size: 20px; font-family: Poppins; font-weight: 500; line-height: 30px; word-wrap: break-word">
                        <b>Navigation</b></div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; background: white; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                    <div
                            style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">

                        <img src="/uploads/images/profile/Edit.png" style="width:20px; height:20px;">

                    </div>
                    <div
                            style="width: 238px; color:#666666 ; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;"  onclick="location.href = '/user/profile.jsp'" >
                        Edit Profile</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer; box-shadow: 3px 0px 0px #20B526 inset;">
                    <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex;">

                        <img src="/uploads/images/profile/orderhistorydark.png" style="width:20px; height:20px;">

                    </div>
                    <div
                            style="width: 238px; color: #1A1A1A; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:4px;" onclick="location.href = '/user/orders/index.jsp'" >
                        Order History</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                    <div style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">

                        <img src="/uploads/images/profile/shoppingcart.jpg" style="width:20px; height:20px;">

                    </div>
                    <div a href="/cart.jsp"
                         style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;" onclick="location.href = '/user/cart.jsp'">
                        Shopping Cart</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer; box-shadow: 3px 0px 0px #20B526 inset;">
                    <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex;">

                        <img src="/uploads/images/profile/shoppingcart.jpg" style="width:20px; height:20px;">

                    </div>
                    <div
                            style="width: 238px; color: #1A1A1A; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:4px;" onclick="location.href = '/user/orders/index.jsp'" >
                        Shopping Cart</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">

                    <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex">
                        <img src="/uploads/images/profile/logout.jpg" style="width:20px; height:20px;">

                    </div>

                    <div
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;" onclick="location.href = '/logout.jsp'">
                        Log-out</div>
                </div>
            </div>

    </div>
    
    <center><h1 style="font-size:50px">My Shopping Cart</h1></center>
    <c:if test="${isCartEmpty}">
        <div class="align-items-center text-center justify-content-center my-5">
            <img src="/uploads/images/common/not-found.jpeg" class="not-found-img">
            <h3>Your cart is empty</h3>
            <a href="/products">Visit Our Products</a>
        </div>
    </c:if>
    <c:if test="${!isCartEmpty}">
    <div class="main-container">
        <div class="cart-container">
            <table class="table">
                <thead>
                    <tr>
                        <th colspan="2" style="text-align: center;">Product</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Sub Total</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Iterate over productQuantities using JSTL forEach -->
                    <c:forEach items="${userCart.productQuantities}" var="_value">
                        <tr>
                            <td style="vertical-align: middle; text-align:center;"><img src="${_value.key.image}"
                                    alt="product img" class="product-img"></td>
                            <td style="vertical-align: middle;"><a href="/products/product.jsp?id=${_value.key.productId}">${fn:escapeXml(_value.key.name)}</a></td>
                            <td style="vertical-align: middle;">${fn:escapeXml(_value.value)}</td>
                            <td style="vertical-align: middle;">$${fn:escapeXml(_value.key.price)} Each</td>
                            <td style="vertical-align: middle;">$${fn:escapeXml(_value.key.price * _value.value)}</td>
                            <td style="vertical-align: middle;">
                                <form action="/api/user/cart/deleteItem" method="post">
                                    <input type="hidden" name="productId" value="${_value.key.productId}">
                                    <button type="submit" class="Removebutton">
                                        <img src="/uploads/images/shopping-cart/removeicon.png" alt="remove icon" class="icon">
                                    </button>
                                </form>
                            </td>
                        </tr>
                        
                        
                    </c:forEach>
                </tbody>
            </table>        
            
        </div>

        <div class="additional-container">
            <h4>Cart Total</h4><br>
            <table class="cart-total">
                <tr>
                    <td colspan="2">
                        <p>Subtotal:</p>
                        <p><small>Shipping and additional costs:</small></p>
                    </td>
                    
                    <td class="pricing">
                        <p style="color: #000000;">$${userCart.totalCost}</p>
                        <p style="color: #000000;"><small><i>will be applied during PayPal checkout.</i></small></p>
                    </td>
                    
                </tr>
            </table>

            <!-- total price table -->
            <table class="cart-total" style="margin-bottom: -35px;">
                <tr>
                    <td colspan="2" style="border-bottom: none;"> 

                        <p style="font-size: 22px">Total</p><br>                       
                    </td>
                    
                    <td class="pricing" style="border-bottom: none;">                                              
                        <p style="color: #000000; font-size: 22px;"> $${userCart.totalCost}</p><br>                        
                    </td>
                    
                </tr>
            </table>
            <form method="post" action="/api/user/orders/new">
                <input type="submit" class="btn btn-success" value="Place Order">
            </form>
            
            
            
        </div>
    </c:if>
    </div>

    <%@include file="../includes/footer.jsp"%>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>

