<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya, @thiyara
  Date: 12/19/2023
  Time: 3:00 AM
--%>
<%@include file="/includes/variables.jsp"%>
<html>
<head>
  <title>WishList - GreenSuperMarket</title>
  <link rel="stylesheet" href="styles.css">
  
  <style>
        table {
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid black;
            padding: 15px ;
            text-align: left;
        }
        button.addToCart {
            background-color: #00B207;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 2px 2px;
            cursor: pointer;
        }
    </style>

</head>
<body>
    <%@include file="/includes/header.jsp"%>
   
    <img src = "/uploads/images/products/Breadcrumbs.png">
<center><br>
                <h3>Wish List</h3>
                <table border="1" width ="70%" >
            <thead>
            <tr>
                <th>PRODUCT  </th>
                <th>PRICE  </th>
                <th><center>ADD TO CART  </center></th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Green Capsicum</td>
                <td>$10.99</td>
                <td><center><button style="background-color: green; color: white; border: none; padding: 5px 10px;
              text-align: center; text-decoration: none; display: inline-block;
                                  font-size: 14px; margin: 2px 2px; cursor: pointer;" onclick="addToCart('Green Capsicum')">Add to Cart</button></center></td>
            </tr>
            <tr>
                <td>Chinese Cabbage</td>
                <td>$40.00</td>
                <td><center><button style="background-color: green; color: white; border: none; padding: 5px 10px;
              text-align: center; text-decoration: none; display: inline-block;
                                  font-size: 14px; margin: 2px 2px; cursor: pointer;" onclick="addToCart('Chinise Cabbage')">Add to Cart</button></center></td>
            </tr>
            <tr>
                <td>Fresh Mango</td>
                <td>$10.00</td>
                <td><center><button style="background-color: green; color: white; border: none; padding: 5px 10px;
              text-align: center; text-decoration: none; display: inline-block;
                                  font-size: 14px; margin: 2px 2px; cursor: pointer;" onclick="addToCart('Fresh Mango')">Add to Cart</button></center></td>
            </tr>
        </tbody>
                </table>

    
              
       <script>
        function addToCart(product) {
            // You can add your cart functionality here
            alert(product + " added to cart!");
        }
    </script>
      
   
                </center>
<div style="margin-top:25px;"></div>
<%@include file="/includes/footer.jsp"%>
</body>
</html>