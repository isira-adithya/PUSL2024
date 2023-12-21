<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/10/2023
  Time: 3:11 PM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    boolean isLoggedIn = (session.getAttribute("isLoggedIn") != null);
    boolean isAdmin = (session.getAttribute("role") == "ADMIN");
    pageContext.setAttribute("isLoggedIn", isLoggedIn);
    pageContext.setAttribute("isAdmin", isAdmin);
%>
