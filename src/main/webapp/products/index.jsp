<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 12/9/2023
  Time: 9:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.helpers.XSSPreventor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String searchQuery = "";
    String msg = "";
    List<Product> products = new ArrayList<Product>();

    if (request.getParameterMap().containsKey("msg")){
        msg = request.getParameter("msg");
    }

    if (request.getParameterMap().containsKey("searchQuery")){
        searchQuery = request.getParameter("searchQuery");
    }

    if (searchQuery.isBlank()){
        products = Product.getProducts();
    } else {
        products = Product.findProductsByName(searchQuery);
    }

    if (products.size() <= 0){
        response.sendRedirect("/products/?msg=No Products Found");
        return;
    }

    pageContext.setAttribute("products", products);
    pageContext.setAttribute("searchQuery", searchQuery);
    pageContext.setAttribute("msg", msg);
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Products - GreenSuperMarket</title>
    <link href="/includes/styles.css" rel="stylesheet">
    <style>
        .banner-image{
            max-width: 100%;
        }
        
    </style>
</head>
<body>
<%@include file="/includes/header.jsp"%>
    
<section class="d-flex justify-content-center align-items-center">
    <div>
        <img src="/uploads/images/products/vegBanner.png" alt="veg banner" class="banner-image">
    </div>
</section>

<section >  
  <div class="container mt-4"> 
    <div class="row">
      <c:forEach items="${products}" var="product">
          <c:if test="${product.visibility}">
              <div class="col-lg-3 col-md-4 col-sm-6">
                  <div class="custom-card">
                      <img src="${fn:escapeXml(product.image)}" alt="${fn:escapeXml(product.name)}" class="img-fluid mb-3" style="height: 191px;width: 191px;">
                      <h5>${fn:escapeXml(product.name)}</h5>
                      <p class="card-text">${fn:escapeXml(product.shortDescription)}</p>
                      <p>${product.price}$</p>
                      <a href="/products/product.jsp?id=${product.productId}" class="card-button">Buy Now</a>
                  </div>
              </div>
          </c:if>
      </c:forEach>
    </div>
  </div>
</section>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
