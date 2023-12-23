<%--
  Created by IntelliJ IDEA.
  User: @isira_adithya
  Date: 12/21/2023
  Time: 11:12 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/includes/variables.jsp"%>
<html>
<head>
    <title>Analytics - GreenSuperMarket</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Include D3.js library -->
    <script src="https://d3js.org/d3.v5.min.js"></script>
</head>
<body>
<%@include file="../includes/header.jsp"%>
<div class="container">
    <h1 class="text-center mt-4">Online Shopping Platform Data</h1>

    <div class="row mt-4">

        <!-- Container for Bar Chart -->
        <div class="col-md-6">
            <div class="border p-3">
                <h3 class="text-center">Bar Chart</h3>
                <div id="barChartContainer"></div>
                <div id="barChartLegend" class="mt-3"></div>
            </div>
        </div>

        <!-- Container for Pie Chart -->
        <div class="col-md-6">
            <div class="border p-3">
                <h3 class="text-center">Pie Chart</h3>
                <div id="pieChartContainer"></div>
                <div id="pieChartLegend" class="mt-3"></div>
            </div>
        </div>

    </div>
</div>
<%@include file="../includes/footer.jsp"%>
<script>
    // Sample data for the charts
    const productCategories = ['Electronics', 'Clothing', 'Books', 'Home & Furniture'];
    const productSales = [250, 150, 200, 120];

    // Bar Chart
    const barChartContainer = d3.select('#barChartContainer');
    const barChartWidth = 400;
    const barChartHeight = 300;

    const barChart = d3.select('#barChartContainer')
        .append('svg')
        .attr('width', barChartWidth)
        .attr('height', barChartHeight);

    barChart.selectAll('rect')
        .data(productSales)
        .enter()
        .append('rect')
        .attr('x', (d, i) => i * 100)
        .attr('y', d => barChartHeight - d)
        .attr('width', 80)
        .attr('height', d => d)
        .attr('fill', (d, i) => d3.schemeCategory10[i]);

    // Adding labels to the bars
    barChart.selectAll('text')
        .data(productSales)
        .enter()
        .append('text')
        .text(d => d)
        .attr('x', (d, i) => i * 100 + 40)
        .attr('y', d => barChartHeight - d - 5)
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
        .html((d, i) => `<div style="width: 20px; height: 20px; background-color: \${d3.schemeCategory10[i]}; margin-right: 5px;"></div>\${d}`);

    // Pie Chart
    const pieChartContainer = d3.select('#pieChartContainer');
    const pieChartWidth = 400;
    const pieChartHeight = 300;

    const pieChart = d3.select('#pieChartContainer')
        .append('svg')
        .attr('width', pieChartWidth)
        .attr('height', pieChartHeight)
        .append('g')
        .attr('transform', `translate(${pieChartWidth / 2},${pieChartHeight / 2})`);

    const pie = d3.pie();
    const arc = d3.arc().innerRadius(0).outerRadius(pieChartWidth / 2);

    const pieData = pie(productSales);

    // Adding labels and tooltips to the pie chart
    const arcs = pieChart.selectAll('path')
        .data(pieData)
        .enter()
        .append('path')
        .attr('d', arc)
        .attr('fill', (d, i) => d3.schemeCategory10[i])
        .attr('stroke', 'white')
        .attr('stroke-width', 2)

    // Adding legend to the pie chart
    const pieChartLegend = d3.select('#pieChartLegend');
    pieChartLegend.selectAll('div')
        .data(productCategories)
        .enter()
        .append('div')
        .style('display', 'flex')
        .style('align-items', 'center')
        .style('margin-bottom', '5px')
        .html(function (d, i) {
            return `<div style="width: 20px; height: 20px; background-color: \${d3.schemeCategory10[i]}; margin-right: 5px;"></div>\${d}`;
        });

</script>

</body>
</html>
