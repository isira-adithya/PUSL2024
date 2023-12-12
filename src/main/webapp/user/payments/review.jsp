<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
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
    <title>GreenSuperMarket - Shopping Cart</title>
</head>

<body>
<%@include file="../../includes/header.jsp"%>

    <center>
        <h4>Please review before confirming the payment.</h4>
        <table>
            <tr><th colspan="2">Transaction Details</th></tr>
            <tr>
                <td>Description:</td>
                <td>${fn:escapeXml(transaction.description)}</td>
            </tr>
            <tr>
                <td>SubTotal:</td>
                <td>$${transaction.amount.details.subtotal}</td>
            </tr>
            <tr>
                <td>Shipping Cost:</td>
                <td>$${transaction.amount.details.shipping}</td>
            </tr>
            <tr>
                <td>Tax:</td>
                <td>$${transaction.amount.details.tax}</td>
            </tr>
            <tr>
                <td>Total:</td>
                <td>$${transaction.amount.total}</td>
            </tr>
            <tr><th colspan="2">Payer Information</th></tr>
            <tr>
                <td>First Name:</td>
                <td>${fn:escapeXml(payerInfo.firstName)}</td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td>${fn:escapeXml(payerInfo.lastName)}</td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>${fn:escapeXml(payerInfo.email)}</td>
            </tr>
            <tr><th colspan="2">Shipping Address</th></tr>
            <tr>
                <td>Recipient Name:</td>
                <td>${fn:escapeXml(payerInfo.email)}</td>
            </tr>
            <tr>
                <td>Address Line 1:</td>
                <td>${fn:escapeXml(shippingAddress.line1)}</td>
            </tr>
            <tr>
                <td>Address Line 2:</td>
                <td>${fn:escapeXml(shippingAddress.line2)}</td>
            </tr>
            <tr>
                <td>City:</td>
                <td>${fn:escapeXml(shippingAddress.city)}</td>
            </tr>
            <tr>
                <td>State:</td>
                <td>${fn:escapeXml(shippingAddress.state)}</td>
            </tr>
            <tr>
                <td>Country Code:</td>
                <td>${fn:escapeXml(shippingAddress.countryCode)}</td>
            </tr>
            <tr>
                <td>Postal Code:</td>
                <td>${fn:escapeXml(shippingAddress.postalCode)}</td>
            </tr>
        </table>
        <form action="/api/user/payments/validate" method="post">
            <input type="hidden" name="orderId" value="${order.orderId}">
            <input type="hidden" name="payerId" value="${fn:escapeXml(payerId)}">
            <input type="hidden" name="paymentId" value="${fn:escapeXml(paymentId)}">
            <input type="submit" value="Confirm">
        </form>
        <br>
        <button onclick="location.href = '/user/orders/'">Cancel</button>
    </center>

<%@include file="../../includes/footer.jsp"%>
</body>

</html>

