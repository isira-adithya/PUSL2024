<%@ page import="com.isiraadithya.greensupermarket.models.Analytics" %>
<%@ page import="java.util.Map" %>
<%@include file="/includes/variables.jsp"%>
<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/21/2023
  Time: 11:12 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Analytics analyticsObj = new Analytics(150);
    Map<String, Double> analyticsSalesByProduct = analyticsObj.getSalesByProduct();
    Map<String, Integer> analyticsQuantitySoldByProduct = analyticsObj.getQuantitySoldByProduct();
    Map<String, Integer> orderStatuses = analyticsObj.getOrderStatuses();
    pageContext.setAttribute("analyticsSalesByProduct", analyticsSalesByProduct);
    pageContext.setAttribute("analyticsQuantitySoldByProduct", analyticsQuantitySoldByProduct);
    pageContext.setAttribute("orderStatuses", orderStatuses);
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - GreenSuperMarket</title>
      
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="/includes/styles.css" rel="stylesheet">
    <!-- Include D3.js library -->
    <script src="https://d3js.org/d3.v5.min.js"></script>
    <style>
        
        .image{
            margin-bottom: 5px;
            width: 100%;
            height: 120px;
            position: relative;
            background: linear-gradient(90deg, rgba(0, 0, 0, 0.70) 0%, rgba(0, 0, 0, 0) 100%);
        }      
    </style>
</head>

<body>
    
<%@include file="includes/header.jsp"%>

<section>
<div class="container">
    <h2 class="text-center mt-4" style="font-weight: bold;">Last 5 Months Analytics</h2>

    <div class="row my-4">

        <!-- Container for Bar Chart -->
        <div class="col-md-6">
            <div class="border p-3">
                <h4 class="text-center">Sales by Products</h4>
                <div id="salesByProductBarchartContainer"></div>
                <div id="salesByProductBarchartLegend" class="mt-3"></div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="border p-3">
                <h4 class="text-center">Status of Orders</h4>
                <div id="statusOfOrdersBarchartContainer"></div>
                <div id="statusOfOrdersBarchartLegend" class="mt-3"></div>
            </div>
        </div>

    </div>
</div>
</section>

    <section style="margin-top:100px; margin-bottom: 50px;">
       <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mp.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/products/" class="card-button">Manage Products</a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mu.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/users" class="card-button">Manage Users</a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mo.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/orders/" class="card-button">Manage Orders</a>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mt.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/support_tickets" class="card-button">Manage Tickets</a>
                </div>
            </div>
            
        </div>
    </div>
    </section>


<%@include file="../includes/footer.jsp"%>
<script>
    const productCategories = [
        <c:forEach var="analyticSalesByProductObj" items="${analyticsSalesByProduct}">
         '${fn:escapeXml(analyticSalesByProductObj.key.replaceAll("\'", ""))}',
        </c:forEach>
    ];
    const productSales = [<c:forEach var="analyticSalesByProductObj" items="${analyticsSalesByProduct}">
        ${fn:escapeXml(analyticSalesByProductObj.value)},
        </c:forEach>];
    const productQuantities = [<c:forEach var="analyticQuantitySoldByProductObj" items="${analyticsQuantitySoldByProduct}">
        ${fn:escapeXml(analyticQuantitySoldByProductObj.value)},
        </c:forEach>];
    const orderStatusTypes = [
        <c:forEach var="orderStatus" items="${orderStatuses}">
        '${fn:escapeXml(orderStatus.key.replaceAll("\'", ""))}',
        </c:forEach>
    ];
    const orderStatusIndexes = [
        <c:forEach var="orderStatus" items="${orderStatuses}">
        ${fn:escapeXml(orderStatus.value)},
        </c:forEach>
    ];

    // Bar Chart
    const barChartContainer = d3.select('#salesByProductBarchartContainer');
    const barChartWidth = 500;
    const barChartHeight = 300;
    const maxValue = Math.max(...productSales);
    console.log(maxValue)

    const barChart = d3.select('#salesByProductBarchartContainer')
        .append('svg')
        .attr('width', barChartWidth)
        .attr('height', barChartHeight);

    barChart.selectAll('rect')
        .data(productSales)
        .enter()
        .append('rect')
        .attr('x', function (d, i) {
            return i * (barChartWidth / productSales.length * 1.1);
        })
        .attr('y', function (d){
            d = d / (maxValue / barChartHeight + 10);
            return barChartHeight - d;
        })
        .attr('width', (barChartWidth / productSales.length))
        .attr('height', function(d) {
            d = d / (maxValue / barChartHeight + 10);
            return d;
        })
        .attr('fill', (d, i) => d3.schemeCategory10[i]);

    // Adding labels to the bars
    barChart.selectAll('text')
        .data(productSales)
        .enter()
        .append('text')
        .text(function (d) {
            d = (Math.round(parseFloat(d) * 100) / 100).toFixed(2);
            return d;
        })
        .attr('x', function (d, i) {
            return i * (barChartWidth / productSales.length * 1.1) + (barChartWidth / productSales.length / 4);
        })
        .attr('y', function(d) {
            d = d / (maxValue / barChartHeight + 10);
            return barChartHeight - d - 5;
        })
        .attr('text-anchor', 'middle')
        .attr('fill', 'red');

    // Adding legend to the bar chart
    const barChartLegend = d3.select('#salesByProductBarchartLegend');
    barChartLegend.selectAll('div')
        .data(productCategories)
        .enter()
        .append('div')
        .style('display', 'flex')
        .style('align-items', 'center')
        .style('margin-bottom', '5px')
        .html((d, i) => `<div style="width: 20px; height: 20px; background-color: \${d3.schemeCategory10[i]}; margin-right: 5px;"></div>\${d} - <i class=\"ml-2\"><b>\${productQuantities[i]}</b> Items Sold (<b>\${(Math.round(parseFloat(productSales[i]) * 100) / 100).toFixed(2)}\$</b>)</i>`);

</script>
</body>
</html>
