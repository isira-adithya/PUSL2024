package com.isiraadithya.greensupermarket.routes.user.cart;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "itemAdd", value = "/api/user/cart/addItem")
public class AddItem extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = -1;
        int quantity = -1;
        if (req.getParameterMap().containsKey("productId")){
            try {
                productId = Integer.parseInt(req.getParameter("productId"));
            } catch (NumberFormatException ignored){

            }
        }
        if (req.getParameterMap().containsKey("quantity")){
            try {
                quantity = Integer.parseInt(req.getParameter("quantity"));
            } catch (NumberFormatException ignored){

            }
        }

        // ProductId and the Quantity must be a positive integer;
        if((productId <= 0) || (quantity <= 0)){
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }

        // Checking if the productId is valid
        Product product = Product.findProductById(productId);
        if (product.getName().equals("NULL")){
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }

        Cart userCart = (Cart) req.getSession().getAttribute("cart");
        userCart.addProduct(product, quantity);
        req.getSession().setAttribute("cart", userCart);

        resp.sendRedirect("/user/cart.jsp");
    }
}
