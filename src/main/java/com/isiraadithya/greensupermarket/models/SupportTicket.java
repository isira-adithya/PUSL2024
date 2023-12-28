package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import javax.xml.crypto.Data;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class SupportTicket {
    private int ticketId = -1;
    private String full_name;
    private String email;
    private String title;
    private String subject;
    private boolean isRead;
    private Timestamp createdAt;

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
    public Timestamp getCreatedAt(){return this.createdAt;}
    private void setCreatedAt(Timestamp timestamp){this.createdAt = timestamp;}
    public boolean isRead() {
        return isRead;
    }
    public void setRead(boolean read) {
        isRead = read;
    }

    // Constructor
    public SupportTicket(String full_name, String email, String title, String subject){
        this.email = email;
        this.full_name = full_name;
        this.title = title;
        this.subject = subject;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    public void saveTicket(){
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "INSERT INTO SupportTickets(full_name, email, title, subject) VALUES (?, ?, ?, ?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);

            sqlStatement.setString(1, this.full_name);
            sqlStatement.setString(2, this.email);
            sqlStatement.setString(3, this.title);
            sqlStatement.setString(4, this.subject);

            sqlStatement.executeQuery();

            Database.closeConnection();
        } catch (Exception ignore){

        }
    }

    public static List<SupportTicket> findSupportTickets(boolean isRead){
        List<SupportTicket> supportTickets = new ArrayList<SupportTicket>();
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "SELECT * FROM SupportTickets WHERE markedAsRead=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setBoolean(1, isRead);
            ResultSet resultSet = sqlStatement.executeQuery();

            int _ticketId = -1;
            String _fullname = "NULL";
            String _email = "NULL";
            String _title = "NULL";
            String _subject = "NULL";
            boolean _markedAsRead = false;
            Timestamp _createdAt = new Timestamp(1);
            while(resultSet.next()){
                _ticketId = resultSet.getInt("ticketid");
                _fullname = resultSet.getString("full_name");
                _email = resultSet.getString("email");
                _title = resultSet.getString("title");
                _subject = resultSet.getString("subject");
                _markedAsRead = resultSet.getBoolean("markedAsRead");
                _createdAt = resultSet.getTimestamp("createdAt");

                SupportTicket _tmp = new SupportTicket(_fullname, _email, _title, _subject);
                _tmp.setTicketId(_ticketId);
                _tmp.setCreatedAt(_createdAt);
                _tmp.setRead(_markedAsRead);

                supportTickets.add(_tmp);
            }
            Database.closeConnection();
            return supportTickets;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return supportTickets;
    }

    public static SupportTicket findSupportTicketById(int ticketId){
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "SELECT * FROM SupportTickets WHERE ticketid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, ticketId);
            ResultSet resultSet = sqlStatement.executeQuery();

            int _ticketId = -1;
            String _fullname = "NULL";
            String _email = "NULL";
            String _title = "NULL";
            String _subject = "NULL";
            boolean _markedAsRead = false;
            Timestamp _createdAt = new Timestamp(1);
            SupportTicket _tmp;
            while(resultSet.next()){
                _ticketId = resultSet.getInt("ticketid");
                _fullname = resultSet.getString("full_name");
                _email = resultSet.getString("email");
                _title = resultSet.getString("title");
                _subject = resultSet.getString("subject");
                _markedAsRead = resultSet.getBoolean("markedAsRead");
                _createdAt = resultSet.getTimestamp("createdAt");
            }
            _tmp = new SupportTicket(_fullname, _email, _title, _subject);
            _tmp.setTicketId(_ticketId);
            _tmp.setCreatedAt(_createdAt);
            _tmp.setRead(_markedAsRead);

            Database.closeConnection();

            return  _tmp;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return new SupportTicket("NULL","NULL","NULL","NULL");
    }

    public void deleteTicket(){
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "DELETE FROM SupportTickets WHERE ticketid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, this.ticketId);
            sqlStatement.executeQuery();

            Database.closeConnection();
        } catch (Exception ignore){

        }
    }
}
