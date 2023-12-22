package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

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
            // DEBUG:
            System.out.println("\nOrder ID: " + order.getOrderId() + " | User ID: " + order.getUserId() + " | Order Amount: " + order.getAmount() + "");
            for (int n = 0; n < order.getOrderDetails().size(); n++){
                Product product = order.getOrderDetails().get(n).getProduct();
                int quantity = order.getOrderDetails().get(n).getQuantity();
                double individualPrice = (order.getOrderDetails().get(n).getSubTotal() / quantity);
                if (results.containsKey(product.getName())){
                    System.out.println("Existing " + product.getName());
                    double currentVal = results.get(product.getName());
                    results.put(product.getName(), currentVal + individualPrice);
                } else {
                    System.out.println("Added " + product.getName());
                    results.put(product.getName(), individualPrice);
                }
            }
        }

        return results;
    }
}