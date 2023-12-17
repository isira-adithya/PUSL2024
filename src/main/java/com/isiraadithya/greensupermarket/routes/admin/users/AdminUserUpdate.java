package com.isiraadithya.greensupermarket.routes.admin.users;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminUserUpdate", value = "/api/admin/users/update")
public class AdminUserUpdate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
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
        if (userObj.getUserId() != -1){
            try {
                userObj.setFirstname(firstname);
                userObj.setLastname(lastname);
                userObj.setPhone(phone);
                userObj.setStreetAddress(street_address);
                userObj.setCity(city);
                userObj.setState(state);
                userObj.setCountry(country);
                userObj.setPostalcode(postalcode);
                userObj.setRole(role);
                userObj.updateUser();

                resp.sendRedirect("/admin/users/user.jsp?id=" + userObj.getUserId());
            } catch (Exception ex) {
                resp.sendRedirect("/admin/users/add.jsp?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
            }
            resp.sendRedirect("/admin/users/");
        } else {
            resp.sendRedirect("/admin/users/add.jsp?err=Account does not exists in our database");
        }
    }
}
