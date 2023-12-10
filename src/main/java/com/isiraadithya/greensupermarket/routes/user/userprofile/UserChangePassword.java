package com.isiraadithya.greensupermarket.routes.user.userprofile;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "userChangePassword", value = "/api/user/change-password")
public class UserChangePassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("email");
        String current_password = req.getParameter("current_password");
        String new_password = req.getParameter("new_password");

//        Input Validation
        if ((current_password == "null") || (new_password == "null") ){
            resp.sendRedirect("/user/changepassword.jsp?err=Invalid Data");
        }

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() != -1){
            if (userObj.checkPassword(current_password)){
                userObj.setPassword(new_password);
                userObj.updateUser();
                resp.sendRedirect("/user/profile.jsp?msg=Successful");
            } else {
                resp.sendRedirect("/user/changepassword.jsp?err=Invalid Password");
            }
        } else {
            resp.sendRedirect("/user/changepassword.jsp?err=Invalid Data");
        }
    }
}
