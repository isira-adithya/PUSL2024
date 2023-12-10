package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class Comment {
    private int commentId = -1;
    private int userId;
    private int productId;
    private String content;

    public Comment(int userId, int productId, String content){
        this.userId = userId;
        this.productId = productId;
        this.content = content;
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

    private void setCommentId(int commentId){
        this.commentId = commentId;
    }

    public void saveComment(){
        if ((this.userId != -1) && (this.productId != -1) && (!content.isEmpty())){
            try {
                Connection dbconn = Database.connect();
                String query = "INSERT INTO Comments (userid, productid, content) VALUES (?, ?, ?)";
                PreparedStatement sqlStatement = dbconn.prepareStatement(query);
                sqlStatement.setInt(1, this.userId);
                sqlStatement.setInt(2, this.productId);
                sqlStatement.setString(3, this.content);
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
                Comment _tmp = new Comment(_userId, _productId, _content);
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
        Comment _tmp = new Comment(-1, -1, "NULL");

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
                _tmp = new Comment(_userId, _productId, _content);
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
}
