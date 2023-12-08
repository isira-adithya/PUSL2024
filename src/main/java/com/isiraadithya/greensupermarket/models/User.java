/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.isiraadithya.greensupermarket.models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import org.mindrot.jbcrypt.BCrypt;

import com.isiraadithya.greensupermarket.helpers.Database;

/**
 *
 * @author @isira_adithya
 */
public class User {
    private int userId = 0;
    public String email;
    private String password;
    private String role;
    public String firstname;
    public String lastname;
    public String phone;
    public String street_address;
    public String city;
    public String state;
    public String country;
    public String postalcode;

    // Other variables
    private boolean isPasswordSet = false;

    public User(String _email, String _fname, String _lname, String _phone, String _street_address, String _city, String _state, String _country, String _postalcode, String _role) {
        email = _email;
        firstname = _fname;
        lastname = _lname;
        phone = _phone;
        street_address = _street_address;
        city = _city;
        state = _state;
        country = _country;
        postalcode = _postalcode;
        role = _role;
    }

    public int getUserId(){
        return userId;
    }

    public String getRole() {
        return role;
    }

    private void setUserId(int _uid){
        userId = _uid;
    }

    public void setPassword(String _newpass){
        password = BCrypt.hashpw(_newpass, BCrypt.gensalt());
        isPasswordSet = true;
    }

    public void setPasswordHash(String _pwhash){
        password = _pwhash;
    }

    public boolean checkPassword(String plainTextPassword){
        // TODO: Remove this part once the development is done. @isira_adithya
        boolean isCorrect = false;
        if (plainTextPassword.equals(password)){
            isCorrect = true;
        } else {
            isCorrect = BCrypt.checkpw(plainTextPassword, password);
        }
        return isCorrect;
    }

    public void saveUser(){
        if (isPasswordSet && (userId == 0)) {
            try {
                Connection dbconn = Database.connect();
                String query = "INSERT INTO Users (email, password, firstname, lastname, phone, street_address, city, state, country, postalcode, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement sqlStatement = dbconn.prepareStatement(query);
                sqlStatement.setString(1, email);
                sqlStatement.setString(2, password);
                sqlStatement.setString(3, firstname);
                sqlStatement.setString(4, lastname);
                sqlStatement.setString(5, phone);
                sqlStatement.setString(6, street_address);
                sqlStatement.setString(7, city);
                sqlStatement.setString(8, state);
                sqlStatement.setString(9, country);
                sqlStatement.setString(10, postalcode);
                sqlStatement.setString(11, role);
                sqlStatement.execute();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
    }

    public void updateUser(){
        try {
            Connection dbconn = Database.connect();
            String query = "UPDATE Users SET firstname=?, lastname=?, phone=?, street_address=?, city=?, state=?, country=?, postalcode=? WHERE email=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, firstname);
            sqlStatement.setString(2, lastname);
            sqlStatement.setString(3, phone);
            sqlStatement.setString(4, street_address);
            sqlStatement.setString(5, city);
            sqlStatement.setString(6, state);
            sqlStatement.setString(7, country);
            sqlStatement.setString(8, postalcode);
            sqlStatement.setString(9, email);
            sqlStatement.execute();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void deleteUser(){
        try {
            Connection dbconn = Database.connect();
            String query = "DELETE FROM Users WHERE email=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, email);
            sqlStatement.execute();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    public static int getUserCount(){
        int count = -1;
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT COUNT(userid) AS userCount FROM Users";
            Statement sqlStatement = dbconn.createStatement();
            ResultSet resultSet = sqlStatement.executeQuery(query);
            while(resultSet.next()){
                count = resultSet.getInt("userCount");
            }
            Database.closeConnection();
            return count;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return count;
    }
    
    public static User[] getUsers(){
        int userCount = getUserCount();
        try {
            User[] users = new User[userCount];
            int arrayIndex  = 0;

            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Users";
            Statement sqlStatement = dbconn.createStatement();
            ResultSet resultSet = sqlStatement.executeQuery(query);

            // Fields
            int _userId = -1;
            String _passwordHash = "NULL";
            String _email = "NULL";
            String _fname = "NULL";
            String _lname = "NULL";
            String _phone = "NULL";
            String _street_address = "NULL";
            String _city = "NULL";
            String _state = "NULL";
            String _country = "NULL";
            String _postalcode = "NULL";
            String _role = "NULL";

            while(resultSet.next()){
                _userId = resultSet.getInt("userid");
                _passwordHash = resultSet.getString("password");
                _email = resultSet.getString("email");
                _fname = resultSet.getString("firstname");
                _lname = resultSet.getString("lastname");
                _phone = resultSet.getString("phone");
                _street_address = resultSet.getString("street_address");
                _city = resultSet.getString("city");
                _state = resultSet.getString("state");
                _country = resultSet.getString("country");
                _postalcode = resultSet.getString("postalcode");
                _role = resultSet.getString("role");
                

                User _tmp = new User(_email, _fname, _lname, _phone, _street_address, _city, _state, _country, _postalcode, _role);
                _tmp.setPasswordHash(_passwordHash);
                _tmp.setUserId(_userId);
                users[arrayIndex] = _tmp;
                arrayIndex++;
            }
            Database.closeConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new User[0];
    }

    public static User FindUserByEmail(String searchQueryEmail) {
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Users WHERE email=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, searchQueryEmail);
            ResultSet resultSet = sqlStatement.executeQuery();
            
            // Fields
            int _userId = -1;
            String _passwordHash = "NULL";
            String _email = "NULL";
            String _fname = "NULL";
            String _lname = "NULL";
            String _phone = "NULL";
            String _street_address = "NULL";
            String _city = "NULL";
            String _state = "NULL";
            String _country = "NULL";
            String _postalcode = "NULL";            
            String _role = "NULL";



            // Process the result set
            while (resultSet.next()) {
                _userId = resultSet.getInt("userid");
                _passwordHash = resultSet.getString("password");
                _email = resultSet.getString("email");
                _fname = resultSet.getString("firstname");
                _lname = resultSet.getString("lastname");
                _phone = resultSet.getString("phone");
                _street_address = resultSet.getString("street_address");
                _city = resultSet.getString("city");
                _state = resultSet.getString("state");
                _country = resultSet.getString("country");
                _postalcode = resultSet.getString("postalcode");                
                _role = resultSet.getString("role");

            }

            User _tmp = new User(_email, _fname, _lname, _phone, _street_address, _city, _state, _country, _postalcode, _role);
            _tmp.setPasswordHash(_passwordHash);
            _tmp.setUserId(_userId);
            return _tmp;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Database.closeConnection();
        return new User("NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "USER");
    }
}
