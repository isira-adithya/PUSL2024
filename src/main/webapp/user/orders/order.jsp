<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya, @hashen-ruwanpura
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
<%@include file="../../includes/header.jsp"%>

 <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
  <div class="cart-container my-5">
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

      <div class="mt-4 mb-2">Date/Time: <i>${order.dateTime.toString()}</i><br></div>
      <div>
      Payment Status:
      <c:if test="${order.paymentStatus.equals('PENDING')}">
          <span><b class="btn btn-white pb-2" style="color: #00B207">PENDING</b></span>
          <div class="alert alert-primary">
              <b>
                  <small>
                      Note: You have to make the payment for this order before ${expireDateTime.toLocaleString()}. Otherwise, this order will be cancelled and you will have to order again with the updated prices.
                      <br><br>
                      We would like to inform you that when making a payment through PayPal for your order, please be aware that additional charges for taxes and shipping costs may apply.
                  </small>
              </b>
          </div>
      </c:if>
      <c:if test="${order.paymentStatus.equals('COMPLETED')}"><span><b class="btn btn-white pb-2" style="color: green;">COMPLETED</b></span></c:if>
          <c:if test="${order.paymentStatus.equals('PENDING_REFUND')}"><span><b class="btn btn-white pb-2" style="color: green;">PENDING_REFUND</b></span></c:if>
          <c:if test="${order.paymentStatus.equals('REFUNDED')}"><span><b class="btn btn-white pb-2" style="color: green;">REFUNDED</b></span></c:if>
      <c:if test="${order.paymentStatus.equals('ERROR')}">
          <span><b class="btn btn-white pb-2" style="color: red;">ERROR</b><br></span>
          <div class="alert alert-primary">
              <b>
                  <small class="mb-4">
                      Something went wrong while processing your payment. Please try again later.
                  </small>
              </b>
          </div>
          <br>
      </c:if>
        </div>

      <div>
          Delivery Status:
          <c:if test="${order.deliveryStatus.equals('PENDING')}">
              <b class="btn btn-white pb-2" style="color: #00B207">PENDING</b><br>
              <div class="alert alert-primary">
                  <b>
                      <small class="mb-4">
                          Your order is on the way, if you haven't received the order within 7 days after you placed your order, please inform us.
                      </small>
                  </b>
              </div>
          </c:if>
          <c:if test="${order.deliveryStatus.equals('COMPLETED')}"><b class="btn btn-white pb-2" style="color: green;">COMPLETED</b></c:if>
          <c:if test="${order.deliveryStatus.equals('N/A')}">
              <b class="btn btn-white pb-2" style="color: black;">Not Applicable</b>
          </c:if>
          <c:if test="${order.deliveryStatus.equals('CANCELLED')}">
              <b class="btn btn-white pb-2" style="color: black;">CANCELLED</b>
          </c:if>
      </div>

    <c:if test="${order.paymentStatus.equals('PENDING')}">
        
        <div class="mt-4">
            <div class="row text-center">
                <div class="col-4">
                    <button type="submit" class="btn btn-primary custom-button"  onclick="location.href ='/api/user/payments/authorize_payment?orderid=${order.orderId}'" style="background-color:#00B207">Pay 💵</button>
                </div>
                <div class="col-4">
                    <form id="cancelForm" method="post" action="/api/user/orders/cancel">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                    </form>
                    <button onclick="if (confirm('Are you sure?')) {document.getElementById('cancelForm').submit()}" class="btn btn-danger">Cancel</button>
                </div>
                <div class="col-4">
                    <button type="button" class="btn btn-primary custom-button" onclick="location.href ='/user/orders/'">Go Back</button>
                </div>
            </div>
        </div>

    </c:if>
  </div>
</div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

