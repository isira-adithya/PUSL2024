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
    
    <body >
        
        <%@include file="includes/header.jsp"%>
        
        <section class=" home-land">
            <div class="container">
            <div class="row text-center home-land justify-content-center align-items-center">
                <div class="col-md-6">
                    <img src="uploads/images/userhome/veg-bucket.png" alt="vegbucket" style="width: 100%;">
                </div>
                <div class="col-md-6 home-land-text" >
                    Fresh & Healthy <br> Organic Food
                    <br>
                    <a href="/products" class="custom-btn">Shop Now</a>
                </div>
            </div>
        </section>


        
        <section ">
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
                <div class="col-12 text-center text-md-left">
                    <div style="margin-bottom: 10px; font-size: 30px; font-weight: bold;">Featured Products</div>
                </div>

                <% for (int i = 0; i < Math.min(4, products.size()); i++) { %>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="custom-card">
                            <img src="<%= XSSPreventor.encodeToHtmlEntities(products.get(i).getImage()) %>" alt="Product Image" class="img-fluid mb-3" style="width:100%">
                            <h5><%= XSSPreventor.encodeToHtmlEntities(products.get(i).getName()) %></h5>
                            <p><%= products.get(i).getPrice() %>$</p>
                            <a href="/products/product.jsp?id=<%= products.get(i).getProductId() %>" class="custom-btn" >Buy Now</a>                         
                        </div>
                    </div>
                <% } %>
            </div>
         </div>
        </section>
              
                
        <section style="margin-top:100px;">
            <div class="container">
            <div class="row text-center">
                <div class="col-md-6 justify-content-center align-items-center">
                    <img src="uploads/images/userhome/buck_man.png" alt="farmer2" class="img-fluid">
                </div>
                <div class="col-md-6 ">
                    <p class="mb-4" style="font-size: 40px;">100% Trusted <br> Organic Food Store</p>
                    <div class="mb-4">
                        <h5>Healthy & natural food for lovers of healthy food.</h5>
                        <p>All our products are purely naturally made and made just for people who indulge in a diet rich in healthy and natural food.</p>
                    </div>
                    <div>
                        <h5>Every day fresh and quality products for you.</h5>
                        <p>We deliver our food and products in one day and as fresh as they could ever be</p>
                    </div>
                </div>
            </div>
            </div>
        </section>

        <section class=" home-end-pic"style="margin-top:100px;">
            <div class="container">
            <div class="row text-center justify-content-center align-items-center">
                <div class="col-md-6">
                    <img src="uploads/images/userhome/Image.png" alt="farmer1" class="img-fluid">
                </div>
                <div class="col-md-6 ">
                    <p  style="font-size: 30px; font-weight: bold;">
                         "Savor the goodness of nature at GreenSuperMarket, where every bite is a commitment to your well-being and the planet's health."
                    </p>
                </div>
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
        font-size: 40px;
        font-weight:bolder;
        color: #002603;
    }
    
    .custom-btn {
        display: inline-block;
        margin: 20px;
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
    
    .custom-img {
       max-width: 300px; /* Ensure the image doesn't exceed the width of its container */
       height: auto; /* Maintain the image's aspect ratio */
    }
   
    
    .home-end-pic{
        background-image: url(uploads/images/userhome/BG.png);
        background-size: cover; /* Adjust the background size as needed */
        background-position: center; /* Center the background image */
            
    }

    .custom-card {
      border: 2px solid #00B207; 
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      border-radius: 8px;
      padding: 20px;
      margin: 20px 10px;
      text-align: center;
      height: 400px; 
      
    }
    

</style>
