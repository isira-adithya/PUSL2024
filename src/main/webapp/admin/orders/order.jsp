<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 6:34 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int orderId = -1;
    if (request.getParameterMap().containsKey("id")){
        try {
            orderId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException ex){
            orderId = -1;
        }
    }

    Order order = Order.findOrderById(orderId);
    Timestamp expireDateTime;
    // Checking if the order exists
    if (order.getAmount() <= 0){
        response.sendRedirect("/user/orders");
        return;
    }

    expireDateTime = new Timestamp(order.getDateTime().getTime() + (1000 * 60 * 60 * 24));
    pageContext.setAttribute("order", order);
    pageContext.setAttribute("expireDateTime", expireDateTime);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order ID ${order.orderId} - GreenSuperMarket</title>
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
<%@include file="../includes/header.jsp"%>
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
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
                <td>
                    <c:if test="${_value.productAvailable}">
                        <a href="/products/product.jsp?id=${_value.product.productId}">${_value.productName}</a>
                    </c:if>
                    <c:if test="${!_value.productAvailable}">
                        ${_value.productName}
                        <br>
                        <i><small>Currently, this product is expired or removed from the store.</small></i>
                    </c:if>
                </td>
                <td>$${(_value.subTotal / _value.quantity)} Each</td>
                <td>${_value.quantity}</td>
                <td>$${_value.subTotal}</td>
            </tr>
        </c:forEach>
        <tr>
            <td></td>
            <td></td>
            <c:if test="${order.orderStatus.equals('COMPLETED')}">
                <td><b>Sub Total:</b></td>
            </c:if>
            <c:if test="${order.orderStatus.equals('PENDING') || order.orderStatus.equals('CANCELLED')}">
                <td><b>Total:</b></td>
            </c:if>
            <td><b>$${order.amount}</b></td>
        </tr>
        <c:if test="${order.orderStatus.equals('COMPLETED')}">
            <tr>
                <td></td>
                <td></td>
                <td><b>Additional Charges<i>(Shipping costs, Tax, etc)</i>:</b></td>
                <td><b>$${order.additionalCharges}</b></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><b>Total</i>:</b></td>
                <td><b>$${order.amount + order.additionalCharges}</b></td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <p>
        Date/Time: <i>${order.dateTime.toString()}</i><br><br>
        Order Status:
        <c:if test="${order.orderStatus.equals('PENDING')}">
            <i style="color: blue">PENDING</i><br><br>
            <b>
                <small>
                    Note: You have to make the payment for this order before ${expireDateTime.toLocaleString()}. Otherwise, this order will be cancelled and you will have to order again with the updated prices.
                    <br><br>
                    We would like to inform you that when making a payment through PayPal for your order, please be aware that additional charges for taxes and shipping costs may apply.
                </small>
            </b>
        </c:if>
        <c:if test="${order.orderStatus.equals('COMPLETED')}"><i style="color: green;">COMPLETED</i></c:if>
        <c:if test="${order.orderStatus.equals('CANCELLED')}">
            <i style="color: red;">CANCELLED</i>
        </c:if>
    </p>
    <br>

    <a href="/admin/orders/">Go back</a>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

