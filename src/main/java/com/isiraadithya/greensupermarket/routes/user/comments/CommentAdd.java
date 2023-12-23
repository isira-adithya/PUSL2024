package com.isiraadithya.greensupermarket.routes.user.comments;

import com.isiraadithya.greensupermarket.models.Comment;
import com.isiraadithya.greensupermarket.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "commentAdd", value = "/api/user/comments/add")
public class CommentAdd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = -1;
        int starCount = 0;
        int userId = (int) req.getSession().getAttribute("userId");
        Product product;

        // Star Validation
        if (req.getParameterMap().containsKey("star")){
            try {
                starCount = Integer.parseInt(req.getParameter("star"));
            } catch (NumberFormatException ex){
                starCount = 0;
            }
        }

//        Product ID Validation
        if (req.getParameterMap().containsKey("productId")){
            try {
                productId = Integer.parseInt(req.getParameter("productId"));
            } catch (NumberFormatException ex){
                productId = -1;
            }
        }
        if (productId >= 0){
            product = Product.findProductById(productId);
            if (product.getName().equals("NULL")){
                resp.sendRedirect(req.getHeader("Referer"));
                return;
            }
        } else {
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }
        if (!req.getParameterMap().containsKey("comment") || req.getParameter("comment").isBlank()){
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }


//        Adding the comment
        Comment newComment = new Comment(userId, productId, req.getParameter("comment"), starCount);
        newComment.saveComment();
        resp.sendRedirect("/products/product.jsp?id=" + String.valueOf(productId));

    }
}
