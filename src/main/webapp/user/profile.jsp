<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/7/2023
  Time: 9:47 PM
--%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    if (role.equals("ADMIN")){
        response.sendRedirect("/admin/index.jsp");
        return;
    }

    String user_email = (String) session.getAttribute("email");
    User currentUser = User.findUserByEmail(user_email);
    pageContext.setAttribute("currentUser", currentUser);
%>
<html>
<head>
    <title>Profile</title>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        .account-info {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .account-info:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease; 
        }

        .billing-address:hover{
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease; 
        }

        .billing-address {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 30px;
        }

        .account-info h3 {
            margin-top: 0;
        }
        .billing-address h3 {
            margin-top: 0;
        }
        .account-info .form-group {
            margin-bottom: 15px;
            margin-top: 20px;

        }
        .billing-address .form-group {
            margin-bottom: 15px;
            margin-top: 20px;

        }
    </style>
    
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    
  <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h2 class="mb-4">Navigation</h2>
                <ul class="list-unstyled">
                    <li><a href="#">Edit Profile</a></li>
                    <li><a href="#">Order History</a></li>
                    <li><a href="#">Shopping Cart</a></li>
                    <li><a href="#">Log Out</a></li>
                </ul>
            </div>


            <div class="col-md-9">
                <div class="account-info">
                    <h3>Account</h3>
                    <hr>
                    <form method="post" action="/api/user/update">

                        <div class="mb-3 ">
                            <label for="email" class="form-label">Email address:</label>
                            <input type="email" class="form-control" disabled name="email" value="${fn:escapeXml(currentUser.email)}" >
                          </div>


                        <div class="mb-3 ">
                            <label for="firstName">First Name:</label>
                            <input type="text" class="form-control" disabled name="firstname" value="${fn:escapeXml(currentUser.firstname)}" >
                        </div>
                        <div class="mb-3">
                            <label for="lastName">Last Name:</label>
                            <input type="text" class="form-control" disabled name="lastname" value="${fn:escapeXml(currentUser.lastname)}" >
                        </div>

                        
                          <div class="mb-3">
                            <label for="phone">Phone Number:</label>
                            <input type="text" class="form-control" disabled name="phone" value="${fn:escapeXml(currentUser.phone)}" >
                        </div>
                    </form>

                </div>
                    



                    <div class="billing-address">
                        <h3>Billing Address</h3>
                        <hr>
                        <form method="post" action="/api/user/update">
                        <div class="form-group">
                            <label for="address">Street Address:</label>
                            <input type="text" class="form-control" disabled name="street_address"  value="${fn:escapeXml(currentUser.streetAddress)}">
                        </div>

                        <div class="form-group">
                            <label for="address">City</label>
                            <input type="text" class="form-control" disabled name="city" value="${fn:escapeXml(currentUser.city)}">
                        </div>

                        <div class="form-group">
                            <label for="state">State/Province:</label>
                            <input type="text" disabled name="state" class="form-control" value="${fn:escapeXml(currentUser.state)}">
                        </div>

                        <div class="form-group">
                            <label for="country">Country/Region:</label>
                            <input type="text" class="form-control" disabled name="country" value="${fn:escapeXml(currentUser.country)}">
                        </div>

                        <div class="form-group">
                            <label for="zipCode">Postal Code:</label>
                            <input type="text" class="form-control" disabled name="postalcode"  value="${fn:escapeXml(currentUser.postalcode)}">
                        </div>

                        <div class="d-grid gap-2">
                            <input type="submit" class="btn btn-primary" style="background-color:#00B207"; value="Submit" hidden>
                        </div>
                        <hr>
                </form>
            </div>

                <div class="row">

                    <div class="col">
                        <input type="submit" button id="editBtn" class="btn btn-primary" onclick="toggleEdit()" style="background-color:#00B207"; value="Edit">
                    </div>

                    <div class="col">
                        <input type="submit" button id="changePassword" class="btn btn-primary" onclick="location.href = '/user/changepassword.jsp'" style="background-color:#00B207"; value="Change password">
                    </div>

                    <div class="col">
                        <input type="submit" button id="logoutBtn" class="btn btn-primary" onclick="location.href = '/logout.jsp'" style="background-color:#00B207"; value="LogOut">
                    </div>

                    <div class="col">
                        <input type="submit" button id="deleteBtn" class="btn btn-primary" onclick="deleteAccount()" style="background-color:#00B207"; value="Delete">
                    </div>

                  </div>

                
            </div>
        </div>
    </div>

    <%@include file="../includes/footer.jsp"%>

    <script>
        let isEditMode = false;
        function toggleEdit(){
            isEditMode = !isEditMode;
            const inputTags = document.getElementsByTagName("input")
            for (let i = 0; i < inputTags.length; i++) {
                const inputTag = inputTags[i];
                if (inputTag.name == "email"){
                    continue
                }
                inputTag.disabled = !isEditMode;
            }
            if (isEditMode){
                document.getElementById("editBtn").innerText = "Preview";
                document.getElementById("submitBtn").hidden = false;
            } else {
                document.getElementById("editBtn").innerText = "Edit";
                document.getElementById("submitBtn").hidden = true;
            }
        }

        function deleteAccount(){
            let response = confirm("Are you sure?");
            if (response){
                fetch("/api/user/delete", {
                    method: "DELETE"
                }).then(res => {
                    if(res.status == 200){
                        document.location.href = "/logout.jsp";
                    }
                }).catch(err => {
                    alert("Something went wrong. Please try again later.")
                })
            }
        }
    </script>
</body>
</html>
