<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,sanuth_karunagoda
  Date: 12/10/2023
  Time: 2:48 PM
--%>
<style>
        /* Custom Styles */
        footer {
            background-color: #1A1A1A;
            color: white;
        }

        .footer-container {
            width: 100%;
            padding: 1rem;
        }

        .footer-section {
            margin-bottom: 2rem;
        }

        .footer-section h6 {
                        
            font-weight: bold;
            margin-bottom: 1rem;
            font-size: 1.2rem
        }

        .footer-contact p {
            margin-bottom: 1%;
        }

        .social-icons a {
            display: inline-block;
            margin-right: 1rem;
        }

        .copyright {
            background-color: #1A1A1A;
            padding: 0.5rem;
            color: #999999;
        }
        .paracolor{
            color: #999999;
        }

        .social-link {
            display: inline-block;
            margin: 100px;
            transition: background-color 0.3s ease; /* Smooth transition effect */
            border-radius:0%; /* Make it circular initially */
            overflow: hidden; /* Ensure the border-radius applies correctly */
        }
        .social-link {
            display: inline-block;
            margin: 10px;
            transition: background-color 0.3s ease; /* Smooth transition effect */
        }

        .social-link img {
            width: 25px;
            height: 25px;
            
        }

        .social-link:hover {
            background-color: #01c707; /* Change to green on hover */
            border-radius: 100%;
        }
       
        
</style>

<div>
    <!-- Footer -->
    <footer class="text-left text-lg-start">
        <!-- Grid container -->
        <div class="footer-container">
            <!-- Section: Links -->
            <section class="footer-section">
                <!--Grid row-->
                <div class="row">                   
                    <!-- Grid column -->
                     <div class="col-md-3 col-lg-3  col-xl-4 mx-auto mt-4 align-self-center">
                        <div class="text-center">
                        <h3 class=" mb-4"><br>
                            <img src="/uploads/footer/GreenSuperMarket_Logo.jpg" alt="Icon" style="width: 30px; height: 30px; margin-right: 4px;"> GreenSuperMarket</h3>
                         </div>
                        </div>


                    <!-- Grid column -->

                    <hr class="w-100 clearfix d-md-none" />

                    <!-- Grid column -->
                    <div class="col-md-2 col-lg- col-xl-2 mx-auto mt-2; col align-self-center"> 
                        <h6 class=" mb-4 font-weight-bold"><br><br><br>My Account</h6>
                        <p><a class="paracolor mb-3.5 d-block" href="/user/profile.jsp" style="text-decoration: none" > Account</a></p>
                        <p><a class="paracolor mb-3.5 d-block" href="/user/cart.jsp" style="text-decoration: none">Shopping Cart</a></p>
                        <p><a class="paracolor mb-3.5 d-block" href="/user/wishlist/" style="text-decoration: none">Wish List</a></p>
                       
                    </div>
                    <!-- Grid column -->

                    <hr class="w-100 clearfix d-md-none" />

                    <!-- Grid column -->
                    <div class="col-md-2 col-lg- col-xl-2 mx-auto mt-2; col align-self-center">
                        <h6 class=" mb-4 font-weight-bold"><br><br><br>Help and Support</h6>
                        <p><a class="paracolor mb-3.5 d-block" href="/contact-us.jsp" style="text-decoration: none">Contact Us</a></p>
                        <p><a class="paracolor mb-3.5 d-block" href="/about-us.jsp" style="text-decoration: none">About Us</a></p>
                        <p><a class="paracolor mb-3.5 d-block" href="/support.jsp" style="text-decoration: none">FAQ & Support</a></p>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-2 col align-self-center ml-2 "><br><br>
                        

                        

                        <!-- Facebook -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/facebook_2.png" alt="facebook" width="20" height="20">
                        </a>

                        <!-- Twitter -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/twitter 1.svg" alt="Twitter" width="20" height="20">
                        </a>

                        <!-- pinterest -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/pinterest 1.svg" alt="pinterest" width="20" height="20">
                        </a>
                        

                        <!-- instagram -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/instagram.svg" alt="instagram" width="20" height="20">
                        </a>

                    </div>
                    
                </div>
                <!--Grid row-->
            </section>
            <!-- Section: Links -->
        </div>
        <!-- Grid container -->
        
        <!-- Copyright -->
        <div class="text-center p-3 copyright"><hr color="#999999" width="100%">

            GreenSuperMarket 2023 All Rights Reserved
            
        </div>
        <!-- Copyright -->
    </footer>
    <!-- Footer -->
</div>
