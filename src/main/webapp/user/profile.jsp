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
    
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <style>
        .account-info {
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border: 1px solid #e9e9e9;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .account-info:hover {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            transition: box-shadow 0.5s ease;
        }

        .billing-address:hover {
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
        .buttons{
            max-width: 650px;
            margin: 0 auto;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
            
        }
        .custom-button{
            width:150px;
            border-radius: 100px;
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

        .row .col {
            min-width: 120px;
            max-width: 200px;
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
    <%@include file="../includes/header.jsp"%>
    

    <div>
        <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <div
                    style="width: 312px; height: 306px; padding-bottom: 12px; background: white; border-radius: 8px; border: 1px #E6E6E6 solid; flex-direction: column; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                    <div
                        style="padding-top: 24px; padding-bottom: 16px; padding-left: 20px; justify-content: flex-start; align-items: flex-start; display: inline-flex">
                        <div
                            style="color: #1A1A1A; font-size: 20px; font-family: Poppins; font-weight: 500; line-height: 30px; word-wrap: break-word">
                            Navigation</div>
                    </div>
                    <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; background: white; box-shadow: 3px 0px 0px #20B526 inset; justify-content: center; align-items: center; gap: 10px; display: inline-flex">
                        <div
                            style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">
                            
                            <img src="/uploads/images/profile/editprofile.jpg">

                        </div>
                        <div
                            style="width: 238px; color: #1A1A1A; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word">
                            Edit Profile</div>
                    </div>
                    <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex">
                        <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex">

                            <img src="/uploads/images/profile/orderhistory.jpg">

                        </div>
                        <div
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word">
                            Order History</div>
                    </div>
                    <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex">
                        <div style="width: 24px; height: 24px; padding-left: 2.30px; padding-right: 2.30px; padding-top: 2px; padding-bottom: 2px; justify-content: center; align-items: center; display: flex">
                            
                            <img src="/uploads/images/profile/shoppingcart.jpg">

                        </div>
                        <div a href="/cart.jsp"
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word">
                            Shopping Cart</div>
                    </div>
                    <div
                        style="padding-left: 20px; padding-right: 20px; padding-top: 16px; padding-bottom: 16px; justify-content: center; align-items: center; gap: 10px; display: inline-flex">

                        <div
                            style="width: 24px; height: 24px; padding: 2.30px; justify-content: center; align-items: center; display: flex">
                            <img src="/uploads/images/profile/logout.jpg">

                        </div>
                        <a href="/logout.jsp">
                        <div 
                            style="width: 238px; color: #666666; font-size: 16px; font-family: Poppins; font-weight: 400; line-height: 24px; word-wrap: break-word">
                            Log-out</a></div>
                    </div>
                </div>

            </div>

            <div class="col-md-9">
                <div class="account-info">
                    <h3>Account</h3>
                    <hr>
                    <form method="post" action="/api/user/update">

                        <div class="mb-3 ">
                            <label for="email" class="form-label">Email address:</label>
                            <input type="email" class="form-control" disabled name="email"
                                value="${fn:escapeXml(currentUser.email)}">
                        </div>


                        <div class="mb-3 ">
                            <label for="firstName">First Name:</label>
                            <input type="text" class="form-control" disabled name="firstname"
                                value="${fn:escapeXml(currentUser.firstname)}">
                        </div>
                        <div class="mb-3">
                            <label for="lastName">Last Name:</label>
                            <input type="text" class="form-control" disabled name="lastname"
                                value="${fn:escapeXml(currentUser.lastname)}">
                        </div>


                        <div class="mb-3">
                            <label for="phone">Phone Number:</label>
                            <input type="text" class="form-control" disabled name="phone"
                                value="${fn:escapeXml(currentUser.phone)}">
                        </div>
                    </form>

                </div>

                <div class="billing-address">
                    <h3>Billing Address</h3>
                    <hr>
                    <form method="post" action="/api/user/update">
                        <div class="form-group">
                            <label for="address">Street Address:</label>
                            <input type="text" class="form-control" disabled name="street_address"
                                value="${fn:escapeXml(currentUser.streetAddress)}">
                        </div>

                        <div class="form-group">
                            <label for="address">City</label>
                            <input type="text" class="form-control" disabled name="city"
                                value="${fn:escapeXml(currentUser.city)}">
                        </div>

                        <div class="form-group">
                            <label for="state">State/Province:</label>
                            <input type="text" disabled name="state" class="form-control"
                                value="${fn:escapeXml(currentUser.state)}">
                        </div>

                        <div class="form-group">
                            <label for="country">Country/Region:</label>
                            <input type="text" class="form-control" disabled name="country"
                                value="${fn:escapeXml(currentUser.country)}">
                        </div>

                        <div class="form-group">
                            <label for="zipCode">Postal Code:</label>
                            <input type="text" class="form-control" disabled name="postalcode"
                                value="${fn:escapeXml(currentUser.postalcode)}">
                        </div>

                        <div class="d-grid gap-2">
                            <input type="submit" class="btn btn-primary" style="background-color:#00B207" ;
                                value="Submit" hidden>
                        </div>
                        <hr>
                    </form>
                </div>

                <div class="buttons">
                    <hr>
                    <form method="post" action="/api/user/update">
                        <div class="row">

                            <div class="col">
                                <div class="button">
                                    <input type="submit" button id="editBtn" class="btn btn-primary custom-button" onclick="toggleEdit()"
                                        style="background-color:#00B207" ; value="Edit">
                                </div>
                            </div>
        
        
                            <div class="col">
                                <input type="submit" button id="changePassword" class="btn btn-primary custom-button" 
                                    onclick="location.href = '/user/changepassword.jsp'" style="background-color:#00B207" ;
                                    value="Change password">
                            </div>
        
                            <div class="col">
                                <input type="submit" button id="logoutBtn" class="btn btn-primary custom-button"
                                    onclick="location.href = '/logout.jsp'" style="background-color:#00B207" ; value="LogOut">
                            </div>
        
                            <div class="col">
                                <input type="submit" button id="deleteBtn" class="btn btn-primary custom-button" onclick="deleteAccount()"
                                    style="background-color:#00B207" ; value="Delete">
                            </div>
        
                        </div>
                        <hr>
                    </form>
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
