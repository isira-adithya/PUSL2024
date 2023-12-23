<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 6:34 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Cart" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="java.sql.Timestamp" %>
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
    Timestamp expireDateTime;
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
    expireDateTime = new Timestamp(order.getDateTime().getTime() + (1000 * 60 * 60 * 24));
    pageContext.setAttribute("order", order);
    pageContext.setAttribute("expireDateTime", expireDateTime);
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
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease; 
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
            margin-bottom: 50px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
            
            .custom-button{
            width:150px;
            border-radius: 100px;
            
            .buttons{
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
    </style>
</head>

<body>
<%@include file="../../includes/header.jsp"%>

 <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
  <div class="cart-container">
    <center><h2>Order ID ${order.orderId}</h2></center>
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
        <tr>
            <td></td>
            <td></td>
            <c:if test="${order.orderStatus.equals('COMPLETED')}">
                <td><b>Sub Total:</b></td>
            </c:if>
            <c:if test="${order.orderStatus.equals('PENDING') || order.orderStatus.equals('EXPIRED')}">
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
            <i style="color: #00B207">PENDING</i><br><br>
            <b>
                <small>
                    Note: You have to make the payment for this order before ${expireDateTime.toLocaleString()}. Otherwise, this order will be cancelled and you will have to order again with the updated prices.
                    <br><br>
                    We would like to inform you that when making a payment through PayPal for your order, please be aware that additional charges for taxes and shipping costs may apply.
                </small>
            </b>
        </c:if>
        <c:if test="${order.orderStatus.equals('COMPLETED')}"><i style="color: green;">COMPLETED</i></c:if>
        <c:if test="${order.orderStatus.equals('EXPIRED')}">
            <i style="color: red;">EXPIRED</i>
            <br>
            <b>
                <small>
                    Unfortunately, your order has been expired. Please reorder the items again by visiting <a href="/products/">here</a> .
                </small>
            </b>
        </c:if>
    </p>
    <br>

    <c:if test="${order.orderStatus.equals('PENDING')}">
        
        <div class="buttons">
        <div class="row text-center">
                <div class="col-sm-5 col-md-6">
                    <input type="submit" class="btn btn-primary custom-button"  onclick="location.href ='/api/user/payments/authorize_payment?orderid=${order.orderId}'" style="background-color:#00B207" value="Pay">
                </div>
                <div class="col-sm-6 col-md-5 col-lg-">
                    <input type="button" class="btn btn-primary custom-button" onclick="location.href ='/user/orders/'" style="background-color:#00B207" value="Go Back">
                </div>
            </div>
        <br><br>
    </c:if>
        </div>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

