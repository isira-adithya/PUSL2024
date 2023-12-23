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
body {
    text-align: center;
}

table {
    width: 80%;
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


img {
    max-width: 100%;
    height: auto;
}

button {
    padding: 5px 10px;
    cursor: pointer;
}
#submitBtn {
    padding: 10px 15px;
    font-size: 16px;
    background-color: #4CAF50; /* Green background color */
    color: white; /* White text color */
    border: none;
    border-radius: 100px;
    cursor: pointer;
    width: 150px;
 }
 
.submitBtn {
    padding: 10px 15px;
    font-size: 16px;
    background-color: #4CAF50; /* Green background color */
    color: white; /* White text color */
    border: none;
    border-radius: 100px;
    cursor: pointer;
    width: 150px;
}
.Add-new-button{
    padding: 10px 15px;
    font-size: 23px;
    background-color: #00B207; /* Green background color */
    color: white; /* White text color */
    border: none;
    border-radius: 30px;
    cursor: pointer;
    width: 800px;
}
.icon{
    width:30px;
    height:30px;
}

    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        
        <br><br><br><br>
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
                        <a href="/admin/orders/order.jsp?id=${order.orderId}"><button class="submitBtn">View Order</button></a>
                        <form method="post" action="/api/admin/orders/delete"><br>
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <input id="submitBtn" type="submit" value="Delete Order">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table><br><br><br><br>
    </div>
    
<%@include file="../includes/footer.jsp"%>
</body>
</html>
