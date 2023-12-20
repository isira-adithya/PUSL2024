<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/11/2023
  Time: 10:44 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Cart" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int userId = (int) session.getAttribute("userId");
    List<Order> orderList = Order.findOrdersByUserId(userId);
    pageContext.setAttribute("orderList", orderList);
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
   <link href="/includes/styles.css" rel="stylesheet">
    <title>Your Orders</title>
    <style>
         .account-info {
            max-width: 950px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .account-info:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

    </style>
</head>
<body>
<%@include file="../../includes/header.jsp"%>



<div class="container">
  <div class="row">
    <div class="col-md-3">
        
    </div>
  </div>
    <div class="account-info">
    <c:if test="${orderList.size() > 0}">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead style="background-color: #F2F2F2;">
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date/Time</th>
                        <th>Total</th>
                        <th>Payment Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderList}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.dateTime}</td>
                            <td>${order.amount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.orderStatus.equals('EXPIRED')}">
                                        <p style="color:red;">EXPIRED</p>
                                    </c:when>
                                    <c:when test="${order.orderStatus.equals('PENDING')}">
                                        <p style="color:blue;">PENDING</p>
                                    </c:when>
                                    <c:when test="${order.orderStatus.equals('COMPLETED')}">
                                        <p style="color:green;">COMPLETED</p>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td><a href="/user/orders/order.jsp?id=${order.orderId}" class="custom-btn" style=" margin: 0;">View Order</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
    <c:if test="${orderList.size() <= 0}">
        <div class="alert alert-info">You have no orders.</div>
    </c:if>
         </div>
</div>
<%@include file="../../includes/footer.jsp"%>
</body>
</html>
