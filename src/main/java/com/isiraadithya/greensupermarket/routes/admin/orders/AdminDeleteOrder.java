package com.isiraadithya.greensupermarket.routes.admin.users;

import com.isiraadithya.greensupermarket.models.Order;
import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminOrderDelete", value = "/api/admin/orders/delete")
public class AdminDeleteOrder extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = -1;
        try {
            orderId = Integer.parseInt(req.getParameter("orderId"));
        } catch (NumberFormatException exception){
            resp.setStatus(400);
            return;
        }

        Order orderObj = Order.findOrderById(orderId);
        if (orderObj.getOrderId() != -1){
            try {
                orderObj.deleteOrder();
            } catch (Exception ex) {
                resp.sendRedirect("/admin/orders/?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
                return;
            }
            resp.sendRedirect("/admin/orders/");
        } else {
            resp.sendRedirect("/admin/orders/?err=Order does not exists in our database");
        }
    }
}
