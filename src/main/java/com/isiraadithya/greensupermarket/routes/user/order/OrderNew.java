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

        try {
            Cart userCart = (Cart) req.getSession().getAttribute("cart");
            new Order(userCart);
            resp.sendRedirect("/user/orders.jsp");
        } catch (Exception ex){
            System.out.println(ex.getMessage());
            resp.setStatus(500);
        }

    }
}
