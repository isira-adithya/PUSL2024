<%@ page import="java.util.List" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/includes/variables.jsp"%>
<%
    List<Order> orders = Order.getOrders();
    pageContext.setAttribute("orders", orders);
%>
<html>
<head>
    <title>Manage Orders</title>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>

table {
    width: 100%;
    margin: 20px auto; /* Center the table */
    border-collapse: collapse;  
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
    
}

th {
    background-color: #f2f2f2;
    font-weight: normal;
    font-size: 17px;
    
}
.custom-btn {
            display: inline-block;
            margin: 10px;
            padding: 8px 15px;
            text-decoration: none;
            color: #ffffff;
            background-color: #00B207;
            border: none;
            border-radius: 20px;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }

        .custom-btn:hover {
            background-color: #666666;
            color: #ffffff;
            text-decoration: none;
        }

    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>

    
<div class="container">
    <div class="row justify-content-center mt-5">
        <div class="col-lg-12">
            <div class="table-responsive">
                <table class="table table-bordered">
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
                        <a href="/admin/orders/order.jsp?id=${order.orderId}"><button class="custom-btn">View Order</button></a>
                         <form method="post" action="/api/admin/orders/delete">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <input type="submit" value="Delete Order"class="custom-btn">
                        </form>
                    </td>
                </tr>
            </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
