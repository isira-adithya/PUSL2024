<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Your Password</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
          crossorigin="anonymous">
    <style>
        .login-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 15px;
            border: 2px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        .login-form:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

        .head {
            text-align: center;
            margin-bottom: 20px;
        }

        .image {
             margin-bottom: 20px;
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

<div class="container mt-3">
   

    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="login-form my-5">
                 <div class="head">
                        <h4><center>Change Password</center></h4>
                        <hr>
                 </div>
                <form action="/api/user/change-password" method="post">
                    <div class="mb-3">
                        <label for="password" class="form-label">Current Password :</label>
                        <input type="password" class="form-control" name="current_password">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">New Password :</label>
                        <input type="password" class="form-control" name="new_password">
                    </div>

                    <div class="d-grid gap-2">
                        <input type="submit" class="btn btn-primary btn-sm mt-3" style="background-color:#00B207"
                               value="Submit">
                    </div>
                </form>
            </div>
            <p id="err_msg" style="color: red">${fn:escapeXml(errMsg)}</p>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>
</body>
</html>
