<%-- 
    Document   : contactUs
    Created on : 15 Dec 2023, 12:29:18
    Author     : @sanuth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<!DOCTYPE html>
<html>


  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
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
      height: 110px;
      position: relative;
      background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
    }

    p {
      color: #808080;
    }

    .btn {
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
     padding-bottom: 30%;
     position: relative;
     padding-top: 0px
    
    }

    .google-map iframe {
     height: 80%;
     width: 100%;
     left: 10px;
     top: 150px;
     bottom: 100px;
     position: absolute;
    }
  </style>


<body>
    
  <div>
    <img src="uploads\images\products\Breadcrumbs.png" alt="Vege Image" class="image">
  </div>
    <br><br><br><br>
  <div class="container login-form-container">
    <!-- Left Section -->
    <div class="col-md-4">
      <div class="login-form mb-4">
        <center><img src="uploads\images\contactus\Email.png" alt="Email image">
            <p>supermarket@green.com <br>
                greenhelp@me.com</p>
                <hr>
                <img src="uploads\images\contactus\PhoneCall.jpg" alt="Email image">
                <p>
                    (+94) 555-0114 <br>
                    (+94) 333-0487

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
          <p>Need assistance? or have to tell something? Feel free to contact us <br> by submitting the below form</p>
        </div>

        <form action="#" method="post">
          <div class="mb-4">
            <div class="row">
              <div class="col">
                <input type="text" class="form-control" id="Name" name="Name" placeholder="Name">
              </div>
              <div class="col">
                <input type="email" class="form-control" id="Email" name="Email" placeholder="Email">
              </div>
            </div>
          </div>

          <div class="mb-4">
            <input type="text" class="form-control" id="title" name="title" placeholder="Title">
          </div>

          <div>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="4" placeholder="Subject"></textarea>
          </div>

          <div>
            <input type="submit" class="btn btn-outline" style="background-color: #00b207" value="Send Message">
          </div>
        </form>
      </div>
    </div>
  </div>
    
    
    <div class="google-map">
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7265.530708148501!2d80.03573163662269!3d6.8234098956563365!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2523b05555555%3A0x546c34cd99f6f488!2sNSBM%20Green%20University!5e0!3m2!1sen!2slk!4v1702651401888!5m2!1sen!2slk" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
<%@include file="includes/footer.jsp"%>

</html>

