<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<!DOCTYPE html>
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
        font-size: 1.2rem;
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

    .paracolor {
        color: #999999;
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

    .green-supermarket-text {
        position: relative;
        display: inline-block;
    }

    .green-supermarket-text::after {
        content: "";
        display: block;
        width: 50%;
        height: 2px;
        background-color: #fff;
        position: absolute;
        bottom: 0;
        left: 25%;
    }

    /* Media Queries for Responsiveness */
    @media only screen and (max-width: 768px) {
        .footer-section {
            text-align: center;
        }

        .social-link {
            margin: 10px;
        }

        .copyright {
            text-align: center;
        }
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
                    <div class="col-md-12 col-lg-3 col-xl-4 mx-auto mt-4 align-self-center">
                        <div class="text-center">
                            <h3 class="mb-4">
                                <img src="/uploads/footer/GreenSuperMarket_Logo.jpg" alt="Icon" style="width: 30px; height: 30px; margin-right: 4px;">
                                GreenSuperMarket<br>Admin
                            </h3>
                        </div>
                    </div>

                    <hr class="w-100 clearfix d-md-none" />

                    <!-- Grid column -->
                    <div class="col-md-12 col-lg-2 col-xl-2 mx-auto mt-2 col align-self-center ml-2">
                        <!-- Facebook -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/facebook_2.png" alt="facebook" width="20" height="20">
                        </a>

                        <!-- Twitter -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/twitter 1.svg" alt="Twitter" width="20" height="20">
                        </a>

                        <!-- Pinterest -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/pinterest 1.svg" alt="Pinterest" width="20" height="20">
                        </a>

                        <!-- Instagram -->
                        <a href="#!" class="social-link">
                            <img src="/uploads/footer/instagram.svg" alt="Instagram" width="20" height="20">
                        </a>
                    </div>
                </div>
                <!--Grid row-->
            </section>
            <!-- Section: Links -->
        </div>
        <!-- Grid container -->

        <!-- Copyright -->
        <div class="text-center p-3 copyright">
            <hr color="#999999" width="100%">
            GreenSuperMarket 2023 All Rights Reserved
        </div>
        <!-- Copyright -->
    </footer>
    <!-- Footer -->
</div>
