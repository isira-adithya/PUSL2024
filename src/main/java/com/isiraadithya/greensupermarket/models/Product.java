package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author @isira_adithya
 */
public class Product {
    private int id = -1;
    private String name;
    private String description;
    private String image;
    private double price;
    private int quantity;

    public Product(String name, String description, String image, double price, int quantity){
        this.name = name;
        this.description = description;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
    }

//    Getters and Setters
    public int getProductId(){
        return this.id;
    }
    public double getPrice() {
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

    public String getImage(){
        if (this.image.isBlank()){
            return "/uploads/images/products/not-found.png";
        } else {
            return "/uploads/images/products/" + this.image;
        }

    }

    public void saveProduct(){
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT ";
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
    }

    private void setProductId(int id){
        this.id = id;
    }

    private static int getProductCount(){
        int productCount = -1;
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT COUNT(productid) as productCount FROM products";
            Statement sqlStatement = dbconn.createStatement();
            ResultSet resultSet = sqlStatement.executeQuery(query);

            while(resultSet.next()){
                productCount = resultSet.getInt("productCount");
            }
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return productCount;
    }

    public static Product[] getProducts(){
        int productCount = Product.getProductCount();
        try {
            Product[] products = new Product[productCount];
            int arrayIndex  = 0;

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

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");

                Product _tmp = new Product(_name, _description, _image, _price, _quantity);
                _tmp.setProductId(_productId);
                products[arrayIndex] = _tmp;
                arrayIndex++;
            }
            Database.closeConnection();
            return products;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new Product[0];
    }

    public static Product[] findProductsByName(String searchQuery){
        int productCount = Product.getProductCount();
        try {
            Product[] products = new Product[productCount];
            int arrayIndex  = 0;

            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Products WHERE name LIKE ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, "%" + searchQuery.replaceAll("%", "") +  "%");
            ResultSet resultSet = sqlStatement.executeQuery(query);

            // Fields
            int _productId = -1;
            int _quantity = 0;
            double _price = 0;
            String _name = "NULL";
            String _description = "NULL";
            String _image = "NULL";

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");

                Product _tmp = new Product(_name, _description, _image, _price, _quantity);
                _tmp.setProductId(_productId);
                products[arrayIndex] = _tmp;
                arrayIndex++;
            }
            Database.closeConnection();
            return products;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return new Product[0];
    }

    public static Product findProductById(int searchId) {
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM products WHERE productid=?";
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

            while(resultSet.next()){
                _productId = resultSet.getInt("productid");
                _quantity = resultSet.getInt("quantity");
                _price = resultSet.getDouble("price");
                _name = resultSet.getString("name");
                _description = resultSet.getString("description");
                _image = resultSet.getString("image");
            }

            Product _tmp = new Product(_name, _description, _image, _price, _quantity);
            _tmp.setProductId(_productId);
            return _tmp;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        Database.closeConnection();
        return new Product("NULL", "NULL", "NULL", 0, 0);
    }
}
