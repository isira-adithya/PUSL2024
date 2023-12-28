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
    pageContext.setAttribute("analyticsSalesByProduct", analyticsSalesByProduct);
    pageContext.setAttribute("analyticsQuantitySoldByProduct", analyticsQuantitySoldByProduct);
%>
<html>
<head>
    <title>Analytics - GreenSuperMarket</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="/includes/styles.css" rel="stylesheet">
    <!-- Include D3.js library -->
    <script src="https://d3js.org/d3.v5.min.js"></script>
</head>
<body>
<%@include file="includes/header.jsp"%>
<section>
<div class="container">
    <h2 class="text-center mt-4" style="font-weight: bold;">Last 5 Months Anallytics</h2>

    <div class="row my-4">

        <!-- Container for Bar Chart -->
        <div class="col-md-6">
            <div class="border p-3">
                <h3 class="text-center">Sales by Products</h3>
                <div id="barChartContainer"></div>
                <div id="barChartLegend" class="mt-3"></div>
            </div>
        </div>

    </div>
</div>
</section>

    <section style="margin-top:100px;">
       <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mp.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/products/" class="card-button">Manage Products</a>
                </div>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mu.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/users" class="card-button">Manage Users</a>
                </div>
            </div>

            <div class="col-lg-4 col-md-4 col-sm-12">
                <div class="custom-card">
                    <img src="/uploads/images/Admin/mo.jpg" alt="" class="img-fluid mb-3 card-img" style="height: 191px; width: 191px;">
                    <h5></h5>
                    <p></p>
                    <a href="/admin/orders/" class="card-button">Manage Orders</a>
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

    // Bar Chart
    const barChartContainer = d3.select('#barChartContainer');
    const barChartWidth = 500;
    const barChartHeight = 300;
    const maxValue = Math.max(...productSales);
    console.log(maxValue)

    const barChart = d3.select('#barChartContainer')
        .append('svg')
        .attr('width', barChartWidth)
        .attr('height', barChartHeight);

    barChart.selectAll('rect')
        .data(productSales)
        .enter()
        .append('rect')
        .attr('x', function (d, i) {
            return i * (barChartWidth / productSales.length * 1.2);
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
        .text(d => d)
        .attr('x', function (d, i) {
            return i * (barChartWidth / productSales.length * 1.2) + (barChartWidth / productSales.length / 2);
        })
        .attr('y', function(d) {
            d = d / (maxValue / barChartHeight + 10);
            return barChartHeight - d - 5;
        })
        .attr('text-anchor', 'middle')
        .attr('fill', 'red');

    // Adding legend to the bar chart
    const barChartLegend = d3.select('#barChartLegend');
    barChartLegend.selectAll('div')
        .data(productCategories)
        .enter()
        .append('div')
        .style('display', 'flex')
        .style('align-items', 'center')
        .style('margin-bottom', '5px')
        .html((d, i) => `<div style="width: 20px; height: 20px; background-color: \${d3.schemeCategory10[i]}; margin-right: 5px;"></div>\${d} - <i class=\"ml-2\"><b>\${productQuantities[i]}</b> Items Sold (<b>\${productSales[i]}\$</b>)</i>`);

</script>

</body>
</html>
