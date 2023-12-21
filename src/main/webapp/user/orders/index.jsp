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
        <div class="col-md-3">
            <div
                    style="width: 312px; height: 306px; padding-bottom: 12px; background: white; border-radius: 8px; border: 1px #E6E6E6 solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                <div
                        style="padding-top: 24px; padding-bottom: 16px; padding-left: 20px; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                    <div
                            style="color: #1A1A1A; font-size: 20px; font-family: Poppins; font-weight: 500; line-height: 30px; word-wrap: break-word">
                        Navigation</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; background: white; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                    <div
                            style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">

                        <img src="/uploads/images/profile/editprofile.jpg" style="width:20px; height:20px;">

                    </div>
                    <div
                            style="width: 238px; color: #1A1A1A; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;">
                        Edit Profile</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer; box-shadow: 3px 0px 0px #20B526 inset;">
                    <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex;">

                        <img src="/uploads/images/profile/orderhistory.jpg" style="width:20px; height:20px;">

                    </div>
                    <div
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:4px;" onclick="location.href = '/user/orders/index.jsp'" >
                        Order History</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">
                    <div style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">

                        <img src="/uploads/images/profile/shoppingcart.jpg" style="width:20px; height:20px;">

                    </div>
                    <div a href="/cart.jsp"
                         style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;" onclick="location.href = '/user/cart.jsp'">
                        Shopping Cart</div>
                </div>
                <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex; cursor: pointer;">

                    <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex">
                        <img src="/uploads/images/profile/logout.jpg" style="width:20px; height:20px;">

                    </div>

                    <div
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word; padding-left:5px;" onclick="location.href = '/logout.jsp'">
                        Log-out</div>
                </div>
            </div>

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
