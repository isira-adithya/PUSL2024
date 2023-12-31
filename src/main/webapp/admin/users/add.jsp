<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <title>Add New User/Administrator - GreenSuperMarket</title>
    <style>
    .form-box{
        max-width: 650px;
        margin: 0 auto;
        padding: 15px;
        border: 1px solid #e9e9e9;
        border-radius: 5px;
        
        
    }
    .form-box:hover{
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        transition: box-shadow 0.5s ease;
    }
    .form-group{
        margin: 20px 0px 20px 0px;
        text-align: left;
        
    }
    .form-group label{
        font-weight: bold;
    }
    h3 {
        margin: 30px; 
        font-weight: bold;
    }
    
    .ad-custom-btn {
        display: inline-block;
        margin: 10px;
        padding: 8px 15px;
        text-decoration: none;
        color: #ffffff;
        background-color: #00B207;
        border: none;
        border-radius: 20px;
        transition: background-color 0.3s ease;
        font-size: 14px;
    }

    .ad-custom-btn:hover {
        background-color: #666666;
        color: #ffffff;
        text-decoration: none;
    }
        
    @media (max-width: 576px) {
        .form-group.role {
           text-align: center;
        }
    }
    .image {
      margin-bottom: 60px;
      width: 100%;
      height: 130px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
      background-image: url("/uploads/images/products/Breadcrumbs.png");
      background-size: cover;
      background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }
}
    </style>
</head>
<body>
<%@include file="../includes/header.jsp"%>
        <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
        </div>

<section>
    <div class="container">
        <div class="row text-center justify-content-center align-items-center">
            <div class="col-md-8">
                <div style="margin-top: 25px;" class="mx-auto col-md-8 form-box">
                    <h3 class="text-center">Personal Information</h3>
                    <hr>
                    <form id="signupForm" action="/api/admin/users/add" method="post">
                        
                        <div class="form-group">
                            <label for="role">Role</label>
                            <select name="role" class="form-control" style="box-shadow: none;" >
                                <option value="USER" selected>Customer</option>
                                <option value="ADMIN">Administrator</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" name="email" class="form-control" id="email" placeholder="Enter email" style="box-shadow: none;" required>
                        </div>

                         <div class="form-group">
                            <label for="firstName" class="form-label">First Name</label>
                            <input type="text" name="firstname" class="form-control" id="firstName" placeholder="Enter first name" style="box-shadow: none;" required>
                        </div>
                          <div class="form-group">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input type="text" name="lastname" class="form-control" id="lastName" placeholder="Enter last name" style="box-shadow: none;" required>
                        </div>
                          <div class="form-group">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" name="phone" class="form-control" id="phone" placeholder="Enter phone number" style="box-shadow: none;" >
                        </div>
                        
                        <h3 class="text-center"> Address</h3>
                        <hr>
                        <div class="form-group">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" name="street_address" class="form-control" id="address" placeholder="Enter address" style="box-shadow: none;" >
                        </div>
                        <div class="form-group">
                            <label for="city" class="form-label">City</label>
                            <input type="text" name="city" class="form-control" id="city" placeholder="Enter city" style="box-shadow: none;">
                        </div>
                        <div class="form-group">
                            <label for="state" class="form-label">State</label>
                            <input type="text" name="state" class="form-control" id="state" placeholder="Enter state" style="box-shadow: none;" >
                        </div>
                        <div class="form-group">
                            <label for="country" class="form-label">Country</label>
                            <input type="text" name="country" class="form-control" id="country" placeholder="Enter country"style="box-shadow: none;" >
                        </div>
                        <div class="form-group">
                            <label for="postalCode" class="form-label">Postal Code</label>
                            <input type="text" name="postalcode" class="form-control" id="postalCode" placeholder="Enter postal code"style="box-shadow: none;" >
                        </div>

                        <div class="alert alert-primary">
                            Newly added users must reset their password to login.
                        </div>
                        

                        <div class="d-grid gap-2">
                            <input type="submit" class="ad-custom-btn"  value="Submit">
                        </div>

                        
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<br><br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
