<%-- 
    Document   : index
    Created on : Dec 6, 2023, 10:10:22 PM
    Author     : isira_adithya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! public static int visitor_count = 0; %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        This page has been visited <i><b><%= ++visitor_count %></b></i> times.
    </body>
</html>
