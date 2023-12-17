<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="java.util.List" %>
<%@include file="../includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = -1;
    User user;

    // Only allowing numbers
    if (request.getParameterMap().containsKey("id")){
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException ex){
            id = -1;
        }
    }

    // Validating the product id
    if (id >= 0){
        user = User.findUserById(id);
        if (user.getUserId() == -1){
            response.sendRedirect("/users/");
            return;
        }
    } else {
        response.sendRedirect("/users/");
        return;
    }

    // Loading data to pageContext
    pageContext.setAttribute("user", user);
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <title>${fn:escapeXml(user.fullName)} - Green SuperMarket</title>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div style="margin-left: 25px;">
    <h3>Personal Information</h3>
    <form id="signupForm" action="/api/admin/users/update" method="post">
        <div class="row">

            <div class="mb-3 ">
                <label class="form-label">Role</label>
                <select name="role">
                    <c:if test="${user.role.equals('USER')}">
                        <option value="USER" selected>Customer</option>
                        <option value="ADMIN">Administrator</option>
                    </c:if>
                    <c:if test="${user.role.equals('ADMIN')}">
                        <option value="USER">Customer</option>
                        <option value="ADMIN" selected>Administrator</option>
                    </c:if>
                </select>
            </div>

            <div class="mb-3 ">
                <label for="email" class="form-label">Email address</label>
                <input type="email" name="email" class="form-control" id="email" placeholder="Enter email" value="${fn:escapeXml(user.email)}" required>
            </div>

            <div class="mb-3 col-sm-5 col-md-6">
                <label for="firstName" class="form-label">First Name</label>
                <input type="text" name="firstname" class="form-control" id="firstName" placeholder="Enter first name" value="${fn:escapeXml(user.firstname)}" required>
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="lastName" class="form-label">Last Name</label>
                <input type="text" name="lastname" class="form-control" id="lastName" placeholder="Enter last name" value="${fn:escapeXml(user.lastname)}" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="tel" name="phone" class="form-control" id="phone" placeholder="Enter phone number" value="${fn:escapeXml(user.phone)}">
            </div>

            <h3>Address</h3>
            <div class="mb-3 col-sm-5 col-md-6">
                <label for="address" class="form-label">Address</label>
                <input type="text" name="street_address" class="form-control" id="address" placeholder="Enter address" value="${fn:escapeXml(user.streetAddress)}">
            </div>

            <div class="mb-3 col-sm-5 col-md-6">
                <label for="city" class="form-label">City</label>
                <input type="text" name="city" class="form-control" id="city" placeholder="Enter city" value="${fn:escapeXml(user.city)}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="state" class="form-label">State</label>
                <input type="text" name="state" class="form-control" id="state" placeholder="Enter state" value="${fn:escapeXml(user.state)}">
            </div>

            <div class="mb-3 col-sm-5 col-md-6">
                <label for="country" class="form-label">Country</label>
                <input type="text" name="country" class="form-control" id="country" placeholder="Enter country" value="${fn:escapeXml(user.country)}">
            </div>

            <div class="mb-3 col-sm-5 offset-sm-2 col-md-6 offset-md-0">
                <label for="postalCode" class="form-label">Postal Code</label>
                <input type="text" name="postalcode" class="form-control" id="postalCode" placeholder="Enter postal code" value="${fn:escapeXml(user.postalcode)}">
            </div>
        </div>
        <br>
        <div class="d-grid gap-2">
            <input type="submit" class="btn btn-primary" style="background-color:#00B207"; value="Submit">
        </div>

        <p class="text-center mt-3">Already Have An Account? <a href="/login.jsp"  style="color: #000;">Log In</a></p>

    </form>
</div>
<br>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
