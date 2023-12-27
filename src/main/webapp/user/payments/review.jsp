<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya, @hashen-ruwanpura
  Date: 12/10/2023
  Time: 4:25 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.PaymentServices" %>
<%@ page import="com.paypal.api.payments.Payment" %>
<%@ page import="com.paypal.api.payments.PayerInfo" %>
<%@ page import="com.paypal.api.payments.Transaction" %>
<%@ page import="com.paypal.api.payments.ShippingAddress" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int orderId = -1;
    int userId = (int) session.getAttribute("userId");
    if (request.getParameterMap().containsKey("orderid") && request.getParameterMap().containsKey("paymentId") && request.getParameterMap().containsKey("PayerID")){
        try {
            orderId = Integer.parseInt(request.getParameter("orderid"));
        } catch (NumberFormatException ex){
            orderId = -1;
        }
    }

    Order order = Order.findOrderById(orderId);
    Timestamp expireDateTime;
    // Checking if the order exists
    if (order.getAmount() <= 0){
        response.sendRedirect("/user/orders?err=Invalid Order");
        return;
    }
    // Checking if the user owns this Order
    if (order.getUserId() != userId){
        response.sendRedirect("/user/orders?err=Unauthorized");
        return;
    }

    String payerId = request.getParameter("PayerID");
    String paymentId = request.getParameter("paymentId");
    PayerInfo payerInfo;
    Transaction transaction;
    ShippingAddress shippingAddress;

    try {
        PaymentServices paymentServices = new PaymentServices();
        Payment payment = paymentServices.getPaymentDetails(paymentId);
        payerInfo = payment.getPayer().getPayerInfo();
        transaction = payment.getTransactions().get(0);
        shippingAddress = transaction.getItemList().getShippingAddress();
    } catch (Exception ex){
        System.out.println(ex.getMessage());
        response.setStatus(500);
        return;
    }

    expireDateTime = new Timestamp(order.getDateTime().getTime() + (1000 * 60 * 60 * 24));
    pageContext.setAttribute("order", order);
    pageContext.setAttribute("expireDateTime", expireDateTime);
    pageContext.setAttribute("payerId", payerId);
    pageContext.setAttribute("paymentId", paymentId);
    pageContext.setAttribute("payerInfo", payerInfo);
    pageContext.setAttribute("transaction", transaction);
    pageContext.setAttribute("shippingAddress", shippingAddress);
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Payment - GreenSuperMarket</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        .transaction-details {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;


        }

        .transaction-details:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

        .image {
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
        <div class="transaction-details mb-5">
        <h4>Please review before confirming the payment.</h4>
        <div class="row">
            <div class="mb-3 ">
                <label for="description" class="form-label">Description :</label>
                <input disabled type="text" class="form-control" id="description" value="${fn:escapeXml(transaction.description)}">
            </div>


            <div class="mb-3 col-sm-5 col-md-6">
                <label for="subtotal" class="form-label">Sub Total :</label>
                <input disabled type="text" class="form-control" id="subtotal" value="$${transaction.amount.details.subtotal}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="shippingcost" class="form-label">Shipping Cost :</label>
                <input disabled type="text" class="form-control" id="shippingcost" value="$${transaction.amount.details.shipping}">
            </div>

            <div class="mb-3">
                <label for="tax" class="form-label">Tax:</label>
                <input disabled type="text" class="form-control" id="tax" value="$${transaction.amount.details.tax}">
            </div>

            <div class="mb-3">
                <label for="tax" class="form-label">Total:</label>
                <input disabled type="text" class="form-control" id="tax" value="$${transaction.amount.total}">
            </div>


            <h3>
                <center>Payer Information</center>
            </h3>
            <div class="mb-3 col-sm-5 col-md-6">
                <label class="form-label">First Name :</label>
                <input disabled type="text" class="form-control" id="fname" value="${fn:escapeXml(payerInfo.firstName)}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label class="form-label">Last Name :</label>
                <input disabled type="text" class="form-control" id="lname" value="${fn:escapeXml(payerInfo.lastName)}">
            </div>

            <div class="mb-3 ">
                <label for="email" class="form-label">E-mail :</label>
                <input disabled type="email" class="form-control" id="email" value="${fn:escapeXml(payerInfo.email)}">
            </div>

            <h3>
                <center>Shipping Address</center>
            </h3>
            <div class="mb-3">
                <label for="rname" class="form-label">Recipient Name :</label>
                <input disabled type="text" class="form-control" id="rname" value="${fn:escapeXml(payerInfo.shippingAddress.recipientName)}">
            </div>

            <div class="mb-3">
                <label for="addressline1" class="form-label">Address Line 1 :</label>
                <input disabled type="text" class="form-control" id="addressline1" value="${fn:escapeXml(shippingAddress.line1)}">
            </div>

            <div class="mb-3">
                <label for="addressline2" class="form-label">Address Line 2 :</label>
                <input disabled type="text" class="form-control" id="addressline2" value="${fn:escapeXml(shippingAddress.line2)}">
            </div>

            <div class="mb-3 col-sm-5 col-md-6">
                <label for="city" class="form-label">City :</label>
                <input disabled type="text" class="form-control" id="city" value="${fn:escapeXml(shippingAddress.city)}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="state" class="form-label">State :</label>
                <input disabled type="text" class="form-control" id="state" value="${fn:escapeXml(shippingAddress.state)}">
            </div>

            <div class="mb-3 col-sm-5 col-md-6">
                <label for="country" class="form-label">Country :</label>
                <input disabled type="text" class="form-control" id="country" value="${fn:escapeXml(shippingAddress.countryCode)}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="postalCode" class="form-label">Zip Code :</label>
                <input disabled type="text" class="form-control" id="postalCode" value="${fn:escapeXml(shippingAddress.postalCode)}">
            </div>
        </div>
            <form action="/api/user/payments/validate" method="post">
                <input type="hidden" name="orderId" value="${order.orderId}">
                <input type="hidden" name="payerId" value="${fn:escapeXml(payerId)}">
                <input type="hidden" name="paymentId" value="${fn:escapeXml(paymentId)}">
                <button class="btn btn-primary" type="submit">Confirm</button>
                <button class="btn btn-danger" onclick="location.href = '/user/orders/'">Cancel</button>
            </form>
            <br>
        </div>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

