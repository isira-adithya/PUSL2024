<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<nav class="navbar --bs-light-rgb justify-content-center align-content-center text-center" style="padding: 10px 0px 30px 0px">
    

    <div class="container-fluid align-content-center text-center" style="justify-content: space-evenly; padding: 0px">
        <a href="/" style="text-decoration:none;">
            <div class="navbar-brand d-flex" style="margin: 0px;">
                <img src="/uploads/images/navbar/plant 1.jpg" alt="plant img" style="width: 30px; height: 30px; margin-right: 5px">
                <span>GreenSuperMarket</span>
            </div>
        </a>
          
        <div>
            <c:if test="${isLoggedIn}">
                <a href="/user/cart.jsp" class="nav-icons"><img src="/uploads/images/navbar/s_cart.png" alt="cart" class="small-image"></a>
                <a href="/user/wishlist/" class="nav-icons"><img src="/uploads/images/navbar/wish.png" alt="cart" class="small-image"></a>
                <a href="/user/profile.jsp" class="nav-icons"><img src="/uploads/images/navbar/log.png" alt="cart" class="small-image"></a>
                <c:if test="${isAdmin}">
                    <a href="/admin/" class="nav-icons"><img src="/uploads/images/navbar/admin.png" alt="cart" class="small-image"></a>
                </c:if>
            </c:if>
            <c:if test="${!isLoggedIn}">
                <a href="/login.jsp" class="custom-btn" >Log In</a>
            </c:if>
        </div>
    </div>
    
    <hr style="width: 100%; margin: 10px 0; border: 1px solid #666666">
    
