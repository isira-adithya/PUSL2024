package com.isiraadithya.greensupermarket.routes.misc;

import com.isiraadithya.greensupermarket.models.Cart;
import com.isiraadithya.greensupermarket.models.SupportTicket;
import com.isiraadithya.greensupermarket.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "createSupportTicket", value = "/api/misc/createSupportTicket")
public class AddContactRequest extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String title = req.getParameter("title");
            String subject = req.getParameter("subject");

            SupportTicket newTicket = new SupportTicket(name, email, title, subject);
            newTicket.saveTicket();

            resp.sendRedirect("/contact-us.jsp?msg=Success");
        } catch (Exception ex){
            resp.sendRedirect("/contact-us.jsp?msg=Something went wrong. Please try again later.");
        }
    }
}
