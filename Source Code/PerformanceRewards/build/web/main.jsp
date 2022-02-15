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
            SELECT  c.reward_id AS "ID", 
            c.reward_name AS "Reward", 
            c.description AS "Description",
            c.image AS "Image",
            c.category AS "Category",
            c.total AS "Total",
            (SELECT COALESCE(SUM(o.amount), 0)
            FROM REWARDSAPP.REWARDS_CLAIMED o
            WHERE o.REWARD_ID = c.REWARD_ID) AS "Claimed"
            FROM REWARDSAPP.REWARDS c 
            WHERE c.status = 'active' 
            ORDER BY reward_id ASC
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
                <a href="#home" class="web-bar-item web-button"><b>Rewards</b> Catalogue</a>
                <div class="web-right web-hide-small">
                    <c:if test="${role eq staff}">
                        <a href="#vouchers" class="web-bar-item web-button">Vouchers & Tickets</a></c:if>
                    <c:if test="${role eq admin}">
                    <a href="dashboard.jsp" class="web-bar-item web-button">Dashboard</a></c:if>
                </div>
            </div>
        </div>

        <!-- Header -->
        <header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">

            <img class="web-image" src="images/rewards4.jpeg" alt="Rewards" width="1500" height="800">
            <div class="web-display-middle web-margin-top web-center">
                <h1 class="web-xxlarge web-text-white"><span class="web-padding web-black web-opacity-min"><b>Rewards Catalogue</b></span> <span class="web-hide-small web-text-light-grey"></span></h1>
            </div>
        </header>
       
        <!-- Page content -->
        <div class="web-content web-padding" style="max-width:1564px">

            <!-- Vouchers Section -->
            <div class="web-container web-padding-32" id="vouchers">

                <h3 class="web-border-bottom web-border-light-grey web-padding-16">Dear <%=session.getAttribute("name")%>,</h3>
                <c:if test="${role eq admin}">
                <p>This system is build for Human Resources Department, Rewards and Recognition Division. It is meant for Administrator to update available claimable rewards such as vouchers,
                    tickets and promotional deals. Please ensure to contents are updated so the information for staff is accurate.
                </p></c:if>
                <c:if test="${role eq staff}">
                <p>Congratulations! This system is for Perppermint Co staff to claim their performance rewards. Please choose from the list of vouchers and retreat package below.
                   Each staff is allowed to claim maximum available units per vouchers per claim but only 1 unit per retreat package per claim.
                </p></c:if>
            </div>
            <c:if test="${role eq admin}">
                <p align="center"><button id="insBtn" style="width: 200px" class="web-button web-light-grey web-block" onclick="modalInsertVoucher()">Insert New Voucher</button></p>
                <br/></c:if>
                <div class="web-row-padding">      
                <c:set var="numCols" value="4"/>
                <c:set var="numRows" value="4"/>
                <c:set var="rowCount" value="0"/>
                <table>
                    <tr>

                        <c:forEach var="row" items="${result.rowsByIndex}" varStatus="status"> 
                            <c:if test="${rowCount lt numRows}">
                                <td>
                                    <c:forEach var="column" items="${row[3]}"><img src=<c:out value="${column}"/> alt="Vouchers" style="width:100%"></c:forEach>
                                    <h3><c:forEach var="column" items="${row[1]}">${column}</c:forEach></h3>
                                    <p class="web-opacity"><c:forEach var="column" items="${row[2]}">${column}</c:forEach></p>
                                    <p class="web-opacity"><c:forEach var="column" items="${(row[5]-row[6]).toString()}">Available: ${column}</c:forEach></p>
                                    <button class="web-button web-light-grey web-block" onclick="window.open('/PerformanceRewards/claimVoucher.jsp?id=${row[0]}', '_blank', 'toolbar=no,scrollbars=no,resizable=no,top=500,left=200,width=800,height=700')">Claim</button>
                                    <c:if test="${role eq admin}">    
                                        <button id="updBtn" style=" margin-top:5px;" class="web-button web-light-grey web-block" onclick="window.open('/PerformanceRewards/updateVoucher.jsp?id=${row[0]}', '_blank', 'toolbar=no,scrollbars=no,resizable=no,top=500,left=200,width=800,height=600')">Update Vouchers</button>
                                        <button id="delBtn" style=" margin-top:5px;" class="web-button web-light-grey web-block" data-confirm="Are you sure?" onclick="window.open('/PerformanceRewards/deleteVoucher.jsp?id=${row[0]}', '_blank', 'toolbar=no,scrollbars=yes,resizable=no,top=200,left=200,width=800,height=600')">Delete Vouchers</button>
                                    </c:if>
                                </td>
                                <c:if test="${status.count ne 0 && status.count % numCols == 0}">
                                    <c:set var="rowCount" value="${rowCount + 1}"/>
                                </tr><tr>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </tr>
                </table></div>

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

//$(document).ready(function() {
//    var role = "<%= session.getAttribute("role")%>";
//           if(role != "admin") {
//               document.getElementById("insBtn").style.display = "none";
//               document.getElementById("updBtn").style.display = "none";
//               document.getElementById("delBtn").style.display = "none";
//           }
//});

            function modalInsertVoucher() {
                var myWindow = window.open("/PerformanceRewards/insertVoucher.jsp", "_blank", "toolbar=no,scrollbars=no,resizable=no,top=200,left=200,width=800,height=500");
            }
            function modalUpdateVoucher() {
                var myWindow = window.open("/PerformanceRewards/updateVoucher.jsp?id=" + myId, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=1200,height=800");
            }
            function modalDeleteVoucher() {
                var myWindow = window.open("/PerformanceRewards/deleteVoucher.jsp" + myId, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=1200,height=800");
            }
        </script>
    </body>
</html>