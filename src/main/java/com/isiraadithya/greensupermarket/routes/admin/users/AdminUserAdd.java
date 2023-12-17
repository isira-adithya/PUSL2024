package com.isiraadithya.greensupermarket.routes.admin.users;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "adminUserAdd", value = "/api/admin/users/add")
public class AdminUserAdd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String phone = req.getParameter("phone");
        String street_address = req.getParameter("street_address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String country = req.getParameter("country");
        String postalcode = req.getParameter("postalcode");
        String role = "USER";

        switch (req.getParameter("role")){
            case "ADMIN":
                role = "ADMIN";
                break;
            default:
                role = "USER";
                break;
        }

//        Input Validation
        if ((email == "null") || (firstname == "null") || (lastname == "null") || (phone == "null") || (street_address == "null") || (city == "null") || (state == "null") || (country == "null") || (postalcode == "null") ){
            resp.sendRedirect("/signup.jsp?err=Invalid Data");
        }

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() == -1){
            try {
                User newUser = new User(email, firstname, lastname, phone, street_address, city, state, country, postalcode, role);
                newUser.setPassword(password);
                newUser.saveUser();
            } catch (Exception ex) {
                resp.sendRedirect("/admin/users/add.jsp?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
            }
            resp.sendRedirect("/admin/users/");
        } else {
            resp.sendRedirect("/admin/users/add.jsp?err=Email Exists in our database");
        }
    }
}
