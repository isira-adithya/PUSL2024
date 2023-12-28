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
</head>
<body>
<%@include file="../includes/header.jsp"%>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card mb-5">
                    <div class="card-header">
                        <h4>Email Verification</h4>
                    </div>
                    <div class="card-body">
                        <form action="/user/email-verification.jsp" method="get">
                            <p>We're excited to have you get started. First, you need to confirm your account.</p>
                            <p>You should have received a <b>6 digit code</b> to your email inbox, enter it to verify your account.</p>
                            <input type="text" name="code" placeholder="******"><br>
                            <button type="submit" class="btn btn-primary btn-sm mt-3">Verify</button>
                        </form>
                        <c:if test="${isCodeWrong == true}">
                                <div class="alert alert-danger my-3" role="alert">
                                    <p>Invalid Verification Code. Please try again.</p>
                                </div>
                        </c:if>
                        <i>Haven't received any emails from us? Try refreshing this page after 3 minutes</i>
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
