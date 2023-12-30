package com.isiraadithya.greensupermarket.routes.admin.orders;

import com.isiraadithya.greensupermarket.models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminOrderStatusUpdate", value = "/api/admin/orders/updateOrderStatus")
public class UpdateOrderStatus extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = -1;
        String orderStatus = "PENDING";
        String deliveryStatus = "PENDING";
        try {
            orderId = Integer.parseInt(req.getParameter("orderId"));
        } catch (NumberFormatException exception){
            resp.setStatus(400);
            return;
        }

        if ((!req.getParameterMap().containsKey("deliveryStatus")) || (!req.getParameterMap().containsKey("orderStatus"))){
            resp.setStatus(500);
            return;
        } else {
            orderStatus = req.getParameter("orderStatus");
            deliveryStatus = req.getParameter("deliveryStatus");
        }

        Order orderObj = Order.findOrderById(orderId);
        if (orderObj.getOrderId() != -1){
            try {
                // Checking if the order status is changed to cancelled from another state. if so, sending the cancellation email.
                if (!orderObj.getOrderStatus().equals("CANCELLED") && orderStatus.equals("CANCELLED")){
                    orderObj.sendCancellationEmail();
                    orderObj.setPaymentStatus("PENDING_REFUND");
                    orderObj.setDeliveryStatus("N/A");
                }
                orderObj.setOrderStatus(orderStatus);
                orderObj.setDeliveryStatus(deliveryStatus);
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
