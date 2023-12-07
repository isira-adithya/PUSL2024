<%--
    Document   : login
    Created on : Dec 7, 2023, 21:45:46 PM
    Author     : isira_adithya
--%>
<%
    session.invalidate();
    response.sendRedirect("/");
%>