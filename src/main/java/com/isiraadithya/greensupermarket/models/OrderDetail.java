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
    private Product product;
    private int quantity;
    private double subTotal;
    private boolean isProductAvailable = true;
    private String productName;

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public Product getProduct() {
        return product;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getSubTotal() {
        return subTotal;
    }
    public String getProductName() {
        if (product.getProductId() == -1){
            return this.productName;
        } else {
            return product.getName();
        }
    }
    public boolean isProductAvailable(){
        return this.isProductAvailable;
    }

    private void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public OrderDetail(int orderId, int productId, String productname, int quantity, double subTotal){
        this.orderId = orderId;
        this.quantity = quantity;
        this.subTotal = subTotal;
        this.productName = productname;

        try {
            product = Product.findProductById(productId);
        } catch (Exception ex){
            product = new Product("NULL", "NULL", "NULL", "NULL", 0, 0, false);
            System.out.println(ex.getMessage());
        }

        if (product.getProductId() == -1){
            this.isProductAvailable = false;
        }
    }

    public boolean saveOrderDetail(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO OrderDetails(orderid, productid, productname, quantity, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, this.orderId);
            sqlStatement.setInt(2, this.product.getProductId());
            sqlStatement.setString(3, this.product.getName());
            sqlStatement.setInt(4, this.quantity);
            sqlStatement.setDouble(5, this.subTotal);
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
            String query = "SELECT * FROM OrderDetails WHERE orderid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchId);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderDetailId = -1;
            int orderId = -1;
            int productId = -1;
            String productName = "NULL";
            int quantity = -1;
            double subTotal = -1;
            while(resultSet.next()){
                orderDetailId = resultSet.getInt("orderdetailid");
                orderId = resultSet.getInt("orderid");
                productId = resultSet.getInt("productid");
                quantity = resultSet.getInt("quantity");
                subTotal = resultSet.getDouble("subtotal");
                productName = resultSet.getString("productname");

                OrderDetail _tmp = new OrderDetail(orderId, productId, productName, quantity, subTotal);
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
