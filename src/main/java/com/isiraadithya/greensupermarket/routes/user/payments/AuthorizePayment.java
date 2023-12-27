package com.isiraadithya.greensupermarket.routes.user.payments;

import com.isiraadithya.greensupermarket.helpers.PaymentServices;
import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AuthorizePayment", value = "/api/user/payments/authorize_payment")
public class AuthorizePayment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Checking if the orderid is present
        if (!req.getParameterMap().containsKey("orderid")){
            resp.sendRedirect("/user/orders/");
            return;
        }

        // Checking if the Order is valid and the user owns it
        int orderId = Integer.parseInt(req.getParameter("orderid"));
        int userId = (int) req.getSession().getAttribute("userId");
        Order order = Order.findOrderById(orderId);
        if (order.getUserId() != userId){
            resp.sendRedirect("/user/orders/");
            return;
        }

        // Checking if the order is cancelled
        if (order.getOrderStatus().equals("CANCELLED")){
            resp.sendRedirect("/user/orders/");
            return;
        }

        try {
            PaymentServices paymentServices = new PaymentServices();
            paymentServices.setOrder(order);
            String approvalLink = paymentServices.authorizePayment();
            resp.sendRedirect(approvalLink);
        } catch (Exception ex){
            System.out.println("[ERR] /api/user/payments/authorize_payment " + ex.getMessage());
            resp.setStatus(500);
        }
    }
}
