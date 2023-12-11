package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;

public class Order {
    private int orderId;
    private int userId;
    private Date dateTime;
    private double amount;
    private OrderDetail orderDetails;
    private Cart cartObj; // Required when initializing an object


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

    public Order(Cart cartObj){
        this.dateTime = new Date(System.currentTimeMillis());
        this.amount = cartObj.getTotalCost();
        this.userId = cartObj.getUserId();
        this.cartObj = cartObj;
        if (this.saveOrder()){
            this.saveOrderDetails();
        }
    }

    // This specific constructor would be used to initialize the Order obj in find*() functions.
    private Order(int userId, double amount){
        this.dateTime = new Date(System.currentTimeMillis());
        this.amount = amount;
        this.userId = userId;
    }

    private void saveOrderDetails(){
        for(Map.Entry<Product, Integer> entry: this.cartObj.getProductQuantities().entrySet()){
            Product _product = entry.getKey();
            int _quantity = entry.getValue();
            OrderDetail orderDetail = new OrderDetail(this.orderId, _product.getProductId(), _quantity, (_product.getPrice() * _quantity));
            orderDetail.saveOrderDetail();
        };
    }

    public boolean saveOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO Orders(userid, orderdate, amount) VALUES (?,?,?)";
            String generatedColumns[] = {"orderid"};
            PreparedStatement sqlStatement = dbconn.prepareStatement(query, generatedColumns);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setDate(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            int affectedRows = sqlStatement.executeUpdate();

            // Taken from: https://stackoverflow.com/a/1915197/11670864, https://stackoverflow.com/a/40988131/11670864
            if (affectedRows > 0){
                try {
                    ResultSet generatedKeys = sqlStatement.getGeneratedKeys();
                    if (generatedKeys.next()){
                        this.orderId = generatedKeys.getInt("insert_id");
                        return true;
                    } else {
                        return false;
                    }
                } catch (Exception ex){
                    System.out.println(ex.getMessage());
                    return false;
                }
            }
            Database.closeConnection();
            return true;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public static Order findOrderById(int searchId){
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM orders WHERE orderid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchId);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Date orderDate = new Date(1L);
            double amount = -1;
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                orderDate = resultSet.getDate("orderdate");
                amount = resultSet.getDouble("amount");
            }

            Order _tmp = new Order(userId, amount);
            _tmp.setOrderId(orderId);
            _tmp.setDateTime(orderDate);
            Database.closeConnection();
            return _tmp;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

        return new Order(-1, -1);
    }

}