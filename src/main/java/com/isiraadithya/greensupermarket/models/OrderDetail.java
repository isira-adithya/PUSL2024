package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Or;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public OrderDetail(int orderId, int productId, int quantity, double subTotal){
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.subTotal = subTotal;
    }

    public boolean saveOrderDetail(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO orderdetails(orderid, productid, quantity, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, this.orderId);
            sqlStatement.setInt(2, this.productId);
            sqlStatement.setInt(3, this.quantity);
            sqlStatement.setDouble(4, this.subTotal);
            int result = sqlStatement.executeUpdate();
            Database.closeConnection();
            return (result > 0);
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public static List<OrderDetail> findOrderDetailsByOrderId(int searchId){
        List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM orderdetails WHERE orderid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchId);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderDetailId = -1;
            int orderId = -1;
            int productId = -1;
            int quantity = -1;
            double subTotal = -1;
            while(resultSet.next()){
                orderDetailId = resultSet.getInt("orderdetailid");
                orderId = resultSet.getInt("orderid");
                productId = resultSet.getInt("productid");
                quantity = resultSet.getInt("quantity");
                subTotal = resultSet.getDouble("subtotal");

                OrderDetail _tmp = new OrderDetail(orderId,productId, quantity, subTotal);
                _tmp.setOrderDetailId(orderDetailId);
                orderDetails.add(_tmp);
            }
            Database.closeConnection();
            return orderDetails;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return orderDetails;
    }


}
