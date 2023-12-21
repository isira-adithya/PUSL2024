<%-- 
    Document   : Support.jsp
    Created on : Dec 20, 2023, 4:50:51 PM
    Author     : asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

   <%@include file="../../includes/header.jsp"%>
<body>
    

    <main>
        <h1>Help And Support</h1>
        
        Contact Info<br>
        
         <image src =" http://localhost:8080/uploads/images/contactus/PhoneCall.jpg"> <b>Phone:</b> +94701234561 , +94701234562 <br>
         <image src ="http://localhost:8080/uploads/images/contactus/Email.png"> <b>Email:</b> support@greensupermarket.com
        
        <br>
        <br>
        
        <h4><p><i>Welcome to Green Supermarket's Help & Support page. Here you can find answers to common questions and get assistance.</i></p></h4>
        <br>
        
        <br>
        <h3>Frequently Asked Questions (FAQs)</h3>
        
        <br>
        
        <br>
        <ul>
           
            <li>
                <h4>What payment methods do you accept?</h4>
                <p>We accept various payment methods including PayPal</p>
                  
                    
            </li>
            <li>
            <h4>How to track my order?</h4>
            
                    <p>You can track your order by logging into your account and checking the order history or by contacting our customer support with your order details.</p>
                </li>
                <li>
                    <h4>Do you offer international shipping?</h4>
                    <p>Yes, we offer international shipping to select countries. Shipping costs and delivery times may vary based on the destination.</p>
                </li>
                <li>
                    <h4>What is your return policy?</h4>
                    <p>We have a  30-day return policy. Items must be unused and in their original packaging for a full refund.</p>
                </li>
                <li>
                    <h4>How can I change my account password?</h4>
                    <p>You can change your account password by logging into your account settings and selecting the option to change your password.</p>
                </li>
                <li>
                    <h4>Are all your products organic?</h4>
                    <p>We strive to offer a wide range of organic products, but not all items are certified organic. </p>
                </li>
            
        </ul>
    </main>

    
</body>
<%@include file="../../includes/footer.jsp"%>


</html>