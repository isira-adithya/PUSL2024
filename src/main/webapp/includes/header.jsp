<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,Nesith
  Date: 12/10/2023
  Time: 2:48 PM
--%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<nav class="navbar --bs-light-rgb justify-content-center">
    
    <div class="container-fluid" style="justify-content: space-evenly;">
        <div class="navbar-brand d-flex align-items-center">
            <img src="/uploads/images/navbar/plant 1.jpg" alt="plant img" style="width: 30px; height: 30px; margin-right: 5px">
            <span>GreenSuperMarket</span>
        </div>
        <form class="d-flex" action="/products/">
            <div class="input-group" style="width: 400px;">
                <input name="searchQuery" class="form-control custom-no-outline" type="" placeholder="Search" aria-label="Search" aria-describedby="search-addon" style="font-family: 'Poppins', sans-serif; font-weight: 400;">
                <button class="header-btns me-0" type="submit" style="background-color:#00B207; color:#FFFFFF;">Search</button>
            </div>
        </form>
        <div class="d-flex">
            <a href="/user/cart.jsp" class="nav-icons"><img src="/uploads/images/navbar/cart.jpg" alt="cart" class="small-image"></a>
            <a href="/" class="nav-icons"><img src="/uploads/images/navbar/user.jpg" alt="cart" class="small-image"></a>
            <a href="/wishlist" class="nav-icons"><img src="/uploads/images/navbar/wishlist.jpg" alt="cart" class="small-image"></a>
        </div>
    </div>
    
    <hr style="width: 100%; margin: 10px 0; border: 1px solid #666666">
    
    <ul class="nav d-flex align-items-center">
      <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/" style="color: #666666; transition: color 0.3s;" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/products" style="color: #666666; transition: color 0.3s;" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Products</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/contact-us.jsp" style="color: #666666; transition: color 0.3s;" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Contact Us</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/aboutus" style="color: #666666; transition: color 0.3s;" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">About Us</a>
      </li>
    </ul>
    
</nav>

<%--
<nav style="margin-bottom: 25px">
    <a href="/">Home</a>
    <a href="/products">Products</a>
    
    
    <c:if test="${isLoggedIn}">
        <a href="/user/profile.jsp">Profile</a>
        <a href="/user/cart.jsp">Cart</a>
        <a href="/user/orders/">Orders</a>
        <a href="/logout.jsp">Logout</a>
    </c:if>
        
    <c:if test="${!isLoggedIn}">
        <a href="/login.jsp">Sign in</a>
        <a href="/signup.jsp">Sign up</a>
    </c:if>
    
</nav>
--%>
<style>
    .form-control,
    .header-btns {
        font-family: 'Arial', sans-serif;
        font-weight: bold;
        font-size: 15px; /* Adjust the font size as needed */
    }
    .navbar-brand span{
      
        font-size: 22px;
        font-weight:600;
        color: #002603;
    }
    .custom-no-outline:focus,
    .custom-no-outline:active {
        outline: none !important;
        box-shadow: none !important;
        border-color:#00B207 ;
    }
    
    .nav-icons{
        margin-right: 2.5rem;
    }
    
    .small-image{
        max-width:25px; 
        max-width:25px;
    }
    
   
</style>