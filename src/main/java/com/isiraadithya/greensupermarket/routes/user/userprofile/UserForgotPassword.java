package com.isiraadithya.greensupermarket.routes.user.userprofile;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UserForgotPassword", value = "/api/user/forgot-password")
public class UserForgotPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

//        Input Validation
        if (email.equals("null")){
            resp.sendRedirect("/forgotpassword.jsp?err=Invalid Data");
            return;
        }

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() != -1){
            userObj.generatePasswordResetToken();
            try {
                userObj.sendPasswordResetEmail();
            } catch (Exception ex){
                System.out.println(ex.getMessage());
            }
            resp.sendRedirect("/forgotpassword.jsp?msg=Check your email inbox");
        } else {
            resp.sendRedirect("/forgotpassword.jsp?err=Invalid Email");
            return;
        }
    }
}
