package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Analytics {
    int days = 7;
    int milliseconds;
    Connection dbconn;
    public Analytics(int days){
        this.days = days;
        milliseconds = (1000 * 60 * 60 * 24) * this.days;
        try {
            dbconn = Database.connect();
        } catch (SQLException err){
            err.printStackTrace();
        }
    }

    public Map<String, Double> getSalesByProduct(){
        Map<String, Double> results = new HashMap<String, Double>();
        return results;
    }
}
