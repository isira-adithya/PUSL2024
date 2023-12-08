package com.isiraadithya.greensupermarket.routes.user;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UserResetPassword", value = "/api/user/reset-password")
public class UserResetPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String new_password = req.getParameter("new_password");
        String token = req.getParameter("token");

//        Input Validation
        if (email.equals("null")){
            resp.sendRedirect("/resetpassword.jsp?err=Invalid Data&token=" + token);
            return;
        }

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() != -1){
            boolean status = User.resetPassword(email, token, new_password);
            if (status) {
                resp.sendRedirect("/login.jsp?msg=Successful");
            } else {
                resp.sendRedirect("/resetpassword.jsp?err=Invalid Token");
            }

        } else {
            resp.sendRedirect("/resetpassword.jsp?err=Invalid Email&token=" + token);
            return;
        }
    }
}
