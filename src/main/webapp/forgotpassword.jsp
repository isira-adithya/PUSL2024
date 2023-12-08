<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/8/2023
  Time: 10:58 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%
    String errMsg = "";
    String infoMsg = "";
    if (request.getParameterMap().containsKey("err")){
        errMsg = request.getParameter("err");
    }
    if (request.getParameterMap().containsKey("infoMsg")){
        infoMsg = request.getParameter("infoMsg");
    }
%>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <h3>Enter your account's email to reset your password.</h3>
    <form method="post" action="/api/user/forgot-password">
        <label>Email: </label>
        <input type="email" name="email"> <br><br>
        <input type="submit" value="Submit"> <br>
    </form>
    <br>
    <br>
    <p id="err_msg" style="color: red"><% out.print(XSSPreventor.encodeToHtmlEntities(errMsg)); %></p>
    <p id="info_msg" style="color: blue"><% out.print(XSSPreventor.encodeToHtmlEntities(infoMsg)); %></p>
</body>
</html>
