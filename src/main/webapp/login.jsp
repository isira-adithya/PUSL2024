<%
    boolean isLoggedIn = (session.getAttribute("isLoggedIn") != null);
    if (isLoggedIn) {
        response.sendRedirect("/");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - GreenSuperMarket</title>
</head>
<body>
    <form action="/api/customer/login" method="post">
        <input type="text" name="username" placeholder="Email Address Here"> <br>
        <input type="password" name="password" placeholder="Password"> <br>
        <input type="submit" value="Login"> <br>
    </form>
</body>
</html>