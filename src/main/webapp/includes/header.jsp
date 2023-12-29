<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,Nesith
  Date: 12/10/2023
  Time: 2:48 PM
--%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
    * {
        font-family: 'Poppins', sans-serif;
    }
</style>
<nav class="navbar custom-nav justify-content-center align-content-center text-center" style="padding: 10px 0px 30px 0px">
    <div class="container-fluid d-flex flex-wrap justify-content-around custom-head-container">
        <a href="/" class="custom-nav-home-link">
            <div class="custom-navbar-brand d-flex align-items-center">
                <img src="/uploads/images/navbar/plant_1.jpg" alt="plant img" class="custom-logo-img">
                <span>GreenSuperMarket</span>
            </div>
        </a>
        <form class="custom-input-group d-flex align-items-center" action="/products/">
            <div class="input-group">
                <input class="form-control custom-no-outline" name="searchQuery" type="text" placeholder="Search" aria-label="Search" aria-describedby="search-addon">
                <div class="input-group-append">
                    <input class=" custom-search-button" type="submit">
                </div>
            </div>
        </form>
        <div class="nav-icon-container d-flex align-items-center">
            <c:if test="${isLoggedIn}">
                <a href="/user/cart.jsp" class="custom-nav-icons"><img src="/uploads/images/navbar/s_cart.png" alt="cart" class="custom-small-image"></a>
                <a href="/user/wishlist/" class="custom-nav-icons"><img src="/uploads/images/navbar/addtowishlist.png" alt="wishlist" class="custom-small-image"></a>
                <a href="/user/profile.jsp" class="custom-nav-icons"><img src="/uploads/images/navbar/log.png" alt="profile" class="custom-small-image"></a>
                <c:if test="${isAdmin}">
                    <a href="/admin/" class="custom-nav-icons"><img src="/uploads/images/navbar/admin.png" alt="admin" class="custom-small-image"></a>
                </c:if>
            </c:if>
            <c:if test="${!isLoggedIn}">
                <a href="/login.jsp" class="custom-log-button">Log In</a>
            </c:if>
        </div>
    </div>

    <ul class="custom-link-list">
        <li class="custom-nav-item">
            <a class="custom-nav-link " aria-current="page" href="/index.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Home</a>
        </li>
        <li class="custom-nav-item">
            <a class="custom-nav-link" href="/products/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Products</a>
        </li>
        <li class="custom-nav-item">
            <a class="custom-nav-link" href="/contact-us.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Contact Us</a>
        </li>
        <li class="custom-nav-item">
            <a class="custom-nav-link" href="/about-us.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">About Us</a>
        </li>
    </ul>
</nav>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    .custom-head-container{
        padding: 0px;
        margin: 0px;
    }
    
    .custom-navbar-brand span {
        font-size: 22px;
        font-weight: 600;
        color: #002603;
    }
    
    .custom-navbar-brand span:hover {
        text-decoration: none;
        
    }
    
    .custom-nav-home-link:hover {
        text-decoration: none;
    }
    
    .custom-no-outline:focus,
    .custom-no-outline:active {
        outline: none !important;
        box-shadow: none !important;
        border-color: #00B207;
    }
    
    .custom-form-control {
        font-weight: bold;
        font-size: 15px;
    }
    
    .custom-search-button {
        background-color: #00B207;
        color: #FFFFFF;
        border-radius: 0 5px 5px 0;
        border: none;
        padding: 8px;
        cursor: pointer;
    }
    
    .custom-search-button:hover{
        background-color: #666666;
        color:#ffffff;
        cursor: pointer;
    }

    
    .custom-nav-icons {
        margin: 0.75rem 0.75rem 0rem 0.75rem;
    }
    
    .custom-small-image {
        max-width: 25px;
    }
    
    .custom-hr-line {
        border: 1px solid #000000;
        margin: 10px 0;
        width: 100%;
    }
    
    .custom-input-group {
        width: 100%;
        max-width: 500px;
    }
    
    .custom-link-list {
        display: flex;
        align-items: center;
        justify-content: center;
        list-style: none;
        padding: 0;
        margin: 40px 0px 0px 0px;
    }
    
    .custom-nav-item {
        margin-right: 55px;
    }
    
    .custom-nav-link {
        color: #666666;
        transition: color 0.3s;
    }
    .custom-log-button {
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

      .custom-log-button:hover {
        background-color: #666666;
        color: #ffffff;
        text-decoration: none;
      }
    
    @media (max-width: 768px) {

        .nav-icon-container{
           margin-top:30px;
           
        }
        .custom-nav {
            flex-wrap: wrap;
            justify-content: center;
        }

        .custom-nav-item {
            flex: 1 0 calc(50% - 15px);
            max-width: calc(50% - 15px);
            margin-right: 15px;
        }
        
        .custom-link-list {
            list-style: none;
            padding: 0;
            margin: 30px 0px 0px 0px;
            display: flex;
            flex-wrap: wrap; 
        }

        .custom-nav-item {
            margin: 10px 0;
        }
        .custom-head-container {
            flex-direction: column; /* Stack elements vertically on small screens */
            align-items: center; /* Center align items on small screens */
        }

        .custom-head-container > * {
            margin-bottom: 10px; /* Add some spacing between child elements on small screens */
        }
    }
</style>
