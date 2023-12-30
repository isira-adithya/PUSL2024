package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import javax.xml.transform.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Comment {
    private int commentId = -1;
    private int userId;
    private int productId;
    private String content;
    private int starCount;

    public Comment(int userId, int productId, String content, int starCount){
        this.userId = userId;
        this.productId = productId;
        this.content = content;
        this.starCount = starCount;
    }

//    Getters and Setters


    public int getCommentId() {
        return this.commentId;
    }
    public User getUser() {
        return User.findUserById(this.userId);
    }
    public int getProductId() {
        return this.productId;
    }
    public String getContent(){
        return this.content;
    }
    public int getStarCount() {
        return this.starCount;
    }
    private void setCommentId(int commentId){
        this.commentId = commentId;
    }

    public void saveComment(){
        if ((this.userId != -1) && (this.productId != -1) && (!content.isEmpty())){
            try {
                Connection dbconn = Database.connect();
                String query = "INSERT INTO Comments (userid, productid, content, starcount) VALUES (?, ?, ?, ?)";
                PreparedStatement sqlStatement = dbconn.prepareStatement(query);
                sqlStatement.setInt(1, this.userId);
                sqlStatement.setInt(2, this.productId);
                sqlStatement.setString(3, this.content);
                sqlStatement.setInt(4, this.starCount);
                sqlStatement.execute();
                Database.closeConnection();
            } catch (Exception ex){
                System.out.println(ex.getMessage());
            }
        }
    }

    public static List<Comment> findCommentsByProductId(int productId){
        int _commentId = -1;
        int _userId = -1;
        int _productId = -1;
        int _starCount = -1;
        String _content = "NULL";
        List<Comment> comments = new ArrayList<Comment>();

        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Comments WHERE productid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, productId);

            ResultSet resultSet = sqlStatement.executeQuery();
            while(resultSet.next()){
                _commentId = resultSet.getInt("commentid");
                _userId = resultSet.getInt("userid");
                _productId = resultSet.getInt("productid");
                _content = resultSet.getString("content");
                _starCount = resultSet.getInt("starcount");
                Comment _tmp = new Comment(_userId, _productId, _content, _starCount);
                _tmp.setCommentId(_commentId);
                comments.add(_tmp);
            }
            Database.closeConnection();
            return comments;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

        return new ArrayList<Comment>();
    }

    public static Comment findCommentById(int commentId){
        int _commentId = -1;
        int _userId = -1;
        int _productId = -1;
        String _content = "NULL";
        int _starCount = -1;
        Comment _tmp = new Comment(-1, -1, "NULL", -1);

        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Comments WHERE commentid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, commentId);

            ResultSet resultSet = sqlStatement.executeQuery();
            while(resultSet.next()){
                _commentId = resultSet.getInt("commentid");
                _userId = resultSet.getInt("userid");
                _productId = resultSet.getInt("productid");
                _content = resultSet.getString("content");
                _starCount = resultSet.getInt("starcount");
                _tmp = new Comment(_userId, _productId, _content, _starCount);
                _tmp.setCommentId(_commentId);
            }
            Database.closeConnection();
            return _tmp;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

        return _tmp;
    }

    public static void deleteComment(int commentId){

        try {
            Connection dbconn = Database.connect();
            String query = "DELETE FROM Comments WHERE commentid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, commentId);
            sqlStatement.execute();
            Database.closeConnection();
            return;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }

    }

    public static int getCommentCountByProductId(int productId){
        int count = -1;

        try {
            Connection dbconn = Database.connect();
            String sqlQuery = "SELECT COUNT(commentid) AS commentCount FROM Comments WHERE productid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(sqlQuery);
            sqlStatement.setInt(1, productId);
            ResultSet resultSet = sqlStatement.executeQuery();
            while(resultSet.next()){
                count = resultSet.getInt("commentCount");
            }
            Database.closeConnection();
        } catch (SQLException err){
            err.printStackTrace();
        }

        return count;
    }
}
