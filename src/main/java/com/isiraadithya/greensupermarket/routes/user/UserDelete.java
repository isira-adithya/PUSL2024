package com.isiraadithya.greensupermarket.routes.user;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "userDelete", value = "/api/user/delete")
public class UserDelete extends HttpServlet {
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("email");

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() != -1){
            userObj.deleteUser();
            resp.setStatus(200);
        } else {
            resp.sendRedirect("/user/profile.jsp?err=Invalid Data");
        }
    }
}
