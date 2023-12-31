<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/27/2023
  Time: 6:03 PM
--%>
<%@include file="../includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Global
    boolean isCodeWrong = false;

    // Checking if the email is already verified
    boolean isEmailVerfied = (boolean) session.getAttribute("isEmailVerified");
    if (isEmailVerfied){
        response.sendRedirect("/user/profile.jsp");
        return;
    }

    // Checking if the user is valid
    int userId = (int) session.getAttribute("userId");
    User user = User.findUserById(userId);
    if (user.getUserId() == -1){
        response.sendRedirect("/404.jsp");
        return;
    }

    // Checking if a query param available to verify
    if (request.getParameterMap().containsKey("code")){
        try {
            // Verifying the code
            int emailVerificationCode = (int) session.getAttribute("emailVerificationCode");
            int userGivenCode = Integer.parseInt(request.getParameter("code"));
            if (emailVerificationCode == userGivenCode){
                user.setIsEmailVerified(true);
                user.updateUser();
                session.setAttribute("isEmailVerified", true);
                response.sendRedirect("/user/profile.jsp");
                return;
            } else {
                isCodeWrong = true;
            }
        } catch (NumberFormatException ignore){
            response.sendRedirect("/logout.jsp");
            return;
        }
    }

    // Checking if the email verification code is already sent before 5 minutes
    if (session.getAttribute("emailVerificationCreatedAt") == null){
        // Sending the email verification code
        int verificationCode = user.sendVerificationCodeEmail();
        session.setAttribute("emailVerificationCode", verificationCode);
        session.setAttribute("emailVerificationCreatedAt", new Timestamp(System.currentTimeMillis()).getTime());
    } else {

        // Sending the email again if it took more than 3 minutes
        long emailVerificationCreatedAtMillis = (long) session.getAttribute("emailVerificationCreatedAt");
        long secondsGone = (System.currentTimeMillis() - emailVerificationCreatedAtMillis) / 1000;
        if (secondsGone > (60) * 3){
            session.setAttribute("emailVerificationCreatedAt", null);
            response.sendRedirect("/user/email-verification.jsp");
        }
    }

    pageContext.setAttribute("isCodeWrong", isCodeWrong);
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verification</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        
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
<%@include file="../includes/header.jsp"%>

    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card mb-5" style="width:600px;">
                    <div class="card-header">
                        <h4><center>Email Verification</center></h4>
                    </div>
                    <div class="card-body">
                        <form action="/user/email-verification.jsp" method="get">
                            <p>We're excited to have you get started. First, you need to confirm your account.</p>
                            <p>We have sent a <b>6 digit code</b> to your email inbox, enter it to verify your account.</p>
                            <input type="text" name="code" placeholder="******">
                            <button type="submit" class="btn btn-sm btn-primary">Verify</button>
                        </form>
                        <c:if test="${isCodeWrong == true}">
                                <div class="alert alert-danger my-3" role="alert">
                                    <p>Invalid Verification Code. Please try again.</p>
                                </div>
                        </c:if>
                        <p class="alert alert-primary mt-4">Haven't received any emails from us? Try refreshing this page after 3 minutes</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
