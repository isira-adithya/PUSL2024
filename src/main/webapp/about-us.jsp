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
</style>
</head>
<body>
    <meta charset="UTF-8">


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
                    <img src="theman1.jpg" alt="Card Image" class="card-img-right img-fluid">
                </div>
            </div>
        </div>

        <!-- Second Card (Image on the Left, Text on the Right) -->
        <div class="card custom-card mb-4" style="background-image: url('background.jpg'); background-size: 680px; background-position: left; background-repeat: no-repeat;">
            <div class="row">
                <div class="col-md-4 col-sm-50">
                    <img src="theman2.png" style="max-height: 365px; margin-top: 115px;">
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
                                <img src="leave.jpg" alt="Product 1" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>100% Organic Food</strong>
                                    <p>100% healthy and fresh food.</p>
                                </div>
                            </li>
                            <li>
                                <img src="headphone.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Great Support 24/7</strong>
                                    <p>Instant access to Contact</p>
                                </div>
                            </li>
                            <li>
                                <img src="star.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Customer Feedback</strong>
                                    <p>Our Happy Customer</p>
                                </div>
                            </li>
                            <li>
                                <img src="bag.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>100% Secure Payment</strong>
                                    <p>We ensure your money is safe</p>
                                </div>
                            </li>
                            <li>
                                <img src="lorry.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
                                <div>
                                    <strong>Free Shipping</strong>
                                    <p>Free shipping with Discount.</p>
                                </div>
                            </li>
                            <li>
                                <img src="box.jpg" alt="Product 2" class="rounded-circle product-image" width="50" height="50">
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
                            <li><img src="check.png" alt="Green Tick" class="checkmark"> "Swift delivery, relish-free, your enjoyment our commitment"</li>
                            <li><img src="check.png" alt="Green Tick" class="checkmark"> "Efficient delivery, indulge worry-free, delight in every bite"</li>
                            <li style="position: relative;"><img src="check.png" alt="Green Tick" class="checkmark"> "Timely delivery, saver with ease, your satisfaction guaranteed."
                                <!-- Shop Now button -->
                                <div class="shop-now-container">
                                    <a href="#" class="shop-now-btn">Shop Now <span>&rarr;</span></a>
                                </div>
                            </li>
                            <!-- Add more list items as needed -->
                        </ul>
                    </div>
                </div>
                <div class="col-md-4">
                    <img src="theman3.jpg" alt="Card Image" class="card-img-right img-fluid">
                </div>
            </div>
        </div>

    <div class="centered-text">
        <h1><center>Our Awesome Team</center></h1>
        <p>Our dynamic team is a synergistic blend of diverse talents and expertise.<br>united by a shred passion for excellence and a collective commitment to<br>delivering innoative solutions and exceptional service"</p>
    </div>

<div id="myCustomCarousel" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">

        <!-- First Slide -->
        <div class="carousel-item active">
            <div class="card-deck">
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">ISIRA ADITHYA</h5>
                        <p class="card-text">This is the content for card 1 in the first slide.</p>
                    </div>
                </div>
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">NESITH</h5>
                        <p class="card-text">This is the content for card 2 in the first slide.</p>
                    </div>
                </div>
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">HASHEN</h5>
                        <p class="card-text">This is the content for card 3 in the first slide.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Second Slide -->
        <div class="carousel-item">
            <div class="card-deck">
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">SANUTH</h5>
                        <p class="card-text">This is the content for card 4 in the second slide.</p>
                    </div>
                </div>
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">CHANDESH</h5>
                        <p class="card-text">This is the content for card 5 in the second slide.</p>
                    </div>
                </div>
                <div class="card">
                    <img class="card-img-top" src="person.jpg" alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">THIYARA</h5>
                        <p class="card-text">This is the content for card 6 in the second slide.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add more slides as needed -->

    </div>

        <!-- Carousel Controls with Arrow Images -->
        <a class="carousel-control-prev" href="#myCustomCarousel" role="button" data-slide="prev">
            <img src="left arrow.png" alt="Left Arrow">
        </a>
        <a class="carousel-control-next" href="#myCustomCarousel" role="button" data-slide="next">
            <img src="right arrow.png" alt="Right Arrow">
        </a>
    </div>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
