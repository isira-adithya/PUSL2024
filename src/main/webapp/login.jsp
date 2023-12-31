<%--
    Document   : login
    Created on : Dec 7, 2023, 5:45:46 PM
    Author     : isira-aditha, @hashen-ruwanpura
--%>
<%@include file="/includes/variables.jsp"%>
<%
    String errMsg = null;
    if (request.getParameterMap().containsKey("err")){
        errMsg = request.getParameter("err");
    }

    String infoMsg = null;
    if (request.getParameterMap().containsKey("msg")){
        infoMsg = request.getParameter("msg");
    }

    pageContext.setAttribute("errMsg", errMsg);
    pageContext.setAttribute("infoMsg", infoMsg);

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

    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        
        .login-form {
            max-width: 500px;
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
    
    <div >
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
    
    <div class="login-form my-5">
        <div class="head">
            <h3><b>Sign In</b></h3>
        </div>
        <form action="/api/user/login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            </div>
            <div class="form-check mb-3">
<%--                <input type="checkbox" class="form-check-input" id="remember_me" name="remember_me">--%>
<%--                <label class="form-check-label" for="remember_me">Remember me</label>--%>
                <a href="/forgotpassword.jsp" class="float-end" style="color: #000;">Forgot Password?</a>
            </div>
            <div class="d-grid gap-2">
                <input type="submit" class="btn btn-primary" style="background-color:#00B207"; value="Login">
            </div>

            <c:if test="${errMsg != null}">
                <div class="alert alert-danger my-2" role="alert">
                    ${fn:escapeXml(errMsg)}
                </div>
            </c:if>

            <c:if test="${infoMsg != null}">
                <div class="alert alert-success my-2" role="alert">
                        ${fn:escapeXml(infoMsg)}
                </div>
            </c:if>
            
        </form>
        <p class="text-center mt-3">Don't have an account? <a href="/signup.jsp"  style="color: #000;">Register</a></p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <%@include file="includes/footer.jsp"%>
    
</body>
</html>