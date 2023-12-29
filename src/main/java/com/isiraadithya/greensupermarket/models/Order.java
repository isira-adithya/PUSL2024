package com.isiraadithya.greensupermarket.models;

import com.isiraadithya.greensupermarket.helpers.Database;
import com.isiraadithya.greensupermarket.helpers.PaymentServices;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Order {
    private int orderId;
    private int userId;
    private Timestamp dateTime;
    private double amount;
    private List<OrderDetail> orderDetails;
    private Cart cartObj; // Required when initializing an object
    private String orderStatus;
    private String paymentStatus;
    private String deliveryStatus;
    private double additionalCharges;


    // Getter and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getDateTime() {
        return dateTime;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public double getAmount() {
        this.amount = Math.round(this.amount * Math.pow(10, 2)) / Math.pow(10, 2);
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public List<OrderDetail> getOrderDetails(){
        return this.orderDetails;
    }

    private void setOrderDetails(List<OrderDetail> orderDetail){
        this.orderDetails = orderDetail;
    }

    public String getOrderStatus() {
        boolean isCancelled = (System.currentTimeMillis() - this.dateTime.getTime()) > (1000*60*60*24);
        if (isCancelled && (!this.orderStatus.equals("COMPLETED"))){
            if (!this.orderStatus.equals("CANCELLED")){
                this.setOrderStatus("CANCELLED");
                this.updateOrder();
            }
        }
        return orderStatus;
    }

    public void setOrderStatus(String state){
        if (state.equals("PENDING") || state.equals("COMPLETED") || state.equals("CANCELLED")){
            this.orderStatus = state;
        } else {
            this.orderStatus = "PENDING";
        }
    }

    public double getAdditionalCharges() {
        return additionalCharges;
    }

    public void setAdditionalCharges(double additionalCharges) {
        this.additionalCharges = additionalCharges;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        if (paymentStatus.equals("PENDING") || paymentStatus.equals("COMPLETED") || paymentStatus.equals("ERROR")){
            this.paymentStatus = paymentStatus;
        } else {
            this.paymentStatus = "PENDING";
        }
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        if (deliveryStatus.equals("N/A") || deliveryStatus.equals("PENDING") || deliveryStatus.equals("COMPLETED") || deliveryStatus.equals("CANCELLED")){
            this.deliveryStatus = deliveryStatus;
        } else {
            this.deliveryStatus = "PENDING";
        }
    }

    public Order(Cart cartObj){
        this.dateTime = new Timestamp(System.currentTimeMillis());
        this.amount = cartObj.getTotalCost();
        this.userId = cartObj.getUserId();
        this.cartObj = cartObj;
        this.setOrderStatus("PENDING");
        this.setPaymentStatus("PENDING");
        this.setDeliveryStatus("N/A");
        if (this.saveOrder()){
            this.saveOrderDetails();
        }
    }

    // This specific constructor would be used to initialize the Order obj in find*() functions.
    private Order(int userId, double amount){
        this.amount = amount;
        this.userId = userId;
    }

    private void saveOrderDetails(){
        for(Map.Entry<Product, Integer> entry: this.cartObj.getProductQuantities().entrySet()){
            Product _product = entry.getKey();
            int _quantity = entry.getValue();
            OrderDetail orderDetail = new OrderDetail(this.orderId, _product.getProductId(), _product.getName(), _quantity, (_product.getPrice() * _quantity));
            orderDetail.saveOrderDetail();
        };
    }

    public boolean saveOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "INSERT INTO Orders(userid, createdAt, amount, additionalCharges, status, delivery_status, payment_status) VALUES (?,?,?,0,?,?,?)";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setTimestamp(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            sqlStatement.setString(4, this.orderStatus);
            sqlStatement.setString(5, this.deliveryStatus);
            sqlStatement.setString(6, this.paymentStatus);
            int affectedRows = sqlStatement.executeUpdate();

            // Taken from: https://stackoverflow.com/a/1915197/11670864, https://stackoverflow.com/a/40988131/11670864
            if (affectedRows > 0){
                try {
                    ResultSet generatedKeys = sqlStatement.getGeneratedKeys();
                    if (generatedKeys.next()){
                        this.orderId = generatedKeys.getInt("insert_id");
                        return true;
                    } else {
                        return false;
                    }
                } catch (Exception ex){
                    System.out.println(ex.getMessage());
                    return false;
                }
            }
            Database.closeConnection();
            return true;
        } catch (Exception ex){
            System.out.println("ERR:saveOrders(): " +ex.getMessage());
            return false;
        }
    }

    public boolean updateOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "UPDATE Orders SET userid=?, createdAt=?, amount=?, status=?, additionalCharges=?, delivery_status=?, payment_status=? WHERE orderid = ?";
            String[] generatedColumns = {"orderid"};
            PreparedStatement sqlStatement = dbconn.prepareStatement(query, generatedColumns);
            sqlStatement.setInt(1, this.userId);
            sqlStatement.setTimestamp(2, this.dateTime);
            sqlStatement.setDouble(3, this.amount);
            sqlStatement.setString(4, this.orderStatus);
            sqlStatement.setDouble(5, this.additionalCharges);
            sqlStatement.setString(6, this.deliveryStatus);
            sqlStatement.setString(7, this.paymentStatus);
            sqlStatement.setInt(8, this.orderId);
            sqlStatement.execute();
            Database.closeConnection();
            return true;
        } catch (Exception ex){
            System.out.println("ERR:updateOrder(): " + ex.getMessage());
            return false;
        }
    }

    public void deleteOrder(){
        try {
            Connection dbconn = Database.connect();
            String query = "DELETE FROM Orders WHERE orderid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, this.orderId);
            sqlStatement.execute();
            Database.closeConnection();
        } catch (Exception ex){
            System.out.println("ERR:updateOrder(): " + ex.getMessage());
        }
    }

    public static Order findOrderById(int searchId){
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Orders WHERE orderid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchId);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp createdAt = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String orderStatus = "PENDING";
            String paymentStatus = "ERROR";
            String deliveryStatus = "N/A";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                createdAt = resultSet.getTimestamp("createdAt");
                amount = resultSet.getDouble("amount");
                additionalCharges = resultSet.getDouble("additionalCharges");
                orderStatus = resultSet.getString("status");
                paymentStatus = resultSet.getString("payment_status");
                deliveryStatus = resultSet.getString("delivery_status");
            }

            Order _tmp = new Order(userId, amount);
            _tmp.setOrderId(orderId);
            _tmp.setDateTime(createdAt);
            _tmp.setOrderStatus(orderStatus);
            _tmp.setPaymentStatus(paymentStatus);
            _tmp.setDeliveryStatus(deliveryStatus);
            _tmp.setAdditionalCharges(additionalCharges);
            List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
            _tmp.setOrderDetails(_tmp2);
            Database.closeConnection();
            return _tmp;
        } catch (Exception ex){
            System.out.println("ERR:findOrderById(): " +ex.getMessage());
        }

        return new Order(-1, -1);
    }

    public static List<Order> findOrdersByUserId(int searchUid){
        List<Order> orderList = new ArrayList<Order>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Orders WHERE userid = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setInt(1, searchUid);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp createdAt = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String orderStatus = "PENDING";
            String paymentStatus = "ERROR";
            String deliveryStatus = "N/A";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                createdAt = resultSet.getTimestamp("createdAt");
                amount = resultSet.getDouble("amount");
                orderStatus = resultSet.getString("status");
                additionalCharges = resultSet.getDouble("additionalCharges");
                paymentStatus = resultSet.getString("payment_status");
                deliveryStatus = resultSet.getString("delivery_status");

                Order _tmp = new Order(userId, amount);
                _tmp.setOrderId(orderId);
                _tmp.setDateTime(createdAt);
                _tmp.setOrderStatus(orderStatus);
                _tmp.setPaymentStatus(paymentStatus);
                _tmp.setDeliveryStatus(deliveryStatus);
                _tmp.setAdditionalCharges(additionalCharges);
                List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
                _tmp.setOrderDetails(_tmp2);
                orderList.add(_tmp);
            }


            Database.closeConnection();
            return orderList;
        } catch (Exception ex){
            System.out.println("ERR:findOrdersByUserId(): " +ex.getMessage());
        }

        return orderList;
    }

    public static List<Order> findOrdersByStatus(String searchOrderStatus){
        List<Order> orderList = new ArrayList<Order>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Orders WHERE status = ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setString(1, searchOrderStatus);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp createdAt = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String orderStatus = "CANCELLED";
            String paymentStatus = "ERROR";
            String deliveryStatus = "N/A";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                createdAt = resultSet.getTimestamp("createdAt");
                amount = resultSet.getDouble("amount");
                orderStatus = resultSet.getString("status");
                paymentStatus = resultSet.getString("payment_status");
                deliveryStatus = resultSet.getString("delivery_status");
                additionalCharges = resultSet.getDouble("additionalCharges");

                Order _tmp = new Order(userId, amount);
                _tmp.setOrderId(orderId);
                _tmp.setDateTime(createdAt);
                _tmp.setOrderStatus(orderStatus);
                _tmp.setPaymentStatus(paymentStatus);
                _tmp.setDeliveryStatus(deliveryStatus);
                _tmp.setAdditionalCharges(additionalCharges);
                List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
                _tmp.setOrderDetails(_tmp2);
                orderList.add(_tmp);
            }


            Database.closeConnection();
            return orderList;
        } catch (Exception ex){
            System.out.println("ERR:findOrdersByUserId(): " +ex.getMessage());
        }

        return orderList;
    }

    public static List<Order> findOrdersAfterTimestamp(Timestamp timestamp){
        List<Order> orderList = new ArrayList<Order>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Orders WHERE createdAt > ?";
            PreparedStatement sqlStatement = dbconn.prepareStatement(query);
            sqlStatement.setTimestamp(1, timestamp);
            ResultSet resultSet = sqlStatement.executeQuery();

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp createdAt = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String orderStatus = "PENDING";
            String paymentStatus = "ERROR";
            String deliveryStatus = "N/A";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                createdAt = resultSet.getTimestamp("createdAt");
                amount = resultSet.getDouble("amount");
                orderStatus = resultSet.getString("status");
                additionalCharges = resultSet.getDouble("additionalCharges");
                paymentStatus = resultSet.getString("payment_status");
                deliveryStatus = resultSet.getString("delivery_status");

                Order _tmp = new Order(userId, amount);
                _tmp.setOrderId(orderId);
                _tmp.setDateTime(createdAt);
                _tmp.setOrderStatus(orderStatus);
                _tmp.setPaymentStatus(paymentStatus);
                _tmp.setDeliveryStatus(deliveryStatus);
                _tmp.setAdditionalCharges(additionalCharges);
                List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
                _tmp.setOrderDetails(_tmp2);
                orderList.add(_tmp);
            }


            Database.closeConnection();
            return orderList;
        } catch (Exception ex){
            System.out.println("ERR:findOrdersByUserId(): " +ex.getMessage());
        }

        return orderList;
    }

    public static List<Order> getOrders(){
        List<Order> orderList = new ArrayList<Order>();
        try {
            Connection dbconn = Database.connect();
            String query = "SELECT * FROM Orders";
            Statement sqlStatement = dbconn.createStatement();
            ResultSet resultSet = sqlStatement.executeQuery(query);

            // Fields
            int orderId = -1;
            int userId = -1;
            Timestamp createdAt = new Timestamp(1L);
            double amount = -1;
            double additionalCharges = 0;
            String orderStatus = "PENDING";
            String paymentStatus = "ERROR";
            String deliveryStatus = "N/A";
            while(resultSet.next()){
                orderId = resultSet.getInt("orderid");
                userId = resultSet.getInt("userid");
                createdAt = resultSet.getTimestamp("createdAt");
                amount = resultSet.getDouble("amount");
                orderStatus = resultSet.getString("status");
                additionalCharges = resultSet.getDouble("additionalCharges");
                paymentStatus = resultSet.getString("payment_status");
                deliveryStatus = resultSet.getString("delivery_status");

                Order _tmp = new Order(userId, amount);
                _tmp.setOrderId(orderId);
                _tmp.setDateTime(createdAt);
                _tmp.setOrderStatus(orderStatus);
                _tmp.setPaymentStatus(paymentStatus);
                _tmp.setDeliveryStatus(deliveryStatus);
                _tmp.setAdditionalCharges(additionalCharges);
                List<OrderDetail> _tmp2 = OrderDetail.findOrderDetailsByOrderId(_tmp.getOrderId());
                _tmp.setOrderDetails(_tmp2);
                orderList.add(_tmp);
            }

            Database.closeConnection();
            return orderList;
        } catch (Exception ex){
            System.out.println("ERR:getOrders(): " +ex.getMessage());
        }

        return orderList;
    }

    public void sendReceiptEmail(){
        User user = User.findUserById(this.userId);
        String emailSubject = "Order ID " + this.getOrderId() +" Receipt";

        // Styles
        String styles = "<style>\n" +
                "        body {\n" +
                "            font-family: Arial, sans-serif;\n" +
                "            background-color: #E8F4E5; /* Light green background */\n" +
                "            margin: 0;\n" +
                "            padding: 20px;\n" +
                "        }\n" +
                "\n" +
                "        table {\n" +
                "            border-collapse: collapse;\n" +
                "            width: 100%;\n" +
                "            margin-top: 20px;\n" +
                "        }\n" +
                "\n" +
                "        th, td {\n" +
                "            border: 1px solid #4CAF50; /* Green borders for table */\n" +
                "            padding: 8px;\n" +
                "            text-align: left;\n" +
                "        }\n" +
                "\n" +
                "        th {\n" +
                "            background-color: #4CAF50; /* Green header background */\n" +
                "            color: white;\n" +
                "        }\n" +
                "\n" +
                "        td:nth-child(2),\n" +
                "        td:nth-child(4) {\n" +
                "            text-align: right;\n" +
                "        }\n" +
                "\n" +
                "        td:nth-child(3) {\n" +
                "            text-align: center;\n" +
                "        }\n" +
                "\n" +
                "        p {\n" +
                "            margin-bottom: 10px;\n" +
                "        }\n" +
                "\n" +
                "        a {\n" +
                "            color: #4CAF50; /* Green link color */\n" +
                "            text-decoration: none;\n" +
                "            font-weight: bold;\n" +
                "        }\n" +
                "\n" +
                "        a:hover {\n" +
                "            text-decoration: underline;\n" +
                "        }\n" +
                "    </style>";

        // Header Part
        StringBuilder emailBody = new StringBuilder("<body>" + styles + "Hello " + user.getFullName() + ",<br>Here's your receipt for the Order ID " + this.getOrderId() + "<br><br>");

        // Order Details Table
        emailBody.append("<table border=\"1px\"><thead><tr><th>Product</th><th>Price</th><th>Quantity</th><th>Sub Total</th></tr></thead><tbody>");
        for (int i = 0; i < this.getOrderDetails().size(); i++){
            emailBody.append("<tr>");
            emailBody.append("<td>" + this.getOrderDetails().get(i).getProduct().getName() + "</td>");
            emailBody.append("<td>" + (this.getOrderDetails().get(i).getSubTotal() / this.getOrderDetails().get(i).getQuantity()) + "</td>");
            emailBody.append("<td>" + this.getOrderDetails().get(i).getQuantity() + "</td>");
            emailBody.append("<td>" + this.getOrderDetails().get(i).getSubTotal() + "</td>");
            emailBody.append("</tr>");
        }
        emailBody.append("<tr>");
        emailBody.append("<td></td><td></td>");
        emailBody.append("<td><b>Sub Total:</b></td>");
        emailBody.append("<td><b>" + PaymentServices.formatPaymentValue(this.getAdditionalCharges() + this.getAmount()) + "</b></td>");
        emailBody.append("</tr>");

        emailBody.append("<tr>");
        emailBody.append("<td></td><td></td>");
        emailBody.append("<td><b>Addional Charges(Shipping costs, Tax, etc):</b></td>");
        emailBody.append("<td><b>" + PaymentServices.formatPaymentValue(this.getAdditionalCharges() + this.getAmount()) + "</b></td>");
        emailBody.append("</tr>");

        emailBody.append("<tr>");
        emailBody.append("<td></td><td></td>");
        emailBody.append("<td><b>Total:</b></td>");
        emailBody.append("<td><b>" + PaymentServices.formatPaymentValue(this.getAdditionalCharges() + this.getAmount()) + "</b></td>");
        emailBody.append("</tr>");

        emailBody.append("</tbody></table>");

        // Other Details
        emailBody.append("<p>Date & Time: " + this.getDateTime().toString() + "</p>");
        emailBody.append("<p>Payment Status: " + this.getOrderStatus() + "</p>");
        emailBody.append("<small><b>Your order will be delivered to you as soon as possible.</b></small><br>");
        emailBody.append("<small><b>If you have any questions regarding this order, contact us by visiting <a href=\"https://www.greensupermarket.live/contact-us.jsp\">https://www.greensupermarket.live/contact-us.jsp</a></b></small>");

        // Footer
        emailBody.append("<br><br>");
        emailBody.append("GreenSuperMarket - <a href=\"https://www.greensupermarket.live/\">https://www.greensupermarket.live/</a>");
        emailBody.append("</body>");

        Email receiptEmail = new Email(user.getEmail(), emailSubject, emailBody.toString());
        receiptEmail.send();
    }

    public void markPaymentAsCompleted(){
        this.setPaymentStatus("COMPLETED");
        this.setDeliveryStatus("PENDING");

        for (int i = 0; i < this.orderDetails.size(); i++){
            Product product = this.orderDetails.get(i).getProduct();
            product.setProductQuantity(product.getQuantity() - this.orderDetails.get(i).getQuantity());
            product.updateProduct();
        }

        this.updateOrder();
    }

}
