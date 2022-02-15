<%-- 
    Document   : main
    Created on : Jan 3, 2022, 8:54:52 PM
    Author     : fauzi
--%>

<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="rewardsDatasource" 
                   driver="org.apache.derby.jdbc.ClientDriver" 
                   url="jdbc:derby://localhost:1527/RewardsDB" 
                   user="rewardsapp"
                   password="rewardsapp"/>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="style/web.css">
        <title>Performance Rewards System</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>

    <body>
        <% if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
                response.sendRedirect("login.jsp");
            }
        %>

        <h1>Performance Rewards</h1>

        <sql:query var="result" dataSource="${rewardsDatasource}">
            SELECT  c.reward_name AS "Reward", 
            c.description AS "Description",
            c.category AS "Category",
            c.total AS "Total",
            (SELECT COALESCE(SUM(o.amount), 0)
            FROM REWARDSAPP.REWARDS_CLAIMED o
            WHERE o.REWARD_ID = c.REWARD_ID) AS "Claimed",
            c.total - (SELECT COALESCE(SUM(o.amount), 0)
            FROM REWARDSAPP.REWARDS_CLAIMED o
            WHERE o.REWARD_ID = c.REWARD_ID) AS "Available"
            FROM REWARDSAPP.REWARDS c 
            WHERE c.status = 'active' 
            ORDER BY reward_id ASC
        </sql:query>

        <sql:query var="result2" dataSource="${rewardsDatasource}">
            SELECT EMPLOYEE_NAME AS "Staff Name",
            COUNT(CLAIM.CLAIM_ID) AS "Number of Claim Request",
            SUM(REWARDS_CLAIMED.AMOUNT) AS "Total Rewards Claimed"
            FROM EMPLOYEE
            LEFT JOIN CLAIM ON CLAIM.EMPLOYEE_ID = EMPLOYEE.EMPLOYEE_ID
            LEFT JOIN REWARDS_CLAIMED ON CLAIM.CLAIM_ID = REWARDS_CLAIMED.CLAIM_ID
            GROUP BY EMPLOYEE_NAME
        </sql:query>

        <div class="web-top">
            <div class="web-bar web-white web-wide web-padding web-card" style="background-color:#D3D3D3 !important; font-size: 80% !important">
                Welcome <b><%=session.getAttribute("name")%></b>
                <div class="web-right web-hide-small">
                    <a href="logoutServlet" class="web-bar-item web-button">Logout</a>
                </div>
            </div><!--
        </div>
        <div>-->
            <c:set var="role" value="<%= session.getAttribute("role")%>"/>
            <c:set var="admin" value="admin"/>
            <c:set var="staff" value="staff"/>

            <div class="web-bar web-white web-wide web-padding web-card">
                <a href="#" class="web-bar-item web-button"><b>Dashboard</b></a>
                <div class="web-right web-hide-small">
                    <a href="main.jsp" class="web-bar-item web-button"><b>Rewards</b> Catalogue</a>
                </div>
            </div>
        </div>

        <!-- Header -->
        <header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">

            <img class="web-image" src="images/rewards.jpg" alt="Rewards" width="1500" height="800">
            <div class="web-display-middle web-margin-top web-center">
                <h1 class="web-xxlarge web-text-white"><span class="web-padding web-black web-opacity-min"><b>Reports &amp; Dashboard</b></span> <span class="web-hide-small web-text-light-grey"></span></h1>
            </div>
        </header>

        <!-- Page content -->
        <div class="web-content web-padding" style="max-width:1564px">

            <!-- Vouchers Section -->
            <div class="web-container web-padding-32" id="vouchers">

                <h3 class="web-border-bottom web-border-light-grey web-padding-16">Dear <%=session.getAttribute("name")%>,</h3>
                <p>This page is to give you an overview of rewards, claims and employee data from the system.
                </p>
            </div>

            <div class="web-row-padding">      
                <h3 class="web-border-light-grey web-padding-8"><b>Active Vouchers</b></h3>                
                <table class="web-table-all" style="width:100%">
                    <!-- column headers -->
                    <tr>
                        <c:forEach var="columnName" items="${result.columnNames}">
                            <th><c:out value="${columnName}"/></th>
                            </c:forEach>
                    </tr>
                    <!-- column data -->
                    <c:forEach var="row" items="${result.rowsByIndex}">
                        <tr>
                            <c:forEach var="column" items="${row}">
                                <td><c:out value="${column}"/></td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>

            </div>
            <c:if test="${role eq admin}">
                <p align="right"><button id="insBtn" style="width: 200px" class="web-button web-light-grey web-block" onclick="modalInsertVoucher()">Insert New Voucher</button></p>
                <br/></c:if>
                <div class="web-row-padding">  

                    <h3 class="web-border-light-grey web-padding-8"><b>Employee Claim Summary</b></h3>
                    <table class="web-table-all" style="width:100%">
                        <!-- column headers -->
                        <tr>
                        <c:forEach var="columnName" items="${result2.columnNames}">
                            <th><c:out value="${columnName}"/></th>
                            </c:forEach>
                    </tr>
                    <!-- column data -->
                    <c:forEach var="row" items="${result2.rowsByIndex}">
                        <tr>
                            <c:forEach var="column" items="${row}">
                                <td><c:out value="${column}"/></td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>

                <div id='reward' name='reward'></div>
                <div id='description' name='description'></div>
                <div id='category' name='category'></div>
                <div id='totalvoucher' name='totalvoucher'></div>
                <div id='totalclaimed' name='totalclaimed'></div>
                <div id='available' name='available'></div>
                <div id='name' name='name'></div>
                <div id='totalrequest' name='totalrequest'></div>
                <div id='totalamount' name='totalamount'></div>
                <div id='message' name='message'></div>

                <!-- Image of rewards -->
                <div class="web-container">
                    <img src="images/rewards3.jpg" class="web-image" style="width:100%">
                </div>

                <!-- End page content -->
            </div>

            <!-- Footer -->
            <footer class="web-center web-black web-padding-16">
                <p>CSC584 Group Project, Employee Reward Management System (Group 3)</p>
            </footer>
            <script type="text/javascript">

                document.addEventListener("visibilitychange", function () {
                    if (document.hidden) {
                        console.log("Browser tab is hidden");
                    } else {
                        console.log("Browser tab is visible");

                        location.reload();
                    }
                });

                function modalInsertVoucher() {
                    var myWindow = window.open("/PerformanceRewards/insertVoucher.jsp", "_blank", "toolbar=no,scrollbars=no,resizable=no,top=200,left=200,width=800,height=500");
                }
            </script>
    </body>
</html>