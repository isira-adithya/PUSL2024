<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya , @hashen-ruwanpura
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
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
    <style>
        
        .login-form {
            max-width: 550px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
           
        }
        .login-form:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }
        .head {
            text-align: center;
            margin-bottom: 15px;
        }
        .image{
            margin-bottom: 50px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
        
    </style>

</head>
<body>
    <%@include file="includes/header.jsp"%>
    
    <h3>Reset your password</h3>
    
     <div >
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>

    <h3><center>Reset Password</center></h3><br>
    <div class="login-form">
        <div class="head">
            <p><b>Enter your email address and new password, then submit the form to reset your password.</b><p>
        </div>
        <form action="/api/user/reset-password" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">New Password</label>
                <input type="password" class="form-control" id="password" name="new_password" placeholder="Enter New Password"> 
            </div>

            <input type="hidden" name="token" value="${fn:escapeXml(token)}">

            
            <div class="d-grid gap-2">
                <input class="btn btn-primary" type="submit" style="background-color:#00B207";> Submit </input>
            </div>
            
        </form>
        
    </div>
        
    <br>
    <br>
    <p id="err_msg" style="color: red">${fn:escapeXml(errMsg)}</p>
    <p id="info_msg" style="color: blue">${fn:escapeXml(infoMsg)}</p>
    
    <%@include file="includes/footer.jsp"%>
</body>
</html>
