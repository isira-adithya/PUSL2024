<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/8/2023
  Time: 10:58 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%
    String errMsg = "";
    String infoMsg = "";
    String token = "";
    if (request.getParameterMap().containsKey("err")){
        errMsg = request.getParameter("err");
    }
    if (request.getParameterMap().containsKey("infoMsg")){
        infoMsg = request.getParameter("infoMsg");
    }
    if (request.getParameterMap().containsKey("token")){
        token = request.getParameter("token");
    } else {
        response.sendRedirect("/forgotpassword.jsp?err=Invalid or Expired Password Reset Link");
        return;
    }
    pageContext.setAttribute("errMsg", errMsg);
    pageContext.setAttribute("infoMsg", infoMsg);
    pageContext.setAttribute("token", token);
%>
<html>
<head>
    <title>Reset Your Password</title>
</head>
<body>
    <%@include file="includes/header.jsp"%>
    <h3>Reset your password</h3>
    <form method="post" action="/api/user/reset-password">
        <p>Enter your email address and a good password, then submit the form to reset your password.</p> <br>
        <label>Email: </label>
        <input type="email" name="email"> <br>
        <label>New Password: </label>
        <input type="password" name="new_password"> <br><br>
        <input type="hidden" name="token" value="${fn:escapeXml(token)}">
        <input type="submit" value="Submit"> <br>
    </form>
    <br>
    <br>
    <p id="err_msg" style="color: red">${fn:escapeXml(errMsg)}</p>
    <p id="info_msg" style="color: blue">${fn:escapeXml(infoMsg)}</p>
    <%@include file="includes/footer.jsp"%>
</body>
</html>
