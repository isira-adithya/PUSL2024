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
        <form id="updateOrderForm" method="post" action="/api/admin/orders/updateOrderStatus">
            <table>
                <tr>
                    <td>Payment Status:</td>
                    <td><span class="btn btn-dark btn-sm" style="cursor: default;">${order.paymentStatus}</span></td>
                </tr>

                <c:if test="${order.paymentStatus.equals('COMPLETED') || order.paymentStatus.equals('PENDING_REFUND') || order.paymentStatus.equals('REFUNDED')}">
                    <td>Delivery Status:</td>
                    <td>
                        <select class="form-select" name="deliveryStatus">
                            <option value="CANCELLED" ${order.deliveryStatus.equals('CANCELLED') ? 'selected' : ''}>CANCELLED</option>
                            <option value="PENDING" ${order.deliveryStatus.equals('PENDING') ? 'selected' : ''}>PENDING</option>
                            <option value="COMPLETED" ${order.deliveryStatus.equals('COMPLETED') ? 'selected' : ''}>COMPLETED</option>
                        </select>
                    </td>
                </c:if>

                <tr>
                    <td>Order Status:</td>
                    <td>
                        <c:if test="${!order.orderStatus.equals('CANCELLED')}">
                            <select class="form-select" name="orderStatus">
                                <option value="PENDING" ${order.orderStatus.equals('PENDING') ? 'selected' : ''}>PENDING</option>
                                <option value="COMPLETED" ${order.orderStatus.equals('COMPLETED') ? 'selected' : ''} ${!order.deliveryStatus.equals('COMPLETED') ? 'disabled' : ''}>COMPLETED</option>
                            </select>
                        </c:if>
                        <c:if test="${order.orderStatus.equals('CANCELLED')}">
                            <div class="btn btn-danger btn-sm" style="cursor: default;">CANCELLED</div>
                            <input name="orderStatus" value="${order.orderStatus}" type="hidden">
                        </c:if>
                    </td>
                </tr>
            </table>
            <input type="hidden" name="orderId" value="${order.orderId}">

            <div class="alert alert-primary mt-3">
                <p>You can use the <b><i>Order Status</i></b> value to sort/filter orders.</p>
                <p>Note: Marking an order <b>Cancelled</b> will notify the user via an email and make delivery status to <b>Not Applicable</b>. Furthermore, You will have to perform a refund to the customer as soon as possible.</p>
            </div>

            <br>
        </form>

    </p>
    <br>

    <c:if test="${order.paymentStatus.equals('PENDING_REFUND')}">
        <form method="post" id="toggleRefund" action="/api/admin/orders/toggle-refund">
            <input type="hidden" name="orderId" value="${order.orderId}">
            <input type="hidden" name="refunded" value="true">
        </form>
    </c:if>
    <c:if test="${order.paymentStatus.equals('REFUNDED')}">
        <form method="post" id="toggleRefund" action="/api/admin/orders/toggle-refund">
            <input type="hidden" name="orderId" value="${order.orderId}">
            <input type="hidden" name="refunded" value="false">
        </form>
    </c:if>

    <a class="btn btn-primary btn-sm" href="/admin/orders/">Go back</a>
    <button onclick="document.getElementById('updateOrderForm').submit()" class="btn btn-success btn-sm" href="/admin/orders/">Update Order</button>
    <c:if test="${order.paymentStatus.equals('PENDING_REFUND')}">
        <button onclick="confirm('Are you sure?') ? document.getElementById('toggleRefund').submit() : false" class="btn btn-secondary btn-sm">Confirm Refund</button>
    </c:if>
    <c:if test="${order.paymentStatus.equals('REFUNDED')}">
        <button onclick="confirm('Are you sure?') ? document.getElementById('toggleRefund').submit() : false" class="btn btn-secondary btn-sm">Revert Refund Status</button>
    </c:if>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

