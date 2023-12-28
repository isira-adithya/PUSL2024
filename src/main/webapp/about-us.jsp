<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/19/2023
  Time: 3:01 AM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
        <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        
        .image {
             margin-bottom: 60px;
             width: 100%;
             height: 110px;
              position: relative;
             background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
    }
    
        body {
            background-color: #ffffff;
        }

        h1,
        h2,
        p {
            font-family: Arial, sans-serif;
        }

        .custom-card {
            position: relative;
            overflow: hidden;
            width: 100%;
            border: none; /* Remove the border */
        }

        .card-img-right {
            width: 100%;
            height: auto;
            max-height: none;
            object-fit: cover;
            position: center;
            top: 0;
            left: 0;
            margin-right: 20px; /* Add margin to create space */
        }

        .card-text {
        position: relative;
        z-index: 1;
        text-align: left;
       padding: 45px; /* Adjusted padding for reduced gap */
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; /* Adjust the gap as needed */
        }

        .product-list li {
            flex: 0 0 45%; /* Adjust the width of each item */
            display: flex;
            background-color: #fff; /* Set the background color for each list item */
            padding: 0px; /* Add some padding for spacing */
            border-radius: 8px; /* Add border-radius for rounded corners */
            position: relative; /* Added position relative */
        }

        .product-list li .product-image {
            width: 50px; /* Set the width */
            height: 50px; /* Set the height */
            object-fit: cover; /* Maintain the aspect ratio and cover the container */
            margin-right: 10px; /* Add some space between the image and text */
            border-radius: 0; /* Remove the border-radius */
        }

        .product-list li div {
            flex-grow: 1;
        }

        .product-list li p {
            font-size: 0.8em; /* Adjust the font size of the subtext */
            margin-top: 5px; /* Add some space between the strong word and the subtext */
        }

        /* Add this style in the head or a separate CSS file */

        .checkmark {
            display: inline-block;
            width: 15px; /* Adjust the width of the circle */
            height: 15px; /* Adjust the height of the circle */
            line-height: 15px; /* Center the checkmark vertically */
            font-size: 10px; /* Adjust the size of the checkmark */
            text-align: center;
            color: white;
            background-color: #64c565;
            border-radius: 50%; /* Make it a circle */
            margin-right: 5px; /* Add some space between the checkmark and text */
        }

        /* Updated style for the shop now link button */
        .shop-now-btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #01b206;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 20px 20px 0 0; /* Add right margin to move it a bit to the right */
        }


.card {
    flex: 1 0 100%;
    margin: 0 15px 15px 0;
    max-height: 900px;
    border: 1px solid #ccc; /* Add border properties */
    border-radius: 15px; /* Add border-radius for rounded corners */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Add a subtle shadow for depth */
}

.card img {
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
}


.carousel-item .card img {
    border-top-left-radius: 15px; /* Adjust the top-left border-radius for the image */
    border-top-right-radius: 15px; /* Adjust the top-right border-radius for the image */
    max-height: 250px; /* Adjust the maximum height of the image */
}


    /* Additional styles for the second card */
    .carousel-item:nth-child(2) .card {
        background-color: #fff; /* Set a background color for the second card */
    }

    .carousel-item:nth-child(2) .card img {
        border-top-left-radius: 15px; /* Match the top-left border-radius for the image */
        border-top-right-radius: 15px; /* Match the top-right border-radius for the image */
    }
      /* Adjust the size of the arrow images */
        .carousel-control-prev img,
        .carousel-control-next img {
            width: 30px; /* Adjust the width as needed */
            height: 30px; /* Adjust the height as needed */
        }   
        .centered-text {
            text-align: center;
            margin-top: 50px;
        }

        .centered-text h1 {
            font-weight: bold;
            font-size: 24px;
        }

        .centered-text p {
            font-size: 16px;
        }
                .team
        {
            margin:75px 0;
        }
        h1
        {
            text-align:center;
            font-weight:bold;
            letter-spacing: 2px;
            color: #333;
            padding-bottom: 10px;

        }
        h1:after
        {
            content:'';
            background: #333;
            display: block;
            height: 3px;
            width: 150px;
            margin: 10px auto;
        }
