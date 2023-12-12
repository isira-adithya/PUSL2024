<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/12/2023
  Time: 5:43 PM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    boolean isLoggedIn = (session.getAttribute("isLoggedIn") != null);
    String role = session.getAttribute("role").toString();
    if (!role.equals("ADMIN")){
        session.invalidate();
        response.sendRedirect("/");
        return;
    }
    pageContext.setAttribute("isLoggedIn", isLoggedIn);
%>
