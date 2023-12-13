/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.isiraadithya.greensupermarket.helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author @isira_adithya
 */
public class Database {
    // JDBC URL, username, and password of MariaDB server
    // TODO: Use Environment Variable here; instead of hardcoding credentials.

    // JDBC variables for opening, closing, and managing connection
    private static Connection connection;

    // Method to establish a database connection
    public static Connection connect() throws SQLException {
        String JDBC_URL = System.getenv("JDBC_URL");
        String USERNAME = System.getenv("JDBC_USERNAME");
        String PASSWORD = System.getenv("JDBC_PASSWORD");

        if (connection == null || connection.isClosed()) {
            try {
                // Load MariaDB JDBC driver
                Class.forName("org.mariadb.jdbc.Driver");

                // Load MySQL JDBC in Production Servers
                if (System.getenv("PROD") != null && System.getenv("PROD").equals("TRUE")){
                    Class.forName("com.mysql.jdbc.Driver");
                }

                // Establish a connection
                connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);

            } catch (Exception e) {
                e.printStackTrace();
                throw new SQLException("Failed to connect to the database.");
            }
        }
        return connection;
    }

    // Method to close the database connection
    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
