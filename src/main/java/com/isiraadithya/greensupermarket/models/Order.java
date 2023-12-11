package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

public class Order {
    private int orderId;
    private int userId;
    private Date dateTime;
    private double amount;


    // Getter and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getDateTime() {
        return dateTime;
    }

    public void setDateTime(Date dateTime) {
        this.dateTime = dateTime;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Order(int userid, double amount){
        this.dateTime = new Date(System.currentTimeMillis());
        this.amount = amount;
        this.userId = userid;
    }

    public void saveOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO Orders(userid, orderdate, amount) VALUES (?,?,?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setDate(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            sqlStatement.execute();
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }



}
