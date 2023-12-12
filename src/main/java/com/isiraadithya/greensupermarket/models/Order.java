package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Order {
    private int orderId;
    private int userId;
    private Timestamp dateTime;
    private double amount;
    private List<OrderDetail> orderDetails;
    private Cart cartObj; // Required when initializing an object
    private String paymentState;
    private double additionalCharges;


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

    public Timestamp getDateTime() {
        return dateTime;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public double getAmount() {
        this.amount = Math.round(this.amount * Math.pow(10, 2)) / Math.pow(10, 2);
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public List<OrderDetail> getOrderDetails(){
        return this.orderDetails;
    }

    private void setOrderDetails(List<OrderDetail> orderDetail){
        this.orderDetails = orderDetail;
    }

    public String getPaymentState() {
        return paymentState;
    }

    public void setPaymentState(String state){
        if (state.equals("PENDING") || state.equals("COMPLETED")){
            this.paymentState = state;
        } else {
            this.paymentState = "PENDING";
        }
    }

    public double getAdditionalCharges() {
        return additionalCharges;
    }

    public void setAdditionalCharges(double additionalCharges) {
        this.additionalCharges = additionalCharges;
    }

    public Order(Cart cartObj){
        this.dateTime = new Timestamp(System.currentTimeMillis());
        this.amount = cartObj.getTotalCost();
        this.userId = cartObj.getUserId();
        this.cartObj = cartObj;
        this.setPaymentState("PENDING");
        if (this.saveOrder()){
            this.saveOrderDetails();
        }
    }

    // This specific constructor would be used to initialize the Order obj in find*() functions.
    private Order(int userId, double amount){
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
            String query = "INSERT INTO Orders(userid, orderdate, amount, additionalCharges, paymentstate) VALUES (?,?,?,0,?)";
            String[] generatedColumns = {"orderid"};
            PreparedStatement sqlStatement = dbconn.prepareStatement(query, generatedColumns);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setTimestamp(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            sqlStatement.setString(4, this.paymentState);
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

    public boolean updateOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "UPDATE Orders SET userid=?, orderdate=?, amount=?, paymentstate=?, additionalCharges=? WHERE orderid = ?";
            String[] generatedColumns = {"orderid"};
            PreparedStatement sqlStatement = dbconn.prepareStatement(query, generatedColumns);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setTimestamp(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            sqlStatement.setString(4, this.paymentState);
            sqlStatement.setDouble(5, this.additionalCharges);
            sqlStatement.setInt(6, this.orderId);
            sqlStatement.execute();
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
            Timestamp orderDate = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String paymentState = "PENDING";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                orderDate = resultSet.getTimestamp("orderdate");
                amount = resultSet.getDouble("amount");
                additionalCharges = resultSet.getDouble("additionalCharges");
                paymentState = resultSet.getString("paymentstate");
            }

            Order _tmp = new Order(userId, amount);
            _tmp.setOrderId(orderId);
            _tmp.setDateTime(orderDate);
            _tmp.setPaymentState(paymentState);
            _tmp.setAdditionalCharges(additionalCharges);
            List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
            _tmp.setOrderDetails(_tmp2);
            Database.closeConnection();
            return _tmp;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

        return new Order(-1, -1);
    }

    public static List<Order> findOrdersByUserId(int searchUid){
        List<Order> orderList = new ArrayList<Order>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM orders WHERE userid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchUid);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp orderDate = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String paymentState = "PENDING";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                orderDate = resultSet.getTimestamp("orderdate");
                amount = resultSet.getDouble("amount");
                paymentState = resultSet.getString("paymentstate");
                additionalCharges = resultSet.getDouble("additionalCharges");

                Order _tmp = new Order(userId, amount);
                _tmp.setOrderId(orderId);
                _tmp.setDateTime(orderDate);
                _tmp.setPaymentState(paymentState);
                _tmp.setAdditionalCharges(additionalCharges);
                List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
                _tmp.setOrderDetails(_tmp2);
                orderList.add(_tmp);
            }


            Database.closeConnection();
            return orderList;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

        return orderList;
    }

}
