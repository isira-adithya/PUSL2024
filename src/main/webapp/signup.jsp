<%--
    Document   : login
    Created on : Dec 7, 2023, 22:05:46 PM
    Author     : isira_adithya
--%>
<%
    boolean isLoggedIn = (session.getAttribute("isLoggedIn") != null);
    if (isLoggedIn) {
        String role = (String) session.getAttribute("role");
        if (role.equals("ADMIN")){
            response.sendRedirect("/admin/index.jsp");
        } else {
            response.sendRedirect("/user/profile.jsp");
        }
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
    <form id="signupForm" action="/api/user/signup" method="post">
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

        <h3>Password</h3>
        <label>Enter your password: </label>
        <input type="password" name="password"> <br>
        <label>Repeat the same password: </label>
        <input type="password" name="repeat_password"> <br>
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

        <button onclick="submitForm()">Submit</button>
    </form>
<script>
    function submitForm(e){
        if (document.getElementsByName("password")[0].value != document.getElementsByName("repeat_password")[0].value){
            alert("Both passwords should be equal");
            document.getElementsByName("password")[0].value = "";
            document.getElementsByName("repeat_password")[0].value = "";
        } else {
            document.getElementById("signupForm").submit();
        }
    }
</script>
</body>
</html>