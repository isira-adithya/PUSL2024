package com.isiraadithya.greensupermarket.routes.user.userprofile;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "userLogin", value = "/api/user/login")
public class UserLogin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        if (!email.equals("null")){
            User userObj = User.findUserByEmail(email);
            if (userObj.getUserId() != -1){
                if (userObj.checkPassword(password)) {
                    HttpSession session = req.getSession(true);
                    Cart userCart = new Cart(userObj.getUserId());
                    session.setAttribute("isLoggedIn", true);
                    session.setAttribute("email", email);
                    session.setAttribute("userId", userObj.getUserId());
                    session.setAttribute("role", userObj.getRole());
                    session.setAttribute("cart", userCart);
                    session.setAttribute("isEmailVerified", userObj.isEmailVerified());
                    if (userObj.getRole().equals("ADMIN")){
                        resp.sendRedirect("/admin/index.jsp");
                    } else {
                        resp.sendRedirect("/");
                    }
                } else {
                    resp.sendRedirect("/login.jsp?err=Invalid Username or Password");
                }
            } else {
                resp.sendRedirect("/login.jsp?err=Invalid Username or Password");
            }
        } else {
            resp.sendRedirect("/login.jsp?err=Invalid Username or Password");
        }
    }
}
