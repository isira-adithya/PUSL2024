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
    List<Order> orders;

    // Order Type Filtering
    String status;

    if (request.getParameter("orderStatus") != null){
        switch (request.getParameter("orderStatus")){
            case "cp":
                status = "COMPLETED";
                break;
            case "cl":
                status = "CANCELLED";
                break;
            default:
                status = "PENDING";
                break;
        }
        orders = Order.findOrdersByStatus(status);
    } else {
        orders = Order.getOrders();
    }
    pageContext.setAttribute("orders", orders);
%>
<html>
<head>
    <title>Manage Orders</title>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
body {
    text-align: center;
}

table {
    width: 80%;
    margin: 20px auto; /* Center the table */
    border-collapse: collapse;  
    text-align: center;
    
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    
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
    .image {
      margin-bottom: 60px;
      width: 100%;
      height: 130px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
      background-image: url("/uploads/images/products/Breadcrumbs.png");
      background-size: cover;
      background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }
}
        

    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>


    <div class="container">

        <div class="my-4 mx-2">
            <h4><b>Filter by Order Status</b></h4>
            <a class="btn btn-success btn-sm" href="/admin/orders/?orderStatus=cp">Completed Orders</a>
            <a class="btn btn-primary btn-sm" href="/admin/orders/?orderStatus=pd">Pending Orders</a>
            <a class="btn btn-danger btn-sm" href="/admin/orders/?orderStatus=cl">Cancelled Orders</a>
            <a class="btn btn-secondary btn-sm" href="/admin/orders/">All Orders</a>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered">
            <thead>
            <tr>
                 <th>Order ID</th>
                 <th>Customer</th>
                 <th>Placed at</th>
                 <th>Total</th>
                 <th>Status</th>
                <th>Payment Status</th>
                <th>Delivery Status</th>
                 <th colspan="2">Actions</th>
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
                    <td>${fn:escapeXml(order.paymentStatus)}</td>
                    <td>${fn:escapeXml(order.deliveryStatus)}</td>
                    <td>
                        <a class="btn btn-primary py-2"  href="/admin/orders/order.jsp?id=${order.orderId}">
                            <i class="fa-solid fa-eye"></i>
                        </a>
                    </td>
                    <td>
                        <button class="btn btn-danger py-2" onclick="if(confirm('Are you sure?')){document.getElementById('deleteOrder${order.orderId}Form').submit()}">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                        <form id="deleteOrder${order.orderId}Form" method="post" action="/api/admin/orders/delete">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table><br><br><br><br>
    </div>
    </div>   
<%@include file="../includes/footer.jsp"%>
</body>
</html>
