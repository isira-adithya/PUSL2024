<%-- 
    Document   : index
    Created on : Dec 6, 2023, 10:10:22 PM
    Author     : isira_adithya
--%>


<%-- Fixing Commits --%>

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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="includes/styles.css" rel="stylesheet">
    <style>

           body {
            margin: 0;
            padding: 0;
        }
        

        .home-land {
            background-color: #EDF2EE;
            padding: 50px 0;
        }

        .home-land-text {
            font-size: 40px;
            font-weight: bolder;
            color: #002603;
        }

        
        .home-end-pic {
            background-image: url(uploads/images/userhome/BG.png);
            background-size: cover;
            background-position: center;
        }

        img {
            max-width: 100%;
            height: auto;
        }


    </style>
</head>
<body>

<%@include file="includes/header.jsp"%>

    <section class="home-land">
        <div class="container">
            <div class="row text-center justify-content-center align-items-center">
                <div class="col-md-6">
                    <img src="uploads/images/userhome/veg-bucket.png" alt="vegbucket" class="img-fluid ">
                </div>
                <div class="col-md-6 home-land-text">
                    Fresh & Healthy <br> Organic Food
                    <br>
                    <a href="/products" class="custom-btn">Shop Now</a>
                </div>
            </div>
        </div>
    </section>

    <section>
        <div class="container" style="max-width: 600px;">
            <div class="row justify-content-center align-items-center contact-box">
                <div class="col-12 col-md-6 text-center">
                    <img src="uploads/images/userhome/Icon_1.png" alt="Email image" class="img-fluid">
                    <p style="font-weight: bold">100% Secure Payment</p>
                    <p>We ensure your money is safe </p>
                </div>

                <div class="col-12 col-md-6 text-center">
                    <img src="uploads/images/userhome/Icon_2.png" alt="Phone image" class="img-fluid">
                    <p style="font-weight: bold">Fast Delivery</p>
                    <p>1-day fast delivery</p>
                </div>
            </div>
        </div>
    </section>

    <section style="margin-top:100px;">
        <div class="container ">
            <div class="row">
                <div class="col-12 text-center text-md-left">
                    <div style="margin-bottom: 10px; font-size: 30px; font-weight: bold;">Featured Products</div>
                </div>

                <% for (int i = 0; i < Math.min(4, products.size()); i++) { %>
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="custom-card">
                            <img src="<%= XSSPreventor.encodeToHtmlEntities(products.get(i).getImage()) %>" alt="Product Image" class="img-fluid mb-3 card-img" style="height: 191px;width: 191px;">
                            <h5><%= XSSPreventor.encodeToHtmlEntities(products.get(i).getName()) %></h5>
                            <p><%= products.get(i).getPrice() %>$</p>
                            <a href="/products/product.jsp?id=<%= products.get(i).getProductId() %>" class="custom-btn">Buy Now</a>
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

    <section class="home-end-pic" style="margin-top:100px;">
        <div class="container">
            <div class="row text-center justify-content-center align-items-center">
                <div class="col-md-6">
                    <img src="uploads/images/userhome/Image.png" alt="farmer1" class="img-fluid">
                </div>
                <div class="col-md-6" style="width:100%;">
                    <p style="font-size: 30px; font-weight: bold; width:100%;">
                        "Savor the flavours of nature, where every bite is a commitment to your well-being and the planet's health."
                    </p>
                </div>
            </div>
        </div>
    </section>

    <%@include file="includes/footer.jsp"%>

</body>
</html>