package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.*;
import java.util.List;

public class WishList {
    private int wishListId = -1;
    private int userId;
    private Timestamp createdAt;
    private List<WishlistDetail> wishlistDetails;

    // Getters and Setters
    public int getWishListId() {
        return wishListId;
    }

    private void setWishListId(int wishListId) {
        this.wishListId = wishListId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Timestamp getCreatedAt() {
        return createdAt;
    }

    private void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    private void setWishlistDetails(List<WishlistDetail> details){
        this.wishlistDetails = details;
    }
    public List<WishlistDetail> getWishlistDetails(){
        return this.wishlistDetails;
    }

    // Constructor

    public WishList(int userId){
        this.userId = userId;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    public static WishList findWishListByUserId(int userId){
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "SELECT * FROM Wishlists WHERE userId=?";
            PreparedStatement statement = dbconn.prepareStatement(sqlQuery);
            statement.setInt(1, userId);

            int _wishlistId = -1;
            int _userId = -1;
            Timestamp _createdAt = new Timestamp(1);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                _wishlistId = resultSet.getInt("wishlistid");
                _userId = resultSet.getInt("userid");
                _createdAt = resultSet.getTimestamp("createdAt");
            }
            WishList _tmp = new WishList(_userId);
            _tmp.setWishListId(_wishlistId);
            _tmp.setCreatedAt(_createdAt);

            // Loading wishlist details
            if (_tmp.userId != -1){
                List<WishlistDetail> details = WishlistDetail.findWishlistDetailsByWishlistId(_wishlistId);
                _tmp.setWishlistDetails(details);
            }

            Database.closeConnection();

            return  _tmp;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return new WishList(-1);
    }

    public void saveWishlist(){
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "INSERT INTO Wishlists(userid, createdAt) VALUES (?, ?)";
            PreparedStatement statement = dbconn.prepareStatement(sqlQuery);
            statement.setInt(1, this.userId);
            statement.setTimestamp(2, this.createdAt);
            statement.execute();

            Database.closeConnection();
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public void deleteWishlist(){
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "DELETE FROM Wishlists WHERE wishlistid=?";
            PreparedStatement statement = dbconn.prepareStatement(sqlQuery);
            statement.setInt(1, this.wishListId);
            statement.execute();

            Database.closeConnection();
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public void addNewProductToWishlist(Product product){
        if (product.getProductId() != -1){
            WishlistDetail wishlistDetail = new WishlistDetail(this.wishListId, product.getProductId());
            wishlistDetail.saveWishlistDetail();
        }
    }

    public void removeProductFromWishlist(Product product){
        if (product.getProductId() != -1){
            WishlistDetail.deleteProductFromWishlist(this.wishListId, product.getProductId());
        }
    }

    public boolean doesProductExist(Product product){
        return WishlistDetail.doesProductExistsInUserWishlist(this.wishListId, product.getProductId());
    }

}
