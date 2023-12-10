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
        int userId = (int) req.getSession().getAttribute("userId");
        Product product;

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
                resp.sendRedirect("/products/");
                return;
            }
        } else {
            resp.sendRedirect("/products/");
            return;
        }
        if (!req.getParameterMap().containsKey("comment") || req.getParameter("comment").isBlank()){
            resp.sendRedirect("/products/");
            return;
        }


//        Adding the comment
        Comment newComment = new Comment(userId, productId, req.getParameter("comment"));
        newComment.saveComment();
        resp.sendRedirect("/products/product.jsp?id=" + String.valueOf(productId));

    }
}
