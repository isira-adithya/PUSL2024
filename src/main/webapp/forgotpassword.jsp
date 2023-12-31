<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya, @hashen-ruwanpura
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
    if (request.getParameterMap().containsKey("msg")){
        infoMsg = request.getParameter("msg");
    }

//    Settng pageContext
    pageContext.setAttribute("errMsg", errMsg);
    pageContext.setAttribute("infoMsg", infoMsg);
%>
<html>
<head>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot password</title>

    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        
        .login-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 15px;
            border: 3px solid #e9e9e9;
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
        .image {
             margin-bottom: 60px;
             width: 100%;
             height: 130px;
             position: relative;
             background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
             background-image: url("/uploads/images/products/Breadcrumbs.png");
             background-size: cover;
             background-position: center; /* Default position */
}

/* Adjust background position for mobile view */
    @media screen and (max-width: 600px) {
        .image {
            height: 120px; /* Adjust the height as needed */
            background-position: left center; /* Adjust position for left cropping */
            object-fit: cover;
    }
}
        
    </style>
</head>

<body>
    <%@include file="includes/header.jsp"%>
    
    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
   <div class="login-form my-5">
        <div class="head">
            <h5><b>Enter your account's email to reset your password.</b></h5>
        </div>
        <form action="/api/user/forgot-password" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email address :</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
            </div>
            
            <div class="d-grid gap-2">
                <input type="submit" class="btn btn-primary btn-sm mt-3" style="background-color:#00B207"; value="Submit">
            </div>

            <c:if test="${errMsg.length() > 0}">
                <div class="alert alert-danger my-2" role="alert">
                        ${fn:escapeXml(errMsg)}
                </div>
            </c:if>

            <c:if test="${infoMsg.length() > 0}">
                <div class="alert alert-success my-2" role="alert">
                        ${fn:escapeXml(infoMsg)}
                </div>
            </c:if>


        </form>
</div>
    
    
    <%@include file="includes/footer.jsp"%>
</body>
</html>


            