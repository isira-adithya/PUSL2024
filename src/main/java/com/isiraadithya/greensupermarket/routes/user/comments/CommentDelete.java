package com.isiraadithya.greensupermarket.routes.user.comments;

import com.isiraadithya.greensupermarket.models.Comment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "commentDelete", value = "/api/user/comments/delete")
public class CommentDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int commentId = -1;
        int userId = (int) req.getSession().getAttribute("userId");
        Comment comment;

        // Product ID Validation
        if (req.getParameterMap().containsKey("commentId")){
            try {
                commentId = Integer.parseInt(req.getParameter("commentId"));
            } catch (NumberFormatException ex){
                commentId = -1;
            }
        }
        if (commentId >= 0){
            comment = Comment.findCommentById(commentId);
            if (comment.getContent().equals("NULL")){
                resp.sendRedirect(req.getHeader("Referer"));
                return;
            }
        } else {
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }

        if (comment.getUser().getUserId() == userId){
            // Deleting the comment only if the user owns the comment
            comment.deleteComment(commentId);
            resp.sendRedirect(req.getHeader("Referer"));
        } else {
            resp.sendRedirect(req.getHeader("Referer"));
        }
    }
}
