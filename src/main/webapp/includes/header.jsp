<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,Nesith
  Date: 12/10/2023
  Time: 2:48 PM
--%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<nav class="navbar --bs-light-rgb justify-content-center align-content-center text-center" style="padding: 10px 0px 30px 0px">
    

    <div class="container-fluid align-content-center text-center" style="justify-content: space-evenly; padding: 0px">
        <a href="/" class="nav-home-link">
            <div class="navbar-brand d-flex" style="margin: 0px;">
                <img src="/uploads/images/navbar/plant 1.jpg" alt="plant img" style="width: 30px; height: 30px; margin-right: 5px">
                <span>GreenSuperMarket</span>
            </div>
        </a>
        

        <form class="input-group" style="margin: 0px;" action="/products/">
              
                  <input class="form-control custom-no-outline" name="searchQuery" type="" placeholder="Search" aria-label="Search" aria-describedby="search-addon" style="font-family: 'Poppins', sans-serif; font-weight: 400; ">
                  <button class=" me-0 search-button" type="submit" style="background-color:#00B207; color:#FFFFFF;">Search</button>
               
          </form>

            
      
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
                <a href="/login.jsp" class="card-button" >Log In</a>
            </c:if>
        </div>
    </div>
    
    <hr class="nav-hr">
    

    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/products/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Products</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/contact-us.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Contact Us</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/about-us.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">About Us</a>
        </li>
    </ul>
    
</nav>

<style>
    .form-control {
       
        font-weight: bold;
        font-size: 15px; 
    }
    .navbar-brand span{
        font-size: 22px;
        font-weight:600;
        color: #002603;
        
    }
    .navbar-brand span:hover{
        text-decoration: none;
    }
    
    .nav-home-link:hover{
        text-decoration: none;
        }
    .custom-no-outline:focus,
    .custom-no-outline:active {
        outline: none !important;
        box-shadow: none !important;
        border-color:#00B207 ;
        
    }
    .search-button{
        background-color:#00B207; 
        color:#FFFFFF;
        border-radius: 0 5px 5px 0;
        border:none;
    }
    
    .nav-icons{
        margin-right: 2.5rem;
    }
    
    .small-image{
        max-width:25px;
    }
    

    .nav-hr{
        width: 100%; 
        margin: 10px 0; 
        border: 1px solid #666666;
    }
   
    .input-group {
       width: 100%;
       max-width: 500px;
        }
       
    .nav {
            display: flex;
            align-items: center;
            list-style: none;
            padding: 0;
        }

        .nav-item {
            margin-right: 15px;
        }

        .nav-link {
            color: #666666;
            transition: color 0.3s;
        }
    
        @media (max-width: 768px) {
            .nav {
                flex-wrap: wrap; /* Allow items to wrap to the next line */
                justify-content: center; /* Center items horizontally */
            }

            .nav-item {
                margin: 0 10px 10px 0; /* Adjust margin for better spacing */
            }
        }

  


</style>
