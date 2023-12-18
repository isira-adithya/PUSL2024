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

        @media (max-width: 768px) {
            .main-container {
                flex-direction: column;
                align-items: center;
            }

            .cart-container {
                margin: 10px;
                height: auto; /* Set auto height for smaller screens */
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
        
        

        
    </style>
</head>

<body>
    <%@include file="../includes/header.jsp"%>
    
    <br><br>
    
    
    <center><h1 style="font-size:50px">My Shopping Cart</h1></center>
    <c:if test="${isCartEmpty}">
        <p>Your cart is empty</p>
        <a href="/products">Visit Our Products</a>
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
                            <td style="vertical-align: middle;">${_value.key.name}</td>
                            <td style="vertical-align: middle;">${_value.value}</td>
                            <td style="vertical-align: middle;">$${_value.key.price} Each</td>
                            <td style="vertical-align: middle;">$${_value.key.price * _value.value}</td>
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
                        <p>Shipping:</p>
                        
                    </td>
                    
                    <td class="pricing">
                        
                        <p style="color: #000000;">$${userCart.totalCost}</p>
                        <p style="color: #000000;">Free</p>                        
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

