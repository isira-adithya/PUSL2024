package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import javax.xml.crypto.Data;
import java.sql.*;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Analytics {
    int days = 7;
    long milliseconds;
    Connection dbconn;
    List<Order> orders;
    public Analytics(int days){
        this.days = days;
        milliseconds = (1000L * 60L * 60L * 24L) * (long) this.days;
        try {
            dbconn = Database.connect();

            // Finding the correct timestamp
            long today = Date.valueOf(LocalDate.now()).getTime();
            Timestamp afterTimestamp = new Timestamp( today - this.milliseconds );

            // Getting orders
            System.out.println("Getting orders after " + afterTimestamp.toString());
            this.orders = Order.findOrdersAfterTimestamp(afterTimestamp);

        } catch (SQLException err){
            err.printStackTrace();
        }
    }

    public Map<String, Double> getSalesByProduct(){
        Map<String, Double> results = new HashMap<String, Double>();

        for (int i = 0; i < orders.size(); i++){
            Order order = orders.get(i);
            if (order.getOrderStatus().equalsIgnoreCase("COMPLETED")){
                for (int n = 0; n < order.getOrderDetails().size(); n++){
                    Product product = order.getOrderDetails().get(n).getProduct();
                    int quantity = order.getOrderDetails().get(n).getQuantity();
                    double individualPrice = (order.getOrderDetails().get(n).getSubTotal() / quantity);
                    double totalOrderPrice = individualPrice * quantity;
                    if (results.containsKey(product.getName())){
                        double currentVal = results.get(product.getName());
                        results.put(product.getName(), currentVal + totalOrderPrice);
                    } else {
                        results.put(product.getName(), totalOrderPrice);
                    }
                }
            }
        }

        return results;
    }

    public Map<String, Integer> getQuantitySoldByProduct(){
        Map<String, Integer> results = new HashMap<String, Integer>();

        for (int i = 0; i < orders.size(); i++){
            Order order = orders.get(i);
            if (order.getOrderStatus().equalsIgnoreCase("COMPLETED")){
                for (int n = 0; n < order.getOrderDetails().size(); n++){
                    Product product = order.getOrderDetails().get(n).getProduct();
                    int quantity = order.getOrderDetails().get(n).getQuantity();
                    if (results.containsKey(product.getName())){
                        int currentVal = results.get(product.getName());
                        results.put(product.getName(), currentVal + quantity);
                    } else {
                        results.put(product.getName(), quantity);
                    }
                }
            }
        }

        return results;
    }

    public static double getAverageRatingOfAProduct(int productId){
        double rating = -1;
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "SELECT AVG(starcount) AS averageRating from Comments WHERE productid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, productId);
            ResultSet resultSet = sqlStatement.executeQuery();
            while(resultSet.next()){
                rating = resultSet.getDouble("averageRating");
            }
            Database.closeConnection();
        } catch (SQLException err){
            err.printStackTrace();
        }

        return rating;
    }
}
