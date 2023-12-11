<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 2:48 PM
--%>
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
    </c:if>
</nav>
<style>
    nav {
        display: flex;
        justify-content: space-around;
        background-color: #333;
        padding: 10px;
    }

    nav a {
        color: white;
        text-decoration: none;
        padding: 8px 16px;
    }

    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
</style>