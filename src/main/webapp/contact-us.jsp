<%-- 
    Document   : contactUs
    Created on : 15 Dec 2023, 12:29:18
    Author     : @sanuth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%
  String email = "";
  String name = "";

  if(isLoggedIn){
    User userObj = User.findUserById((int) session.getAttribute("userId"));
    name = userObj.getFullName();
    email = userObj.getEmail();
  }

  pageContext.setAttribute("isLoggedIn", isLoggedIn);
  pageContext.setAttribute("email", email);
  pageContext.setAttribute("name", name);
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
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">


  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"/>
  <style>

    .login-form-container {
      display: flex;
      align-items: center;
      justify-content: center;

    }


    .login-form {
      max-width: 800px;
      padding: 15px;
      border: 1px solid #e9e9e9;
      border-radius: 5px;
    }

    .login-form:hover {
      box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    .login-form {
      transition: box-shadow 0.5s ease;
    }

    .head {
      text-align: left;
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

    p {
      color: #808080;
    }

    .sendmsg-button {
      height: 40px;
      width: 165px;
      border-radius: 100px;
      color: #ffffff;
      margin-bottom: 20px;
    }

    textarea {
      margin-bottom: 20px;
    }

    h3 {
      margin-top: 15px;
    }

    .spacer {
      margin-right: 30px; /* Add margin-right to create space */
    }

    .google-map {
      position: relative;
      overflow: hidden;
      height: 10px;
    }

    .google-map iframe {
      width: 100%;
      height: 70%;
      position: absolute;
      top: 300px;
      left: 0;
      border: 0;
    }


    /* Responsive padding for the container */
    @media (min-width: 576px) {
      .google-map {
        padding-bottom: 56.25%; /* 16:9 aspect ratio */
      }


    }
  </style>
  <style>
    @media (max-width: 767px) {
      /* Mobile view styles */
      .login-form-container {
        flex-direction: column;
      }

      .col-md-4,
      .col-md-8 {
        max-width: 100%;
        order: 0; /* Default order for both columns */
      }

      .col-md-4 {
        order: 1; /* Set the order for the email/phone container */
        margin-top: 20px; /* Add margin-top for space between form and email/phone container */
      }

      .google-map {
        height: auto; /* Make the height auto to adjust based on content */
      }

      .google-map iframe {
        top: 0;
        height: 200px; /* Set a specific height for the map on mobile view */
      }
  </style>


<body>
<%@include file="includes/header.jsp" %>
<div>
  <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
</div>
<br><br><br><br>
<div class="container login-form-container">
  <!-- Left Section -->
  <div class="col-md-4 mt-2">
    <div class="login-form mb-4">
      <center><img src="/uploads/images/contactus/Email.png" alt="Email image">
        <p>Send us a mail</p>
        <p>
          <a class="btn btn-white my-2" style="color: #00b207;" href="mailto:contact@greensupermarket.live">contact@greensupermarket.live</a> <br>
          <a class="btn btn-white my-2" style="color: #00b207;" href="mailto:support@greensupermarket.live">support@greensupermarket.live</a>
        </p>
        <hr>
        <img src="/uploads/images/contactus/PhoneCall.jpg" alt="Email image">
        <p>Call us here</p>
        <a class="btn btn-white my-2" style="color: #00b207;" href="tel:+94701234561"> (+94) 70 123 4561 </a><br>
        <a class="btn btn-white my-2" style="color: #00b207;" href="tel:+94701234562"> (+94) 70 123 4562 </a>
        </p>
      </center>

    </div>
  </div>

  <!-- Spacer -->
  <div class="spacer"></div>

  <!-- Right Form -->
  <div class="col-md-8">
    <div class="login-form">
      <div class="head">
        <h3><b>Just Say Hello!</b></h3>
        <p>Need assistance? or have to tell something? Feel free to contact us <br> by submitting the below form.</p>
        <p>We will contact you through your email within 3 business days.</p>
      </div>

      <form action="/api/misc/createSupportTicket" method="post">
        <div class="mb-4">
          <div class="row">
            <div class="col">
              <c:if test="${isLoggedIn == false}">
                <input type="text" class="form-control" id="Name" name="name" placeholder="Name">
              </c:if>
              <c:if test="${isLoggedIn == true}">
                <input type="text" class="form-control" id="Name" name="name" value="${fn:escapeXml(name)}" readonly>
              </c:if>
            </div>
            <div class="col">
              <c:if test="${isLoggedIn == false}">
                <input type="email" class="form-control" id="Email" name="email" placeholder="Email">
              </c:if>
              <c:if test="${isLoggedIn == true}">
                <input type="email" class="form-control" id="Email" name="email" value="${fn:escapeXml(email)}"
                       readonly>
              </c:if>
            </div>
          </div>
        </div>

        <div class="mb-4">
          <input type="text" class="form-control" id="title" name="title" placeholder="Title">
        </div>

        <div>
          <textarea name="subject" class="form-control" id="exampleFormControlTextarea1" rows="4"
                    placeholder="Subject"></textarea>
        </div>

        <div>
          <br>
          <input type="submit" class="btn btn-outline sendmsg-button" style="background-color: #00b207"
                 value="Send Message">
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
  </div>
</div>


<div class="google-map">
  <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7265.530708148501!2d80.03573163662269!3d6.8234098956563365!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2523b05555555%3A0x546c34cd99f6f488!2sNSBM%20Green%20University!5e0!3m2!1sen!2slk!4v1702651401888!5m2!1sen!2slk"
          width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"
          referrerpolicy="no-referrer-when-downgrade"></iframe>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>
<%@include file="includes/footer.jsp" %>
</body>


</head></html>


