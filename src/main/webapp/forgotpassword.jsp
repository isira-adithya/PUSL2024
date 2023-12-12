<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/8/2023
  Time: 10:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
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
    if (request.getParameterMap().containsKey("err")){
        errMsg = request.getParameter("err");
    }
    if (request.getParameterMap().containsKey("infoMsg")){
        infoMsg = request.getParameter("infoMsg");
    }

//    Settng pageContext
    pageContext.setAttribute("errMsg", errMsg);
    pageContext.setAttribute("infoMsg", infoMsg);
%>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <%@include file="includes/header.jsp"%>
    <h3>Enter your account's email to reset your password.</h3>
    <form method="post" action="/api/user/forgot-password">
        <label>Email: </label>
        <input type="email" name="email"> <br><br>
        <input type="submit" value="Submit"> <br>
    </form>
    <br>
    <br>
    <p id="err_msg" style="color: red">${fn:escapeXml(errMsg)}</p>
    <p id="info_msg" style="color: blue">${fn:escapeXml(infoMsg)}</p>
    <%@include file="includes/footer.jsp"%>
</body>
</html>
