<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/9/2023
  Time: 11:58 PM
--%>
<%@ page import="com.isiraadithya.greensupermarket.models.Product" %>
<%@ page import="com.isiraadithya.greensupermarket.models.Comment" %>
<%@ page import="java.util.List" %>
<%@include file="/includes/variables.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = -1;
    Product product;

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
        product = Product.findProductById(id);
        if (product.getName().equals("NULL")){
            response.sendRedirect("/products/");
            return;
        }
    } else {
        response.sendRedirect("/products/");
        return;
    }

    // Loading comments
    List<Comment> comments = Comment.findCommentsByProductId(id);

    // Loading data to pageContext
    pageContext.setAttribute("product", product);
    pageContext.setAttribute("comments", comments);
    pageContext.setAttribute("userId", session.getAttribute("userId"));
%>
<html>
<head>
    <title>${fn:escapeXml(product.name)} - Green SuperMarket</title>
    <style>
        #comments {
            max-width: 600px;
            margin: 20px;
        }

        .comment {
            margin-bottom: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .commenter {
            font-weight: bold;
        }

        #commentInput {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            box-sizing: border-box;
        }

        #submitBtn {
            padding: 8px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        #submitBtn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%@include file="../includes/header.jsp"%>
    <div>
        <img width="500px" src="${fn:escapeXml(product.image)}">
        <p><b>Product Name: </b>${fn:escapeXml(product.name)}</p>
        <p><b>Product Description: </b>${fn:escapeXml(product.description)}</p>
        <p><b>Product Price: </b>${product.price}$</p>
        <p><b>Product Quantity: </b>${product.quantity}</p>
    </div>
    <div>
        <br>
        <form action="/api/user/cart/addItem" method="post">
            <label>Quantity:</label>
            <input type="number" name="quantity" inputmode="numeric" value="1" min="1" max="${product.quantity}">
            <input type="hidden" name="productId" value="${product.productId}">
            <input type="submit" value="Add to cart">
        </form>
    </div>
    <br>
    <br>
    <c:if test="${comments.size() > 0}">
        <div id="comments">
            <h3>Comments</h3>
            <c:forEach items="${comments}" var="comment">
                <div class="comment">
                    <div class="commenter">${fn:escapeXml(comment.user.fullName)}</div>
                    <div class="comment-text">${fn:escapeXml(comment.content)}</div>
                    <c:if test="${userId == comment.user.userId}">
                        <form action="/api/user/comments/delete" method="post">
                            <br>
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                            <input type="submit" value="Delete Comment">
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${comments.size() <= 0}">
        <div id="comments">
            <p>No Comments Found.</p>
        </div>
    </c:if>
    <c:if test="${userId != null}">
        <div>
            <form method="post" action="/api/user/comments/add">
                <input type="hidden" name="productId" value="${product.productId}">
                <textarea id="commentInput" placeholder="Add your comment..." name="comment"></textarea>
                <input id="submitBtn" type="submit" value="Submit">
            </form>
        </div>
    </c:if>
    <%@include file="../includes/footer.jsp"%>
</body>
</html>
