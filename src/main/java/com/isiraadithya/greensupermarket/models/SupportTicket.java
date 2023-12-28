package com.isiraadithya.greensupermarket.models;

public class SupportTicket {
    private int ticketId = -1;
    private String full_name;
    private String email;
    private String title;
    private String subject;

    // Getters and Setters
    public int getTicketId() {
        return ticketId;
    }

    private void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public String getFullName() {
        return full_name;
    }

    public void setFullName(String full_name) {
        this.full_name = full_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    // Constructor
    public SupportTicket(String full_name, String email, String title, String subject){
        this.email = email;
        this.full_name = full_name;
        this.title = title;
        this.subject = subject;
    }
}
