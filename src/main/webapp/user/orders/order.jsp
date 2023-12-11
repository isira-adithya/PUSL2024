<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 6:34 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Cart" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int orderId = -1;
    int userId = (int) session.getAttribute("userId");
    if (request.getParameterMap().containsKey("id")){
        try {
            orderId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException ex){
            orderId = -1;
        }
    }

    Order order = Order.findOrderById(orderId);
    // Checking if the order exists
    if (order.getAmount() <= 0){
        response.sendRedirect("/user/orders");
        return;
    }
    // Checking if the user owns this Order
    if (order.getUserId() != userId){
        response.sendRedirect("/user/orders");
        return;
    }
    pageContext.setAttribute("order", order);
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
<%@include file="../../includes/header.jsp"%>

<div class="cart-container">
    <h2>Order ID ${order.orderId}</h2>
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Sub Total</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${order.orderDetails}" var="_value">
            <tr>
                <td>${_value.product.name}</td>
                <td>$${(_value.subTotal / _value.quantity)} Each</td>
                <td>${_value.quantity}</td>
                <td>$${_value.subTotal}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <p>
        Date/Time: <i>${order.dateTime.toLocaleString()}</i><br><br>
        Total: <i>$${order.amount}</i>
    </p>
    <br>
    <a href="/user/orders/">Go back</a>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

