package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;
import java.sql.Connection;
import java.util.Map;

public class Analytics {
    int days = 7;
    int milliseconds;
    Connection dbconn;
    public Analytics(int days){
        this.days = days;
        milliseconds = (1000 * 60 * 60 * 24) * this.days;
        dbconn = Database.connect();
    }

    public Map<String, Double> getSalesByProduct(){

    }
}
