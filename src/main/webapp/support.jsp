<%-- 
    Document   : Support.jsp
    Created on : Dec 20, 2023, 4:50:51 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    <title>Help & Support - Green Supermarket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        
        

        header {
            background-color: #4CAF50;
            color: #fff;
            padding: 20px;
            text-align: center;
        }

        nav ul {
            list-style: none;
            padding: 0;
            text-align: center;
        }

        nav ul li {
            display: inline;
            margin-right: 20px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
        }

        main {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        h2 {
            margin-top: 20px;
        }

        footer {
            text-align: center;
            margin-top: 50px;
            padding: 10px;
            background-color: #4CAF50;
            color: #fff;
        }
    </style>
</head>

   <%@include file="/includes/header.jsp"%>
<body>
    

    <main>
        <h3>Contact Info</h3>
        <br>
        
         <img src ="/uploads/images/contactus/PhoneCall.jpg" width="32px" style="margin-right:15px; margin-bottom: 10px;"> <b>Phone:</b> <a style="text-decoration: none; color: #00b207;" href="tel:+94701234561">+94701234561</a> , <a style="text-decoration: none; color: #00b207;" href="tel:+94701234562">+94701234562</a> <br>
         <img src ="/uploads/images/contactus/Email.png" width="32px" style="margin-right:15px;"> <b>Email:</b> <a style="text-decoration: none; color: #00b207;" href="mailto:support@greensupermarket.com">support@greensupermarket.com</a>
        <br>
        <br>
        <br>
        <h3>Frequently Asked Questions (FAQs)</h3>
        <br>
        <br>
        <ul class="mx-4">
            <li>
                <h4>What payment methods do you accept?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">We accept various payment methods including PayPal</p>
                </div>
            </li>
            <li class="mt-4">
                <h4>How to track my order?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">You can track your order by logging into your account and checking the order history or by contacting our customer support with your order details.</p>
                </div>
            </li>
            <li class="mt-4">
                <h4>Do you offer international shipping?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">Yes, we offer international shipping to select countries. Shipping costs and delivery times may vary based on the destination.</p>
                </div>
            </li>
            <li class="mt-4">
                <h4>What is your return policy?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">We have a 7-day return policy. Items must be unused and in their original packaging for a full refund.</p>
                </div>
            </li>
            <li class="mt-4">
                <h4>How can I change my account password?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">You can change your account password by logging into your account settings and selecting the option to change your password.</p>
                </div>
            </li>
            <li class="mt-4">
                <h4>Are all your products organic?</h4>
                <div class="alert alert-info">
                    <p style="margin-bottom: 0px;">We strive to offer a wide range of organic products, but not all items are certified organic. </p>
                </div>
            </li>
            
        </ul>
    </main>

    
</body>
<%@include file="/includes/footer.jsp"%>


</html>
