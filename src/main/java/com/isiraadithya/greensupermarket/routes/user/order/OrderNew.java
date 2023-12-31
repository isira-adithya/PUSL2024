package com.isiraadithya.greensupermarket.routes.user.order;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "OrderNew", value = "/api/user/orders/new")
public class OrderNew extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        try {
            Cart userCart = (Cart) req.getSession().getAttribute("cart");
            Order newOrder = new Order(userCart);
            userCart = new Cart(userId);
            req.getSession().setAttribute("cart", userCart);
            resp.sendRedirect("/user/orders/order.jsp?id=" + newOrder.getOrderId());
        } catch (Exception ex){
            System.out.println(ex.getMessage());
            resp.setStatus(500);
        }

    }
}
