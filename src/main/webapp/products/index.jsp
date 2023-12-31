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

        .shortDescriptionText {
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2; /* number of lines to show */
        }

        .productNameText {
            min-height: 3rem;
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
      <c:if test="${products.size() > 0}">
            <c:forEach items="${products}" var="product">
                <c:if test="${product.visibility}">
                    <div class="col-lg-3 col-md-4 col-sm-6">
                        <div class="custom-card">
                            <img src="${fn:escapeXml(product.image)}" alt="${fn:escapeXml(product.name)}" class="img-fluid mb-3" style="height: 191px;width: 191px;">
                            <h5 class="productNameText">${fn:escapeXml(product.name)}</h5>
                            <p class="shortDescriptionText" style="font-size: 0.9rem; color: #8f8e8e;">${fn:escapeXml(product.shortDescription)}</p>
                            <c:if test="${product.quantity > 0}">
                                <p class="btn btn-sm btn-white" style="color: #00B207;">IN STOCK</p>
                            </c:if>
                            <c:if test="${product.quantity <= 0}">
                                <p class="btn btn-sm btn-white" style="color: red;">OUT OF STOCK</p>
                            </c:if>
                            <p style="color: #18781e; font-size: 1.2rem;">${product.price} $</p>
                            <c:if test="${product.quantity > 0}">
                                <a href="/products/product.jsp?id=${product.productId}" style="border-radius: 45px;" class="btn btn-sm btn-success">Buy Now</a>
                            </c:if>
                            <c:if test="${product.quantity <= 0}">
                                <a href="/products/product.jsp?id=${product.productId}" style="border-radius: 45px;" class="btn btn-sm btn-success">View</a>
                            </c:if>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
  </div>
</section>
<c:if test="${products.size() <= 0}">
    <div class="align-items-center text-center justify-content-center my-5">
        <img src="/uploads/images/common/not-found.jpeg" class="not-found-img" style="width: 300px;">
        <h3>No Products Found</h3>
    </div>
</c:if>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
