<%--
    Document   : login
    Created on : Dec 7, 2023, 22:05:46 PM
    Author     : isira_adithya
--%>
<%
    boolean isLoggedIn = (session.getAttribute("isLoggedIn") != null);
    if (isLoggedIn) {
        response.sendRedirect("/user/profile.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - GreenSuperMarket</title>
</head>
<body>
    <form action="/api/user/signup" method="post">
        <h3>Personal Information</h3>
        <label>Email: </label>
        <input type="email" name="email"> <br>
        <label>First Name: </label>
        <input type="text" name="firstname"> <br>
        <label>Last Name: </label>
        <input type="text" name="lastname"> <br>
        <label>Phone: </label>
        <input type="tel" name="phone"> <br>
        <hr>
        <h3>Address</h3>
        <label>Street/No: </label>
        <input type="text" name="street_address"> <br>
        <label>City: </label>
        <input type="text" name="city"> <br>
        <label>State: </label>
        <input type="text" name="state"> <br>
        <label>Country: </label>
        <input type="text" name="country"> <br>
        <label>Postal Code: </label>
        <input type="number" inputmode="numeric" name="postalcode"> <br>

        <input type="submit" value="Submit">
    </form>
</body>
</html>