package com.isiraadithya.greensupermarket.routes.misc;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "userLogin", value = "/api/misc/addSupportTicket")
public class AddContactRequest extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String title = req.getParameter("title");
            String subject = req.getParameter("subject");



            resp.sendRedirect("/contact-us.jsp?msg=Success");
        } catch (Exception ex){
            resp.sendRedirect("/contact-us.jsp?msg=Something went wrong. Please try again later.");
        }
    }
}
