package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author @isira_adithya
 */
public class Product {
    private int id = -1;
    private String name;
    private String description;
    private String short_description;
    private String image;
    private double price;
    private int quantity;
    private boolean visibility;
    private Timestamp createdAt;

    public Product(String name, String short_description, String description, String image, double price, int quantity, boolean visibility){
        this.name = name;
        this.short_description = short_description;
        this.description = description;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.visibility = visibility;
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }

//    Getters and Setters
    public int getProductId(){
        return this.id;
    }
    public double getPrice() {
        this.price = Math.round(this.price * Math.pow(10, 2)) / Math.pow(10, 2);
        return this.price;
    }
    public int getQuantity() {
        return this.quantity;
    }

    public String getName(){
        return this.name;
    }
    public String getDescription(){
        return this.description;
    }
    public String getShortDescription(){
        return this.short_description;
    }
    public boolean getVisibility(){return this.visibility;}
    public String getImage(){
        if (this.image.isBlank()){
            return "/uploads/images/products/not-found.png";
        } else {
            return "/uploads/images/products/" + this.image;
        }

    }

    private void setProductId(int id){
        this.id = id;
    }

    public void setProductQuantity(int quantity){
        this.quantity = quantity;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public void setShortDescription(String sdescription) {
        this.short_description = sdescription;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    private void setCreatedAt(Timestamp _tmsp){
        this.createdAt = _tmsp;
    }
    public void setVisibility(boolean visibility){this.visibility = visibility;}

    public void saveProduct(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO Products(name, price, quantity, description, image, short_description, visibility, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = dbconn.prepareStatement(query);
            preparedStatement.setString(1, this.name);
            preparedStatement.setDouble(2, this.price);
            preparedStatement.setInt(3, this.quantity);
            preparedStatement.setString(4, this.description);
            preparedStatement.setString(5, this.image);
            preparedStatement.setString(6, this.short_description);
            preparedStatement.setBoolean(7, this.visibility);
            preparedStatement.setTimestamp(8, this.createdAt);
            preparedStatement.execute();
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    public void updateProduct(){
        try {
            Connection dbconn = Database.connect();
            String query = "UPDATE Products SET name=?, price=?, quantity=?, description=?, image=?, short_description=?, visibility=? WHERE productid = ?";
            PreparedStatement preparedStatement = dbconn.prepareStatement(query);
            preparedStatement.setString(1, this.name);
            preparedStatement.setDouble(2, this.price);
            preparedStatement.setInt(3, this.quantity);
            preparedStatement.setString(4, this.description);
            preparedStatement.setString(5, this.image);
            preparedStatement.setString(6, this.short_description);
            preparedStatement.setBoolean(7, this.visibility);
            preparedStatement.setInt(8, this.id);
            preparedStatement.execute();
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    public void deleteProduct(){
        try {
            Connection dbconn = Database.connect();
            String query = "DELETE FROM Products WHERE productid = ?";
            PreparedStatement preparedStatement = dbconn.prepareStatement(query);
            preparedStatement.setInt(1, this.id);
            preparedStatement.execute();
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    public static List<Product> getProducts(){
        try {
            List<Product> products = new ArrayList<Product>();

            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Products";
            Statement sqlStatement = dbconn.createStatement();
            ResultSet resultSet = sqlStatement.executeQuery(query);

            // Fields
            int _productId = -1;
            int _quantity = 0;
            double _price = 0;
            String _name = "NULL";
            String _description = "NULL";
            String _image = "NULL";
            String _short_description = "NULL";
            Boolean _visibility = false;
            Timestamp _createdAt = new Timestamp(1);

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");
                _short_description = resultSet.getString("short_description");
                _visibility = resultSet.getBoolean("visibility");
                _createdAt = resultSet.getTimestamp("createdAt");

                Product _tmp = new Product(_name, _short_description, _description, _image, _price, _quantity, _visibility);
                _tmp.setCreatedAt(_createdAt);
                _tmp.setProductId(_productId);
                products.add(_tmp);
            }
            Database.closeConnection();
            return products;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new ArrayList<Product>();
    }

    public static List<Product> findProductsByName(String searchQuery){
        try {
            List<Product> products = new ArrayList<Product>();

            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Products WHERE name LIKE ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, "%" + searchQuery.replaceAll("%", "") +  "%");
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int _productId = -1;
            int _quantity = 0;
            double _price = 0;
            String _name = "NULL";
            String _description = "NULL";
            String _image = "NULL";
            String _short_description = "NULL";
            Boolean _visibility = false;
            Timestamp _createdAt = new Timestamp(1);

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");
                _short_description = resultSet.getString("short_description");
                _visibility = resultSet.getBoolean("visibility");
                _createdAt = resultSet.getTimestamp("createdAt");

                Product _tmp = new Product(_name, _short_description, _description, _image, _price, _quantity, _visibility);
                _tmp.setCreatedAt(_createdAt);
                _tmp.setProductId(_productId);
                products.add(_tmp);
            }
            Database.closeConnection();
            return products;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new ArrayList<Product>();
    }

    public static Product findProductById(int searchId) {
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Products WHERE productid=?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchId);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int _productId = -1;
            int _quantity = 0;
            double _price = 0;
            String _name = "NULL";
            String _description = "NULL";
            String _image = "NULL";
            String _short_description = "NULL";
            Boolean _visibility = false;
            Timestamp _createdAt = new Timestamp(1);

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");
                _short_description = resultSet.getString("short_description");
                _visibility = resultSet.getBoolean("visibility");
                _createdAt = resultSet.getTimestamp("createdAt");
            }

            Product _tmp = new Product(_name, _short_description, _description, _image, _price, _quantity, _visibility);
            _tmp.setCreatedAt(_createdAt);
            _tmp.setProductId(_productId);
            return _tmp;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Database.closeConnection();
        return new Product("NULL", "NULL", "NULL", "NULL", 0, 0, false);
    }
}
