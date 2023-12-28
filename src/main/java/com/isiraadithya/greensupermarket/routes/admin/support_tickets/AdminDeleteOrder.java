package com.isiraadithya.greensupermarket.routes.admin.support_tickets;

import com.isiraadithya.greensupermarket.models.Order;
import com.isiraadithya.greensupermarket.models.SupportTicket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "adminTicketDelete", value = "/api/admin/support_tickets/delete")
public class AdminDeleteOrder extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int ticketId = -1;
        try {
            ticketId = Integer.parseInt(req.getParameter("ticketId"));
        } catch (NumberFormatException exception){
            resp.setStatus(400);
            return;
        }

        SupportTicket ticket = SupportTicket.findSupportTicketById(ticketId);
        if (ticket.getTicketId() != -1){
            try {
                ticket.deleteTicket();
            } catch (Exception ex) {
                resp.sendRedirect("/admin/support_tickets/?err=Something went wrong, please try again later");
                System.out.println(ex.getMessage());
                return;
            }
            resp.sendRedirect("/admin/support_tickets/");
        } else {
            resp.sendRedirect("/admin/support_tickets/?err=Order does not exists in our database");
        }
    }
}
