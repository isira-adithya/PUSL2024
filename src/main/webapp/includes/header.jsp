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
        <a href="/logout.jsp">Logout</a>
    </c:if>
    <c:if test="${!isLoggedIn}">
        <a href="/login.jsp">Sign in</a>
    </c:if>

</nav>