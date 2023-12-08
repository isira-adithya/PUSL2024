package com.isiraadithya.greensupermarket.routes.user;

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
        if (email != "null"){
            User userObj = User.FindUserByEmail(email);
            if (userObj.getUserId() != -1){
                if (userObj.checkPassword(password)) {
                    if (userObj.getRole().equals("ADMIN")){
                        resp.sendRedirect("/admin/login.jsp");
                        return;
                    }
                    HttpSession session = req.getSession(true);
                    session.setAttribute("isLoggedIn", true);
                    session.setAttribute("email", email);
                    session.setAttribute("role", "USER");
                    resp.sendRedirect("/user/profile.jsp");
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
