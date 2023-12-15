<%-- 
    Document   : contactUs
    Created on : 15 Dec 2023, 12:29:18
    Author     : sanut
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        
        .login-form {
            max-width: 800px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
           
        }

        .login-form:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        .login-form {
             transition: box-shadow 0.5s ease; 
        }

        .head {
            text-align: left;
            margin-bottom: 15px;
        }
        .image{
            margin-bottom: 60px;
            width: 100%;
            height: 100px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }
        p {
        color: #808080;
         }
         
        .btn {
        height: 40px;
        width: 165px;
        border-radius: 100px; /* Adjust the value to control the oval shape */
        color: #ffffff;
        margin-bottom: 40px;
        }
        textarea{
            margin-bottom: 20px;
        }
        
    </style>
</head>
<body>
    
    <%@include file="includes/header.jsp"%>
    
    <div >
        <img src="Breadcrumbs.jpg" alt="Vege Image" class="image">
    </div>
    
    <div class="login-form">
        <div class="head">
            <h3><b>Just Say Hello!</b></h3>
            <p>Need assistances? or have to tell something? feel free to contact us <br> by submitting the bellow form</p>
        </div>

        <form action="#" method="post">
            <div class="mb-4">
                
                <input type="text" class="form-control" id="Name" name="name" placeholder="Name">
            </div>
            <div class="mb-4">
                
                <input type="email" class="form-control" id="email" name="email" placeholder="Email">
                
            </div>
            <div>            
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="4" placeholder="Subject"></textarea>
            </div>
            
            <div>
                <input type="submit" class="btn btn-outline" style="background-color:#00B207"; value=" Send Message ">
            </div>
            
        </form>
        
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    
    
</body>
</html>