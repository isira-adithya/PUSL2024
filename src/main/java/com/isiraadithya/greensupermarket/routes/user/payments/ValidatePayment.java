package com.isiraadithya.greensupermarket.routes.user.payments;

import com.isiraadithya.greensupermarket.helpers.PaymentServices;
import com.isiraadithya.greensupermarket.models.Order;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ValidatePayment", value = "/api/user/payments/validate")
public class ValidatePayment extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String paymentId = req.getParameter("paymentId");
        String payerId = req.getParameter("payerId");
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        Order order = Order.findOrderById(orderId);

        try {
            PaymentServices paymentServices = new PaymentServices();
            Payment payment = paymentServices.executePayment(paymentId, payerId);
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);


            if (payment.getState().equals("approved")){
                order.setAdditionalCharges(PaymentServices.shippingCost + PaymentServices.tax);
                order.setPaymentState("COMPLETED");
                order.updateOrder();
            }

            resp.sendRedirect("/user/orders/order.jsp?id=" + orderId);
        } catch (Exception ex){
            System.out.println(ex.getMessage());
            resp.setStatus(500);
        }
    }
}
