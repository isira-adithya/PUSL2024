<%-- 
    Document   : index
    Created on : Dec 6, 2023, 10:10:22 PM
    Author     : isira_adithya
--%>


<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    List<Product> products = new ArrayList<Product>();
    products = Product.getProducts();
    if (products.size() <= 0){
        response.sendRedirect("/?msg=No Products Found");
        return;
    }
    pageContext.setAttribute("products", products);
    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <title>Home</title>
    </head>
    
    <body>
        
        <%@include file="includes/header.jsp"%>

        <section class="home-land">
            <div class="row align-items-center justify-content-center home-land">
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
        
        <section>
 
        <div class="container" style="max-width: 600px;">
          <div class="row justify-content-center align-items-center contact-box">
            <div class="col-12 col-md-6 text-center">
              <img src="uploads/images/userhome/Icon_1.png" alt="Email image">
              <p style="font-weight: bold">100% Secure Payment</p>
              <p>We ensure your money is safe </p>
            </div>

            <div class="col-12 col-md-6 text-center">
              <img src="uploads/images/userhome/Icon_2.png" alt="Phone image">
              <p style="font-weight: bold">Fast Delivery</p>
              <p>1-day fast delivery</p>
            </div>
          </div>
        </div>

        </section>
        
        <section>
            
            <div class="container mt-4">
                <div class="row">
                    <div class=" home-land-text"style="margin:30px 0px 30px 0px;">
                        Featured Products
                    </div>

                  <% for (int i = 0; i < Math.min(4, products.size()); i++) { %>
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                        <div class="card" style="border-color:#00B207;">
                          <img src="<%= XSSPreventor.encodeToHtmlEntities(products.get(i).getImage()) %>" class="card-img-top" alt="Product Image" style="width: 100%; height: 200px;">
                        <div class="card-body">
                            <h5 class="card-title"><%= XSSPreventor.encodeToHtmlEntities(products.get(i).getName()) %></h5>
                          <p class="card-text"><%= XSSPreventor.encodeToHtmlEntities(products.get(i).getDescription()) %></p>
                          <p class="card-text"> <%= products.get(i).getPrice() %>$</p>
                          <a href="/products/product.jsp?id=<%= products.get(i).getProductId() %>" class="custom-btn">Open</a>
                        </div>
                      </div>
                    </div>
                  <% } %>

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
        width: 100%;
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

  
    .contact-box {
      background-color: #fff;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin: 0px;
    }

    img {
      max-width: 100%;
      height: auto;
    }
</style>
