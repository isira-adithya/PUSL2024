package com.isiraadithya.greensupermarket.routes.user.wishlist;

import com.isiraadithya.greensupermarket.models.Product;
import com.isiraadithya.greensupermarket.models.WishList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "wishlistProductDelete", value = "/api/user/wishlist/deleteProduct")
public class RemoveProduct extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = -1;
        if (req.getParameterMap().containsKey("productId")){
            try {
                productId = Integer.parseInt(req.getParameter("productId"));
            } catch (NumberFormatException ignored){

            }
        }

        // ProductId and the Quantity must be a positive integer;
        if(productId <= 0){
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

        // Adding to wishlist
        int userId = (int) req.getSession().getAttribute("userId");
        WishList wishlist = WishList.findWishListByUserId(userId);

        // Creating a wishlist if it doesnt already exist in the database
        if (wishlist.getUserId() == -1){
            wishlist = new WishList(userId);
            wishlist.saveWishlist();
        }

        wishlist.removeProductFromWishlist(product);

        resp.sendRedirect("/user/wishlist/");
    }
}
