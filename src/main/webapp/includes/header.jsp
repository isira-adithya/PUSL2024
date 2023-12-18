<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,Nesith
  Date: 12/10/2023
  Time: 2:48 PM
--%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

<nav class="navbar --bs-light-rgb justify-content-center align-content-center text-center"style="padding: 30px 0px 30px 0px">
    

    <div class="container-fluid align-content-center text-center" style="justify-content: space-evenly; padding: 0px">
        <div class="navbar-brand d-flex " style="margin: 0px;">
            <img src="/uploads/images/navbar/plant 1.jpg" alt="plant img" style="width: 30px; height: 30px; margin-right: 5px">
            <span>GreenSuperMarket</span>
        </div>
        
        
        <form class="input-group " style="margin: 0px;">
              
                  <input class="form-control custom-no-outline" type="" placeholder="Search" aria-label="Search" aria-describedby="search-addon" style="font-family: 'Poppins', sans-serif; font-weight: 400; ">
                  <button class="btn me-0" type="submit" style="background-color:#00B207; color:#FFFFFF;">Search</button>
               
          </form>
            
      
        <div >
            <c:if test="${isLoggedIn}">
            <a href="/user/cart.jsp" class="nav-icons"><img src="/uploads/images/navbar/s_cart.png" alt="cart" class="small-image"></a>
            <a href="/wishlist" class="nav-icons"><img src="/uploads/images/navbar/wish.png" alt="cart" class="small-image"></a>
            <a href="/" class="nav-icons"><img src="/uploads/images/navbar/log.png" alt="cart" class="small-image"></a>
            </c:if>
            <c:if test="${!isLoggedIn}">
            <a href="/login.jsp" class="custom-btn" >Log In</a>   
            </c:if>
        </div>
    </div>
    
    <hr style="width: 100%; margin: 10px 0; border: 1px solid #666666">
    

    <ul class="nav">
        <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/products" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Products</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/contactus" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Contact Us</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/aboutus" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">About Us</a>
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
    
gg
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
    
    .input-group {
        max-width: 500px;
    }

        
    @media (max-width: 768px) {
    .input-group {
       width: 100%;
        }
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

        /* Responsive styles */
        @media (max-width: 768px) {
            .nav {
                flex-wrap: wrap; /* Allow items to wrap to the next line */
                justify-content: center; /* Center items horizontally */
            }

            .nav-item {
                margin: 0 10px 10px 0; /* Adjust margin for better spacing */
            }
        }
            .custom-btn {
       
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
        font-weight: bold;
    }

    .custom-btn:hover {
        background-color: #666666;
        color: #ffffff; 
        text-decoration: none; 
    }

  

</style>
