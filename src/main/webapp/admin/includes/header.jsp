<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<nav style="margin-bottom: 25px">
    <a href="/">Home Page</a>
    <a href="/admin/products/">Manage Products</a>
    <a href="/admin/users/">Manage Users</a>
    <a href="/admin/orders/">Manage Orders</a>
    <a href="/admin/users/">See Contact Requests</a>
    <a href="/logout.jsp">Logout</a>
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