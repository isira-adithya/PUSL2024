package com.isiraadithya.greensupermarket.routes.customer;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "customerLogin", value = "/api/customer/login")
public class CustomerLogin extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        if (username != "null"){
            User userObj = User.FindUserByEmail(username);
            if (userObj.getUserId() != -1){
                if (userObj.checkPassword(password)) {
                    HttpSession session = req.getSession(true);
                    session.setAttribute("isLoggedIn", true);
                    session.setAttribute("email", username);
                    session.setAttribute("role", "customer");
                    resp.sendRedirect("/");
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
