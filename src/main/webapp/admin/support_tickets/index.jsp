<%@ page import="java.util.List" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Order" %>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="com.isiraadithya.greensupermarket.models.SupportTicket" %><%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/includes/variables.jsp"%>
<%
    List<SupportTicket> supportTickets;

    // Order Type Filtering
    boolean isRead;

    if (request.getParameter("markedAsRead") != null){
        switch (request.getParameter("markedAsRead")){
            case "true":
                isRead = true;
                break;
            default:
                isRead = false;
                break;
        }
        supportTickets = SupportTicket.findSupportTickets(isRead);
    } else {
        supportTickets = SupportTicket.findSupportTickets(false);
    }
    System.out.println(supportTickets.size());
    pageContext.setAttribute("tickets", supportTickets);
%>
<html>
<head>
    <title>Manage SupportTickets</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto; /* Center the table */
            border-collapse: collapse;
            text-align: center;

        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;

        }

        th {
            background-color: #f2f2f2;
            font-weight: normal;
            font-size: 17px;

        }


        img {
            max-width: 100%;
            height: auto;
        }

        button {
            padding: 5px 10px;
            cursor: pointer;
        }
        #submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }

        .submitBtn {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 100px;
            cursor: pointer;
            width: 150px;
        }
        .Add-new-button{
            padding: 10px 15px;
            font-size: 23px;
            background-color: #00B207; /* Green background color */
            color: white; /* White text color */
            border: none;
            border-radius: 30px;
            cursor: pointer;
            width: 800px;
        }
        .icon{
            width:30px;
            height:30px;
        }

        .image{
            margin-bottom: 5px;
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

    <div class="my-4 mx-2">
        <h4><b>Filter by Ticket Read Status</b></h4>
        <a class="btn btn-primary btn-sm" href="/admin/support_tickets/?markedAsRead=false">New tickets</a>
        <a class="btn btn-success btn-sm" href="/admin/support_tickets/?markedAsRead=true">Already viewed tickets</a>
    </div>
    <div class="table-responsive">
        <table class="table table-bordered">
            <thead>
            <tr>
                <th>Ticket ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Created At</th>
                <th>Operations</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tickets}" var="ticket">
                <tr>
                    <td>${fn:escapeXml(ticket.ticketId)}</td>
                    <td>${fn:escapeXml(ticket.fullName)}</td>
                    <td>${fn:escapeXml(ticket.email)}</td>
                    <td>${fn:escapeXml(ticket.createdAt)}</td>
                    <td>
                        <a href="/admin/support_tickets/ticket.jsp?id=${ticket.ticketId}"><button class="btn btn-primary btn-sm">View Ticket</button></a>
                        <button onclick="if(confirm('Are you sure?')){document.getElementById('deleteTicket${ticket.ticketId}Form').submit()}" class="btn btn-danger btn-sm">Delete</button>
                        <form id="deleteTicket${ticket.ticketId}Form" method="post" action="/api/admin/support_tickets/delete">
                            <input type="hidden" name="ticketId" value="${ticket.ticketId}">
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table><br><br><br><br>
    </div>
</div>
<%@include file="../includes/footer.jsp"%>
</body>
</html>
