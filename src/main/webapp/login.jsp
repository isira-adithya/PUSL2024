<%--
    Document   : login
    Created on : Dec 7, 2023, 5:45:46 PM
    Author     : isira_adithya
--%>
<%@include file="/includes/variables.jsp"%>
<%
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
    <title>Login - GreenSuperMarket</title>
</head>
<body>
    <%@include file="includes/header.jsp"%>
    <form action="/api/user/login" method="post">
        <input type="text" name="email" placeholder="Email Address Here"> <br>
        <input type="password" name="password" placeholder="Password"> <br>
        <input type="submit" value="Login"> <br>
    </form>
    <%@include file="includes/footer.jsp"%>
</body>
</html>