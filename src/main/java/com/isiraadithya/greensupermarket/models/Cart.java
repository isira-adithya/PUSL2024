package com.isiraadithya.greensupermarket.models;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Product, Integer> productQuantities = new HashMap<>();
    private int userId;
    private double totalCost = 0;

    public Cart(int userid){
        this.userId = userid;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotalCost(){
        return this.totalCost;
    }

    public Map<Product, Integer> getProductQuantities() {
        return productQuantities;
    }

    public boolean isEmpty(){
        return productQuantities.isEmpty();
    }

    public boolean addProduct(Product product, int quantity){
        try {
            this.productQuantities.put(product, quantity);
            this.totalCost += (product.getPrice() * quantity);
            return true;
        } catch (Exception ex){
            System.out.println("DEBUG: Add product");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(Product product){
        try {
            int quantity = this.productQuantities.get(product);
            this.totalCost -= (product.getPrice() * quantity);
            this.productQuantities.remove(product);
            return true;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return false;
    }
}
