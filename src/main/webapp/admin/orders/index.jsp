<%@ page import="java.util.List" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../includes/variables.jsp"%>
<%
    List<Order> orders = Order.getOrders();
    pageContext.setAttribute("orders", orders);
%>
<html>
<head>
    <title>Manage Orders</title>
    <style>

    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>

    <div>
        <table>
            <thead>
            <tr>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Placed at</th>
                <th>Total</th>
                <th>Order Status</th>
                <th>Operations</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orders}" var="order">
                <tr>
                    <%
                        Order order = (Order) pageContext.getAttribute("order");
                        User user = User.findUserById(order.getUserId());
                        pageContext.setAttribute("user", user);
                    %>
                    <td>${fn:escapeXml(order.orderId)}</td>
                    <td><a href="/admin/users/user.jsp?id=${user.userId}">${fn:escapeXml(user.fullName)}<br><small><i>${fn:escapeXml(user.email)}</i></small></a></td>
                    <td>${fn:escapeXml(order.dateTime)}</td>
                    <td>${fn:escapeXml(order.amount)} USD</td>
                    <td>${fn:escapeXml(order.orderStatus)}</td>
                    <td>
                        <a href="/admin/orders/order.jsp?id=${order.orderId}"><button>View Order</button></a>
                         <form method="post" action="/api/admin/orders/delete">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <input type="submit" value="Delete Order">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    
<%@include file="../includes/footer.jsp"%>
</body>
</html>
