package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.*;

public class WishList {
    private int wishListId = -1;
    private int userId;
    private Timestamp createdAt;

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

    // Constructor

    public WishList(int userId, Timestamp createdAt){
        this.userId = userId;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

    public WishList findWishListByUserId(int userId){
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
            WishList _tmp = new WishList(_userId, _createdAt);
            _tmp.setWishListId(_wishlistId);
            _tmp.setCreatedAt(_createdAt);

            Database.closeConnection();

            return  _tmp;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return new WishList(-1, new Timestamp(1));
    }

    public void saveWishlist(){
        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "INSERT INTO Wishlists(userid, createdAt) VALUES (?, ?, ?)";
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

}
