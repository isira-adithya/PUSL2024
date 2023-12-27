<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="styles.css" rel="stylesheet">
<nav class="navbar custom-bs-light-rgb justify-content-center align-content-center text-center" style="padding: 10px 0px 30px 0px">
    <div class="container-fluid custom-align-content-center text-center" style="justify-content: space-evenly; padding: 0px">
        <a href="/" class="custom-nav-home-link">
            <div class="custom-navbar-brand d-flex" style="margin: 0px;">
                <img src="/uploads/images/navbar/plant_1.jpg" alt="plant img" class="custom-logo-img">
                <span>GreenSuperMarket</span>
            </div>
        </a>
        <form class="custom-input-group d-flex" style="margin: 0px;" action="/products/">
            <div class="input-group">
                <input class="form-control custom-no-outline" name="searchQuery" type="text" placeholder="Search" aria-label="Search" aria-describedby="search-addon">
                <div class="input-group-append">
                    <button class="btn custom-search-button" type="submit">Search</button>
                </div>
            </div>
        </form>
        <div class="nav-icon-container">
            <c:if test="${isLoggedIn}">
                <a href="/user/cart.jsp" class="custom-nav-icons"><img src="/uploads/images/navbar/s_cart.png" alt="cart" class="custom-small-image"></a>
                <a href="/user/wishlist/" class="custom-nav-icons"><img src="/uploads/images/navbar/wish.png" alt="wishlist" class="custom-small-image"></a>
                <a href="/user/profile.jsp" class="custom-nav-icons"><img src="/uploads/images/navbar/log.png" alt="profile" class="custom-small-image"></a>
                <c:if test="${isAdmin}">
                    <a href="/admin/" class="custom-nav-icons"><img src="/uploads/images/navbar/admin.png" alt="admin" class="custom-small-image"></a>
                </c:if>
            </c:if>
            <c:if test="${!isLoggedIn}">
                <a href="/login.jsp" class="custom-card-button">Log In</a>
            </c:if>
        </div>
    </div>

    <ul class="custom-link-list">
         <li class="nav-item">
            <a class="nav-link" href="/admin/products/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Manage Products</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/admin/users/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Manage Users</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/admin/orders/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Manage Orders</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/admin/analytics/" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Analytics</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/logout.jsp" onmouseover="this.style.color='#00B207'" onmouseout="this.style.color='#666666'">Logout</a>
        </li>
        
    </ul>
</nav>

<style>
    
    .custom-form-control {
        font-weight: bold;
        font-size: 15px;
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
    
    .custom-search-button {
        background-color: #00B207;
        color: #FFFFFF;
        border-radius: 0 5px 5px 0;
        border: none;
        padding: 8px;
    }
    .custom-search-button:hover{
        background-color: #666666;
        color:#ffffff;
    }
    .custom-nav-icons {
        margin-right: 2.5rem;
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
    }
</style>

