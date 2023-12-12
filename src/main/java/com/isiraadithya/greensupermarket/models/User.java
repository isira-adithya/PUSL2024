/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.isiraadithya.greensupermarket.models;

import java.security.SecureRandom;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import com.isiraadithya.greensupermarket.helpers.Database;

/**
 *
 * @author @isira_adithya
 */
public class User {
    private int userId = 0;
    private String email;
    private String password;
    private String role;
    private String firstname;
    private String lastname;
    private String phone;
    private String street_address;
    private String city;
    private String state;
    private String country;
    private String postalcode;
    private String passwordResetToken;

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
        passwordResetToken = "NULL";
    }

    public int getUserId(){
        return userId;
    }

    public String getRole() {
        return role;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getPhone() {
        return phone;
    }

    public String getStreetAddress() {
        return street_address;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getCountry() {
        return country;
    }

    public String getPostalcode() {
        return postalcode;
    }

    public String getPasswordResetToken() {
        return passwordResetToken;
    }

    public String getFullName() {
        return this.firstname + " " + this.lastname;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setStreetAddress(String street_address) {
        this.street_address = street_address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public void setPostalcode(String postalcode) {
        this.postalcode = postalcode;
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

    private void setPasswordResetToken(String token){
        passwordResetToken = token;
    }

    public void generatePasswordResetToken(){
        SecureRandom secureRandom = new SecureRandom();
        byte[] randomBytes = new byte[32];
        secureRandom.nextBytes(randomBytes);
        String _tmpToken = Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes).substring(0, 32);
        passwordResetToken = _tmpToken;
        this.updateUser();
    }

    public void sendPasswordResetEmail(){
        String passwordResetLink = "http://localhost:9090/resetpassword.jsp?token=" + passwordResetToken;
        String emailBody = "Hello " + this.getFullName() + ",<br>Visit <a href=\"" + passwordResetLink + "\">" + passwordResetLink + "</a> to reset your password.<br><br>GreenSuperMarket - <a href=\"https://www.greensupermarket.live/\">https://www.greensupermarket.live/</a>";
        Email passwordResetEmail = new Email(this.email, "Reset Your Password - GreenSuperMarket", emailBody);
        passwordResetEmail.send();
    }

    public boolean checkPasswordResetToken(String token){
        return (token.equals(passwordResetToken));
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
                String query = "INSERT INTO Users (email, password, firstname, lastname, phone, street_address, city, state, country, postalcode, role, passwordresettoken) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
                sqlStatement.setString(12, passwordResetToken);
                sqlStatement.execute();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
        }
    }

    public void updateUser(){
        try {
            Connection dbconn = Database.connect();
            String query = "UPDATE Users SET firstname=?, lastname=?, phone=?, street_address=?, city=?, state=?, country=?, postalcode=?, password=?, passwordresettoken=? WHERE email=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, firstname);
            sqlStatement.setString(2, lastname);
            sqlStatement.setString(3, phone);
            sqlStatement.setString(4, street_address);
            sqlStatement.setString(5, city);
            sqlStatement.setString(6, state);
            sqlStatement.setString(7, country);
            sqlStatement.setString(8, postalcode);
            sqlStatement.setString(9, password);
            sqlStatement.setString(10, passwordResetToken);
            sqlStatement.setString(11, email);
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
    
    public static List<User> getUsers(){
        try {
            List<User> users = new ArrayList<User>();
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
            String _prt = "NULL";

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
                _prt = resultSet.getString("passwordresettoken");

                User _tmp = new User(_email, _fname, _lname, _phone, _street_address, _city, _state, _country, _postalcode, _role);
                _tmp.setPasswordHash(_passwordHash);
                _tmp.setUserId(_userId);
                _tmp.setPasswordResetToken(_prt);
                users.add(_tmp);
            }
            Database.closeConnection();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new ArrayList<User>();
    }

    public static User findUserByEmail(String searchQueryEmail) {
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
            String _prt = "NULL";



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
                _prt = resultSet.getString("passwordresettoken");
            }

            User _tmp = new User(_email, _fname, _lname, _phone, _street_address, _city, _state, _country, _postalcode, _role);
            _tmp.setPasswordHash(_passwordHash);
            _tmp.setPasswordResetToken(_prt);
            _tmp.setUserId(_userId);
            return _tmp;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Database.closeConnection();
        return new User("NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "USER");
    }

    public static User findUserById(int userId) {
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Users WHERE userid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, userId);
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
            String _prt = "NULL";



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
                _prt = resultSet.getString("passwordresettoken");
            }

            User _tmp = new User(_email, _fname, _lname, _phone, _street_address, _city, _state, _country, _postalcode, _role);
            _tmp.setPasswordHash(_passwordHash);
            _tmp.setPasswordResetToken(_prt);
            _tmp.setUserId(_userId);
            return _tmp;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Database.closeConnection();
        return new User("NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "NULL", "USER");
    }

    public static boolean resetPassword(String email, String token, String newPassword){

//      DO NOT TOUCH THIS PART
//      This check is mandatory,if not this could be exploitable
        if (token.equals("NULL")){
            return false;
        }

        User userObj = findUserByEmail(email);
        if (userObj.getUserId() != -1){
            if (userObj.checkPasswordResetToken(token)){
                userObj.setPassword(newPassword);
                userObj.setPasswordResetToken("NULL");
                userObj.updateUser();
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }

    }
}
