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

         .menu-container {
            max-width: 950px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .menu-container:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }
        

        .menu-title {
            font-size: 20px;
            font-weight: 500;
            padding: 5px 0px 10px 0px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: #666666;
            font-size: 16px;   
            border:none;
            transition: background-color 0.3s;
        }

        .menu-item:hover {
            background-color: #e9ecef;
            
        }
        .menu-item p:hover{
            text-decoration:none;
            
        }

        .menu-item img {
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }

        .menu-text {
            margin:0px;
        }
        .menu-text:hover{
            text-decoration: none;
        }

        .account-info {
            padding: 16px;
        }
        
       .image{
            margin-bottom: 50px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
    </style>
</head>
<body>
<%@include file="../../includes/header.jsp"%>

    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
<div class="container">
    <div class="row">
 <div class="col-md-12 col-lg-3 menu-container">
            <div class="menu-title text-center">Navigation</div>
            
            <a href="/user/profile.jsp" class="menu-text">
                <div class="menu-item">
                    <img src="/uploads/images/profile/Edit.png" alt="Edit Profile" class="mr-2">
                    <p class="text-center menu-text">Edit Profile</p>
                </div>
            </a>
            
            <a href="/user/orders/index.jsp" class="menu-text">
                <div class="menu-item">
                    <img src="/uploads/images/profile/orderhistory.jpg" alt="Order History" class="mr-2">
                    <p class="text-center menu-text">Order History</p>
                </div>
            </a>
            
            <a href="/user/cart.jsp" class="menu-text">
                <div class="menu-item">
                    <img src="/uploads/images/profile/shoppingcart.jpg" alt="Shopping Cart" class="mr-2">
                    <p class="text-center menu-text">Shopping Cart</p>
                </div>
            </a>
            
            <a href="/logout.jsp" class="menu-text">
                <div class="menu-item">
                    <img src="/uploads/images/profile/logout.jpg" alt="Log-out" class="mr-2">
                    <p class="text-center menu-text">Log-out</p>
                </div>
            </a>
        </div>

        <div class="col-md-9">
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
                                        <td><a href="/user/orders/order.jsp?id=${order.orderId}" class="custom-btn" style="margin: 0;">View Order</a></td>
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
    </div>
</div>
<%@include file="../../includes/footer.jsp"%>
</body>
</html>
