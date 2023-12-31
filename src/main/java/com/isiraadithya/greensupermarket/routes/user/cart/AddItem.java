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

        // Checking if the product is visible to public
        if (!product.getVisibility()){
            resp.setStatus(400);
            return;
        }

        // Checking if there are enough products in our inventory
        if (product.getQuantity() < quantity){
            resp.sendRedirect(req.getHeader("Referer"));
        }

        Cart userCart = (Cart) req.getSession().getAttribute("cart");
        if (userCart == null){
            System.out.println("[WARN] Unexpected user session found without a cart. Creating a new cart with user id " + (int) req.getSession().getAttribute("userId"));
            userCart = new Cart((int) req.getSession().getAttribute("userId"));
        }
        userCart.addProduct(product, quantity);
        req.getSession().setAttribute("cart", userCart);

        resp.sendRedirect("/user/cart.jsp");
    }
}