.profile
{
    margin-top: 25px;
}
.profile .img-box
{
    opacity:1;
    display: block;
    position: relative;
}
.profile h2
{
  font-size: 22px;
 font-weight: bold;
  margin-top: 15px;  
}
.profile h3
{
  font-size: 15px;
  font-weight: bold;
  margin-top: 15px;
}
.img-box:after {
    content: '';
    opacity: 0;
    background-color: rgba(0, 0, 0, 0.6);
    position: absolute;
    right: 0;
    left: 0;
    top: 0;
    bottom: 0;
}
.img-box ul
{
    margin:0;
    padding:20px 0;
    position: absolute;
    z-index: 1;
    bottom:0;
    display:block;
    left:50%;
    transform:translateX(-50px);
    opacity:0;
}
.img-box ul li
{
    width: 30px;
    height: 30px;
    border: 1px solid #fff;
    border-radius:50%;
    margin:3px;
    padding:7px;
    display: inline-block;
}
.img-box a
{
  color: #fff;  
}
.img-box:hover:after,
.img-box:hover ul {
    opacity: 1;
}
.img-box:hover a li {
    color: #007bff;
    border: 1px solid #007bff;
}
.img-box:after,
.img-box ul,
.img-box ul li {
    transition: all 0.5s ease-in-out 0s, opacity 0.5s ease-in-out 0s;
}
.custom-arrow {
    max-width: 30px; /* Set the maximum width of your arrow images */
    max-height: 30px; /* Set the maximum height of your arrow images */
}
</style>
</head>
<body>
    <meta charset="UTF-8">
    <div>
        <img src="\uploads\images\products\Breadcrumbs.png" alt="Vege Image" class="image" >
    </div>

      <div class="container-fluid mt-10">
        <!-- First Card (Image on the Right, Text on the Left) -->
        <div class="card custom-card mb-4">
            <div class="row">
                <div class="col-md-8">
                    <div class="card-text">
                        <h2 class="card-title"><strong>Enriching Lives<br>Through Quality and <br>Community Focus.</strong></h2>
                        <p>Dedicated to enriching lives through a diverse selection of quality<br>products, with a
                            commitment to excellence, we strive to be your<br>go-to destination for all your grocery
                            needs, fostering a<br>welcoming environment for families and individuals alike.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="/uploads/about us/theman1.jpg" alt="Card Image" class="card-img-right img-fluid">
                </div>
            </div>
        </div>

        <!-- Second Card (Image on the Left, Text on the Right) -->
        <div class="card custom-card mb-4" style="background-image: url('/uploads/about us/background.jpg'); background-size: 680px; background-position: left; background-repeat: no-repeat;">
            <div class="row">
                <div class="col-md-4 col-sm-50">
                    <img src="/uploads/about us/theman2.png" style="max-height: 365px; margin-top: 115px;">
                </div>
                <div class="col-md-8">
                    <div class="card-text">
                        <h2 class="card-title"><strong>100% Trusted<br>Organic Food Store</strong></h2>
                        <p>A reputable and reliable organic food store committed to offering 100%<br>trusted
                            high-quality organic products for conscious consumers.<br>Providing a secure and wholesome
                            shopping experience with a focus<br>on organic and trustable practices.</p>
                        <!-- List with images on both sides -->
                        <ul class="list-unstyled product-list">
                            <li>
                                <img src="/uploads/about us/leave.jpg" alt="Product 1" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>100% Organic Food</strong>
                                    <p>100% healthy and fresh food.</p>
                                </div>
                            </li>
                            <li>
                                <img src="/uploads/about us/headphone.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Great Support 24/7</strong>
                                    <p>Instant access to Contact</p>
                                </div>
                            </li>
                            <li>
                                <img src="/uploads/about us/star.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Customer Feedback</strong>
                                    <p>Our Happy Customer</p>
                                </div>
                            </li>
                            <li>
                                <img src="uploads/about us/bag.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>100% Secure Payment</strong>
                                    <p>We ensure your money is safe</p>
                                </div>
                            </li>
                            <li>
                                <img src="uploads/about us/lorry.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Free Shipping</strong>
                                    <p>Free shipping with Discount.</p>
                                </div>
                            </li>
                            <li>
                                <img src="uploads/about us/box.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>100% Organic Food </strong>
                                    <p>100% healthy & Fresh Food.</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Third Card (Image on the Left, Text on the Right) -->
        <div class="card custom-card mb-4">
            <div class="row">
                <div class="col-md-8">
                    <div class="card-text">
                        <h2 class="card-title"><strong>We Deliver, You Enjoy<br>Your Order.</strong></h2>
                        <p>We ensure swift delivery so you can savor your order stress-free.<br>Your satisfaction is our
                            priority. Making every moment of<br> enjoyment yours to relish.</p>

                        <!-- List with green tick images -->
                        <ul class="list-unstyled check-list">
                            <li><img src="uploads/about us/Check.png" alt="Green Tick" class="checkmark"> "Swift delivery, relish-free, your enjoyment our commitment"</li>
                            <li><img src="uploads/about us/Check.png" alt="Green Tick" class="checkmark"> "Efficient delivery, indulge worry-free, delight in every bite"</li>
                            <li style="position: relative;"><img src="uploads/about us/Check.png" alt="Green Tick" class="checkmark"> "Timely delivery, saver with ease, your satisfaction guaranteed."
                                <!-- Shop Now button -->
                                <div class="shop-now-container">
                                    <a href="/products/product.jsp" class="shop-now-btn">Shop Now <span>&rarr;</span></a>
                                </div>
                            </li>
                            <!-- Add more list items as needed -->
                        </ul>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="uploads/about us/theman3.jpg" alt="Card Image" class="card-img-right img-fluid">
                </div>
            </div>
        </div>

    <div class="centered-text">
        <h1><center>Our Awesome Team</center></h1>
        <p>"Our dynamic team is a synergistic blend of diverse talents and expertise.<br>united by a shred passion for excellence and a collective commitment to<br>delivering innoative solutions and exceptional service"</p>
    </div>

 <div id="teamCarousel" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
     <div class="carousel-item active">
    <div class="container">
    <section class="team">
        <div class="container">
            <div class="row">
                <div class="col-md-3 profile text center">
                    <div class="img-box">
                     <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>

                    <h2>Isira Adithya</h2>
                    <h3>Founder</h3>
                </div>
                    <div class="col-md-3 profile text center">
                    <div class="img-box">
                    <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                    <h2>Nesith Perera</h2>
                    <h3>Founder</h3>
                </div>
                <div class="col-md-3 profile text center">
                    <div class="img-box">
                        <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                    <h2>Hashen Ruwanpura</h2>
                    <h3>Founder</h3>
                </div>
             </div>


                   <div class="carousel-item">
                    <div class="row">
                    <div class="col-md-3 profile text center">
                    <div class="img-box">
                     <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>

                    <h2>Sanuth Karunagoda</h2>
                    <h3>Founder</h3>
                </div>
                    <div class="col-md-3 profile text center">
                    <div class="img-box">
                    <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                    <h2>Chandesh Gunawardena</h2>
                    <h3>Founder</h3>
                </div>
                <div class="col-md-3 profile text center">
                    <div class="img-box">
                        <img src="uploads/about us/person.jpg" class="img-responsive img-fluid">
                        <ul>
                         <li><a href="#" class="social-square"><i class="fa fa-instagram"></i></a></li>
                        <li><a href="#" class="social-square"><i class="fa fa-linkedin"></i></a></li>
                        </ul>
                    </div>
                    <h2>Thiyara Bandara</h2>
                    <h3>Founder</h3>
                </div>
            </div>
</div>
            <a class="carousel-control-prev" href="#teamCarousel" role="button" data-slide="prev">
            <img src="uploads/about us/left arrow.png" alt="Previous" class="custom-arrow">
            </a>
             <a class="carousel-control-next" href="#teamCarousel" role="button" data-slide="next">
             <img src="uploads/about us/right arrow.png" alt="Next" class="custom-arrow">
           </a>
        </div>
    </div>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
