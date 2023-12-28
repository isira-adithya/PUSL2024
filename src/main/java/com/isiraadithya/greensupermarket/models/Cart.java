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
            // Checking whether the product already exists in the cart
            boolean isFoundInCartAlready = false;
            for(Map.Entry<Product, Integer> entry: this.productQuantities.entrySet()){
                Product _product = entry.getKey();
                int _prev_quantity = entry.getValue();
                if ((_prev_quantity + quantity) > product.getQuantity()){
                    return false;
                }
                if (_product.getProductId() == product.getProductId()){
                    isFoundInCartAlready = true;
                    this.deleteProduct(entry.getKey().getProductId());
                    this.productQuantities.put(entry.getKey(), (_prev_quantity + quantity));
                    this.totalCost += (product.getPrice() * (_prev_quantity + quantity));
                    break;
                }
            };

            if (!isFoundInCartAlready){
                this.productQuantities.put(product, quantity);
                this.totalCost += (product.getPrice() * quantity);
            }

            return true;
        } catch (Exception ex){
            System.out.println("DEBUG: Add product");
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int productId){
        Product product = new Product("NULL", "NULL", "NULL", "NULL", 0, 0, false);
        int quantity = 0;
        for(Map.Entry<Product, Integer> entry: this.productQuantities.entrySet()){
            Product _product = entry.getKey();
            int _quantity = entry.getValue();
            if (_product.getProductId() == productId){
                product = _product;
                quantity = _quantity;
                this.productQuantities.remove(entry.getKey());
                break;
            }
        };
        try {
            this.totalCost -= (product.getPrice() * quantity);
            this.productQuantities.remove(product);
            return true;
        } catch (Exception ex){
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public int getProductQuantity(int productId){
        for(Map.Entry<Product, Integer> entry: this.productQuantities.entrySet()){
            Product _product = entry.getKey();
            int _quantity = entry.getValue();
            if (_product.getProductId() == productId){
                return _quantity;
            }
        };
        return -1;
    }
}
