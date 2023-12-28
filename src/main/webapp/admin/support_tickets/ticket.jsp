<%-- 
    Document   : contactUs
    Created on : 15 Dec 2023, 12:29:18
    Author     : @sanuth
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/includes/variables.jsp"%>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@ page import="com.isiraadithya.greensupermarket.models.User" %>
<%@ page import="com.isiraadithya.greensupermarket.models.SupportTicket" %>
<%
  int ticketId = -1;
  SupportTicket ticket;
  try {
    ticketId = Integer.parseInt(request.getParameter("id"));
  } catch (Exception ex){
    response.sendRedirect("/admin/support_tickets/");
    return;
  }

  ticket = SupportTicket.findSupportTicketById(ticketId);
  if (ticket.getTicketId() == -1){
    response.sendRedirect("/admin/support_tickets/");
    return;
  }

  pageContext.setAttribute("ticket", ticket);
%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
    integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
  <style>

    .login-form-container {
      display: flex;
      align-items: center;
      justify-content: center;

    }


    .login-form {
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
        height:10px;
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
<%@include file="../includes/header.jsp"%>
  <div>
    <img src="/uploads/images/products/Breadcrumbs.png" alt="Vege Image" class="image">
  </div>

    <!-- Right Form -->
    <div class="container mb-5">
      <div class="login-form">
        <div class="head mb-4">
          <h3><b>Ticket ID - ${ticket.ticketId}</b></h3>
          <p>Review this support ticket as soon as possible and contact the customer through <a href="mailto:${fn:escapeXml(ticket.email)}">${fn:escapeXml(ticket.email)}</a> if needed.</p>
        </div>

        <div>
          <div class="mb-4">
            <div class="row">
              <div class="col">
                <label>User's Name</label>
                <input type="text" class="form-control" id="Name" name="name" value="${fn:escapeXml(ticket.fullName)}" disabled>
              </div>
              <div class="col">
                <label>User's Email</label>
                  <input type="email" class="form-control" id="Email" name="email" value="${fn:escapeXml(ticket.email)}" disabled>
              </div>
            </div>
          </div>

          <div class="mb-4">
            <label>Date/Time</label>
            <input type="text" class="form-control" value="${fn:escapeXml(ticket.createdAt)}" disabled>
          </div>
          <div class="mb-4">
            <label>Title</label>
            <input type="text" class="form-control" id="title" name="title" value="${fn:escapeXml(ticket.title)}" disabled>
          </div>

          <div>
            <label>Ticket Content / Subject:</label>
            <textarea name="subject" class="form-control" rows="8">${fn:escapeXml(ticket.subject)}</textarea>
          </div>
        </div>

        <div>

          <c:if test="${ticket.read == false}">
            <button onclick="document.getElementById('toggleReadForm').submit()" class="btn btn-primary my-2" type="submit">Mark as Read</button>
          </c:if>
          <c:if test="${ticket.read == true}">
            <button onclick="document.getElementById('toggleReadForm').submit()" class="btn btn-primary my-2" type="submit">Mark as Unread</button>
          </c:if>
          <button onclick="document.getElementById('deleteTicketForm').submit()" type="submit" class="btn btn-danger my-2">Delete</button>

          <form id="toggleReadForm" method="post" action="/api/admin/support_tickets/toggle_read">
            <input type="hidden" name="ticketId" value="${ticket.ticketId}">
          </form>
          <form id="deleteTicketForm" method="post" action="/api/admin/support_tickets/delete">
            <input type="hidden" name="ticketId" value="${ticket.ticketId}">
          </form>
        </div>
      </div>
    </div>

  </div>

  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <%@include file="../includes/footer.jsp"%>
</body>



</html>


