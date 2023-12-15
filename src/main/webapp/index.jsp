<%-- 
    Document   : index
    Created on : Dec 6, 2023, 10:10:22 PM
    Author     : isira_adithya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>Home</title>
    </head>
    
    <body>
        
        <%@include file="includes/header.jsp"%>

        <section class="home-land">
            <div class="row align-items-center justify-content-center">
                <div class="col-12 col-md-4 text-center mb-3 mb-md-0">
                    <img src="uploads/images/userhome/veg-bucket.png" alt="vegbucket" style="width: 100%;">
                </div>
                <div class="col-12 col-md-4 home-land-text text-md-left text-center">
                    Fresh & Healthy <br> Organic Food
                    <br>

                    <a href="/products" class="custom-btn">Shop Now</a>
                </div>
            </div>
        </section>

        
        
        
        
        <%--
        <a href="/login.jsp">Customer Login</a> <br>
        <a href="/signup.jsp">Customer Signup</a> <br>
        <a href="/user/profile.jsp">Customer Profile</a> <br>
        <a href="/forgotpassword.jsp">Customer Forgot Password</a> <br>
        <a href="/logout.jsp">Logout</a> <br>

        <hr>

        <a href="/products">Products</a> <br>
        --%>
        <%@include file="includes/footer.jsp"%>
    </body>
</html>

<style>
    body{
        font-family: 'Arial', sans-serif;
    }
    
    .home-land{
        width:100%;
        background-color:#EDF2EE;
    }
    .home-land-text{
        font-size: 30px;
        font-weight:bolder;
        color: #002603;
    }
    
    .custom-btn {
        display: inline-block;
        padding: 8px 15px; 
        text-decoration: none;
        color: #ffffff;
        background-color: #00B207;
        border: none;
        box-shadow: none;
        cursor: pointer;
        border-radius: 20px; 
        transition: background-color 0.3s ease; 
        font-size: 14px;
  }

  .custom-btn:hover {
        background-color: #666666;
        color: #ffffff; 
        text-decoration: none; 
  }
</style>
