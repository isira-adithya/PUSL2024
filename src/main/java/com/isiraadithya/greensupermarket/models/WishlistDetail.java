package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WishlistDetail {
    private int wishlistDetailId;
    private int wishlistId;
    private int productId;

    // Getters and Setters
    public int getWishlistDetailId() {
        return wishlistDetailId;
    }

    private void setWishlistDetailId(int wishlistDetailId) {
        this.wishlistDetailId = wishlistDetailId;
    }

    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Product getProduct(){
        return Product.findProductById(this.productId);
    }

    // Constructor
    public WishlistDetail(int wishlistId, int productId){
        this.wishlistId = wishlistId;
        this.productId = productId;
    }

    public void saveWishlistDetail(){
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "INSERT INTO WishlistDetails(wishlistid, productid) VALUES (?, ?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, this.wishlistId);
            sqlStatement.setInt(2, this.productId);
            sqlStatement.executeQuery();

            Database.closeConnection();
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public void deleteWishlistDetail(){
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "DELETE FROM WishlistDetails WHERE wishlistid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, this.wishlistId);
            sqlStatement.executeQuery();

            Database.closeConnection();
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public static List<WishlistDetail> findWishlistDetailsByWishlistId(int wishlistId){
        List<WishlistDetail> wishlistDetails = new ArrayList<WishlistDetail>();
        try {
            Connection dbconn = Database.connect();

            String sqlQuery = "SELECT * FROM wishlistdetails WHERE wishlistid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, wishlistId);
            ResultSet resultSet = sqlStatement.executeQuery();

            int _wishlistDetailId = -1;
            int _wishlistId = -1;
            int _productId = -1;

            while(resultSet.next()){
                _wishlistDetailId = resultSet.getInt("wishlistdetailid");
                _wishlistId = resultSet.getInt("wishlistid");
                _productId = resultSet.getInt("productid");

                WishlistDetail _tmp = new WishlistDetail(_wishlistId, _productId);
                _tmp.setWishlistDetailId(_wishlistDetailId);
                wishlistDetails.add(_tmp);
            }

            Database.closeConnection();

            return wishlistDetails;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return wishlistDetails;
    }
}
