package com.isiraadithya.greensupermarket.routes.user.userprofile;

import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "userUpdate", value = "/api/user/update")
public class UserUpdate extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = (String) req.getSession().getAttribute("email");
        String firstname = req.getParameter("firstname");
        String lastname = req.getParameter("lastname");
        String phone = req.getParameter("phone");
        String street_address = req.getParameter("street_address");
        String city = req.getParameter("city");
        String state = req.getParameter("state");
        String country = req.getParameter("country");
        String postalcode = req.getParameter("postalcode");

        User userObj = User.findUserByEmail(email);
        if (userObj.getUserId() != -1){
            userObj.setFirstname(firstname);
            userObj.setLastname(lastname);
            userObj.setPhone(phone);
            userObj.setStreetAddress(street_address);
            userObj.setCity(city);
            userObj.setState(state);
            userObj.setCountry(country);
            userObj.setPostalcode(postalcode);
            userObj.updateUser();
            resp.sendRedirect("/user/profile.jsp?msg=Successful");
        } else {
            resp.sendRedirect("/user/profile.jsp?err=Invalid Data");
        }
    }
}
