package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int productId;
    private int quantity;
    private double subTotal;

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getProductId() {
        return productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getSubTotal() {
        return subTotal;
    }

    private void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setSubTotal(double subTotal) {
        this.subTotal = subTotal;
    }

    public OrderDetail(int orderId, int productId, int quantity, double subTotal){
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.subTotal = subTotal;
    }

    public boolean saveOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO orderdetails(orderid, productid, quantity, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);

            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return false;
    }


}
