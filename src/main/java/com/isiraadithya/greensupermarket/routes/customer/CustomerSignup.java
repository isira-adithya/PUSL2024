package com.isiraadithya.greensupermarket.routes.customer;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.PreparedStatement;

@WebServlet(name = "customerSignup", value = "/api/customer/signup")
public class CustomerSignup extends HttpServlet {
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

//        Input Validation
        if ((email == "null") || (firstname == "null") || (lastname == "null") || (phone == "null") || (street_address == "null") || (city == "null") || (state == "null") || (country == "null") || (postalcode == "null") ){
            resp.sendRedirect("/signup.jsp?err=Invalid Data");
        }

        User userObj = User.FindUserByEmail(email);
        if (userObj.getUserId() == -1){
            try {
                User newUser = new User(email, firstname, lastname, phone, street_address, city, state, country, postalcode, role);
                newUser.setPassword(password);
                newUser.saveUser();
            } catch (Exception ex) {
                resp.sendRedirect("/signup.jsp?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
            }
            resp.sendRedirect("/login.jsp?msg=Successful");
        } else {
            resp.sendRedirect("/login.jsp?err=Email Exists in our database");
        }
    }
}
