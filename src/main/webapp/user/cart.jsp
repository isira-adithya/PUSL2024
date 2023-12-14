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
    <title>GreenSuperMarket - Shopping Cart</title>
    <style>
        .cart-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>

<body>
<%@include file="../includes/header.jsp"%>

<div class="cart-container">
    <h2>Your Shopping Cart</h2>
    <c:if test="${isCartEmpty}">
        <p>Your cart is empty</p>
        <a href="/products">Visit Our Products</a>
    </c:if>
    <c:if test="${!isCartEmpty}">
        <table>
            <thead>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Sub Total</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${userCart.productQuantities}" var="_value">
                <tr>
                    <td>${_value.key.name}</td>
                    <td>${_value.value}</td>
                    <td>$${_value.key.price} Each</td>
                    <td>$${_value.key.price * _value.value}</td>
                    <td>
                        <form action="/api/user/cart/deleteItem" method="post">
                            <label>Quantity:</label>
                            <input type="hidden" name="productId" value="${_value.key.productId}">
                            <input type="submit" value="Remove">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <p>
            Total: $${userCart.totalCost}
        </p>
        <form method="post" action="/api/user/orders/new">
            <input type="submit" value="Place Order">
        </form>
    </c:if>
</div>

<%@include file="../includes/footer.jsp"%>
</body>

</html>

