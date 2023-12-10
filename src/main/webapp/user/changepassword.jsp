<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/8/2023
  Time: 10:11 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Change Your Password</title>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <h3>Change your password</h3>
    <form method="post" action="/api/user/change-password">
        <label>Current Password</label> <br>
        <input type="password" name="current_password"> <br>
        <label>New Password</label> <br>
        <input type="password" name="new_password"> <br>
        <input type="submit" value="Submit"> <br>
    </form>
    <p id="err_msg" style="color: red">${fn:escapeXml(errMsg)}</p>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
