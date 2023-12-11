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
    <title>Your Orders</title>
</head>
<body>
<%@include file="../../includes/header.jsp"%>

<div>
    <c:if test="${orderList.size() > 0}">
        <center>
            <table border="1px">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date/Time</th>
                    <th>Total</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orderList}" var="order">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.dateTime.toString()}</td>
                        <td>${order.amount}</td>
                        <td><a href="/user/orders/order.jsp?id=${order.orderId}">View Order</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </center>
    </c:if>
    <c:if test="${orderList.size() <= 0}">
        <u>You have no orders.</u>
    </c:if>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>
</html>
