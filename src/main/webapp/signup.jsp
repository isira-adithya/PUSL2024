<%--
    Document   : login
    Created on : Dec 7, 2023, 22:05:46 PM
    Author     : isira_adithya , @hashen-ruwanpura


--%>
<%@include file="/includes/variables.jsp"%>
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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup - GreenSuperMarket</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
    <style>
        
        .sign-up {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-top: 20px;
            
           
        }
        .sign-up:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease; 
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
    
     <div >
        <img src="uploads\images\products\Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
    <h2><center><b>Create Account</b></center></h2>

  <div class="sign-up">
    
    <h3><center>Personal Information</center></h3>
   
    <form id="signupForm" action="/api/user/signup" method="post">

      <div class="row">
      <div class="mb-3 ">
        <label for="email" class="form-label">Email address</label>
        <input type="email" class="form-control" id="email" placeholder="Enter email">
      </div>
    

      <div class="mb-3 col-sm-5 col-md-6">
        <label for="firstName" class="form-label">First Name</label>
        <input type="text" class="form-control" id="firstName" placeholder="Enter first name">
      </div>

      <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
        <label for="lastName" class="form-label">Last Name</label>
        <input type="text" class="form-control" id="lastName" placeholder="Enter last name">
      </div>

      <div class="mb-3">
        <label for="phone" class="form-label">Phone Number</label>
        <input type="tel" class="form-control" id="phone" placeholder="Enter phone number">
      </div>

      <div class="mb-3">
        <h3><center>Password</center></h3>
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control" id="password" placeholder="Enter password">
      </div>

      <div class="mb-3">
        <label for="repeatPassword" class="form-label">Repeat Password</label>
        <input type="password" class="form-control" id="repeatPassword" placeholder="Repeat password">
      </div>

      <h3><center>Address</center></h3>
      <br><br>
      <div class="mb-3 col-sm-5 col-md-6">
        <label for="address" class="form-label">Address</label>
        <input type="text" class="form-control" id="address" placeholder="Enter address">
      </div>

      <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
        <label for="streetNo" class="form-label">Street/No</label>
        <input type="text" class="form-control" id="streetNo" placeholder="Enter street/number">
      </div>

      <div class="mb-3 col-sm-5 col-md-6">
        <label for="city" class="form-label">City</label>
        <input type="text" class="form-control" id="city" placeholder="Enter city">
      </div>

      <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
        <label for="state" class="form-label">State</label>
        <input type="text" class="form-control" id="state" placeholder="Enter state">
      </div>

      <div class="mb-3 col-sm-5 col-md-6">
        <label for="country" class="form-label">Country</label>
        <input type="text" class="form-control" id="country" placeholder="Enter country">
      </div>

      <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
        <label for="postalCode" class="form-label">Postal Code</label>
        <input type="text" class="form-control" id="postalCode" placeholder="Enter postal code">
      </div>
    </div>
        <br>
      <div class="d-grid gap-2">
        <input type="submit" class="btn btn-primary" style="background-color:#00B207"; value="Submit">
    </div>
        
        <p class="text-center mt-3">Already Have An Account? <a href="/login.jsp"  style="color: #000;">LogIn</a></p>
        
    </form>
  </div>
    
    <%@include file="includes/footer.jsp"%>


<script>
    function submitForm(e){
        if (document.getElementsByName("password")[0].value != document.getElementsByName("repeat_password")[0].value){
            alert("Both passwords should be equal");
            document.getElementsByName("password")[0].value = "";
            document.getElementsByName("repeat_password")[0].value = "";
        } else {
            document.getElementById("signupForm").submit();
        }
    }
</script>
</body>
</html>