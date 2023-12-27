package com.isiraadithya.greensupermarket.routes.user.order;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "OrderCancel", value = "/api/user/orders/cancel")
public class OrderCancel extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int orderId = -1;
        if (req.getParameterMap().containsKey("orderId")){
            orderId = Integer.parseInt(req.getParameter("orderId"));
        }
        try {
            Order order = Order.findOrderById(orderId);
            order.setOrderStatus("CANCELLED");
            order.updateOrder();

            // Resetting the cart
            HttpSession session = req.getSession(true);
            Cart userCart = new Cart((int) session.getAttribute("userId"));
            session.setAttribute("cart", userCart);

            resp.sendRedirect("/user/orders/order.jsp?id=" + order.getOrderId());
        } catch (Exception ex){
            System.out.println(ex.getMessage());
            resp.setStatus(500);
        }

    }
}
