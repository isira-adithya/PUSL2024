<%@include file="includes/variables.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
</head>
<body>
<%@include file="includes/header.jsp"%>
<%@include file="includes/footer.jsp"%>
<%
    response.sendRedirect("/admin/products");
%>
</body>
</html>