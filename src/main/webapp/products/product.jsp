<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya,@sanuth
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
<!DOCTYPE html>
<html>
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
<style>
     
        h2 {
            margin-bottom: 20px;
        }
        .btn {
             height: 40px;
             width: 450px;
             border-radius: 100px;
             color: #ffffff;
             background-color: #00b207;
             margin-left: 40px;
        }
        
        .Deletebutton {
             height: 40px;
             width: 80px;
             border-radius: 100px;
             color: #ffffff;
             background-color: #DBDCDE;
             border: none; /* Remove the border */
             outline: none; /* Remove the outline */
             cursor: pointer;
             margin-top: 1px; /* Adjust as needed */
             margin-bottom: 30px;
             
}   

        /* Add style for the new comment container */
        .comment-container {
            
            text-align: left;
            margin-top: 20px; /* Adjust as needed */
            margin-bottom: 20px; /* Adjust as needed */
            max-height: 500px; /* Adjust the maximum height as needed */
            overflow-y: auto;
        }

        .comment-heading {
            text-align: center;
            margin-bottom: 10px;
        }
        hr{
          border-color: #2C742F;
        }
        .icon {
            width: 20px; /* Set the width of the icon */
             height: 20px; /* Set the height of the icon */
             margin-left: 5px; /* Adjust the margin as needed */
        }
        
         #commentInput {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-bottom: 10px;
        box-sizing: border-box;
        resize: vertical; /* Allow vertical resizing */
    }

    #submitBtn {
        padding: 10px 15px;
        font-size: 16px;
        background-color: #4CAF50; /* Green background color */
        color: white; /* White text color */
        border: none;
        border-radius: 100px;
        cursor: pointer;
        width: 100px;
    }

    #submitBtn:hover {
        background-color: #45a049; /* Darker green on hover */

      

        
    
    </style>
    
</head>
<body>
    
   
    <div >
        <img src="\uploads\images\products\Breadcrumbs.png" alt="Vege Image" class="image">
    </div>
    
<div class="container mt-5">
  <div class="row">
    <!-- Image on the left -->   
   <div class="col-md-5">
      <img src="${fn:escapeXml(product.image)}" alt="Product Image" class="img-fluid">
    </div>
    
    <!-- Description and prices on the right -->
    <div class="col-md-7">
      <h2>${fn:escapeXml(product.name)}</h2>
      <h5 style="color:#2C742F;">${fn:escapeXml(product.price)}</h5>
      
      <hr>
      <p>${fn:escapeXml(product.description)}</p>
    
      <hr>       
        <c:if test="${userId != null}">
            <form action="/api/user/cart/addItem" method="post">
                <input type="number" name="quantity" inputmode="numeric" value="1" min="1" max="${product.quantity}">
                <input type="hidden" name="productId" value="${product.productId}">
                 <button type="submit" class="btn btn-outline" style="position: relative;">
                    Add to Cart
                </button>

            </form>
        </c:if>
    </div>              
  </div>
      <br><br><br><br>
      
   <div class="row">
    <div class="col-md-12 comment-heading">
      <h2>Comments Section</h2> <br>
    </div>
  </div>   
      
    
      
  <div class="row">
    <c:if test="${comments.size() > 0}">
        <div id="comments" class="col-md-8 mx-auto comment-container">
            <c:forEach items="${comments}" var="comment">
                <div class="col-md-12">
                    <div>
                        <p><strong>${fn:escapeXml(comment.user.fullName)}<br><br></strong>${fn:escapeXml(comment.content)} .</p>
                        <hr>
                    </div>
                    <c:if test="${userId == comment.user.userId}">
                        <form action="/api/user/comments/delete" method="post">
                            <input type="hidden" name="commentId" value="${comment.commentId}">
                           <button type="submit" class="Deletebutton">
                                <!-- delete icon -->
                                <img src="\uploads\images\navbar\delete.png" alt="delete icon" class="icon">
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>
    </c:if>
    <c:if test="${comments.size() <= 0}">
        <div id="comments" class="col-md-8 mx-auto comment-container">
            <p>No Comments Found.</p>
        </div>
    </c:if>
    <c:if test="${userId != null}">
        <div class="col-md-8 mx-auto">
            <form method="post" action="/api/user/comments/add">
                <input type="hidden" name="productId" value="${product.productId}"><br><br><br><br><h3>Add a comment!<h3> <br>              
                <textarea id="commentInput" placeholder="Add your comment..." name="comment"></textarea>
                    <input id="submitBtn" type="submit" value="Submit">
            </form>
        </div>
    </c:if>
  </div>
</div>
    <%@include file="../includes/footer.jsp"%>

      

    
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
