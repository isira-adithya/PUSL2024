package com.isiraadithya.greensupermarket.routes.admin.orders;

import com.isiraadithya.greensupermarket.models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminToggleRefundStatus", value = "/api/admin/orders/toggle-refund")
public class ToggleRefundStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = -1;
        boolean isRefunded = false;

        try {
            orderId = Integer.parseInt(req.getParameter("orderId"));
        } catch (NumberFormatException exception){
            resp.setStatus(400);
            return;
        }

        if (!req.getParameterMap().containsKey("refunded")){
            resp.setStatus(500);
            return;
        }

        isRefunded = (req.getParameter("refunded").equals("true"));

        Order orderObj = Order.findOrderById(orderId);
        if (orderObj.getOrderId() != -1){
            try {
                // Checking if the order status is changed to cancelled from another state. if so, sending the cancellation email.
                if (isRefunded){
                    orderObj.setPaymentStatus("REFUNDED");
                } else {
                    orderObj.setPaymentStatus("PENDING_REFUND");
                }
                orderObj.updateOrder();
            } catch (Exception ex) {
                resp.sendRedirect("/admin/orders/?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
                return;
            }
            resp.sendRedirect("/admin/orders/order.jsp?id=" + orderObj.getOrderId());
        } else {
            resp.sendRedirect("/admin/orders/?err=Order does not exists in our database");
        }
    }
}
