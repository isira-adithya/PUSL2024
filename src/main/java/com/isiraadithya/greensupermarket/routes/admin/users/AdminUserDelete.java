package com.isiraadithya.greensupermarket.routes.admin.users;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminUserDelete", value = "/api/admin/users/delete")
public class AdminUserDelete extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int userId = -1;
        try {
            userId = Integer.parseInt(req.getParameter("userId"));
        } catch (NumberFormatException){
            resp.setStatus(400);
            return;
        }

        User userObj = User.findUserById(userId);
        if (userObj.getUserId() != -1){
            try {
                userObj.deleteUser();
            } catch (Exception ex) {
                resp.sendRedirect("/admin/users/?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
                return;
            }
            resp.sendRedirect("/admin/users/");
        } else {
            resp.sendRedirect("/admin/users/add.jsp?err=Account does not exists in our database");
        }
    }
}
