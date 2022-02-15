<%-- 
    Document   : Update
    Created on : Dec 19, 2021, 9:44:10 AM
    Author     : fauzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<sql:setDataSource var="rewardsDatasource" 
                   driver="org.apache.derby.jdbc.ClientDriver" 
                   url="jdbc:derby://localhost:1527/RewardsDB" 
                   user="rewardsapp"
                   password="rewardsapp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="style/web.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <title>Claim Vouchers</title>
    </head>
    <body>
                    <% if(session.getAttribute("login") == null || session.getAttribute("login") == "") {
            response.sendRedirect("login.jsp");
        }
        %>
        
        <h1><a href="#home" class="web-bar-item web-button"><b>Claim</b> Vouchers</a></h1>
        
<header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">
  <img class="web-image" src="images/rewards2.png" alt="Rewards" width="auto" height="auto" style="-webkit-filter: blur(5px); filter: blur(5px); filter: opacity(20%);">
  <div class="web-display-middle web-margin-top web-left" style="height: 400px;">

        <c:set var="id" value="${param.id}" />
        <c:set var="name" value="${param.name}" />
        <c:set var="description" value="${param.description}" />
        <c:set var="image" value="${param.image}" />
        <c:set var="category" value="${param.category}" />
        <c:set var="total" value="${param.total}" />
        
        <sql:query var="result" dataSource="${rewardsDatasource}">
            SELECT c.reward_id AS "Id", 
            c.reward_name AS "Name", 
            c.description AS "Description", 
            c.image AS "Image",
            c.category AS "Category", 
            c.total as "Total", 
            (SELECT COALESCE(SUM(o.amount), 0)
            FROM REWARDSAPP.REWARDS_CLAIMED o
            WHERE o.REWARD_ID = c.REWARD_ID) AS "Claimed"
            FROM REWARDSAPP.REWARDS c
            WHERE reward_id = <%= request.getParameter("id") %>
        </sql:query>
            
        <c:set var="voucher" value="voucher"/>
        <c:set var="staycation" value="staycation"/>
        
        <form action = "claimVoucherServlet" method = "POST">
            <table><c:forEach var="row" items="${result.rows}">
                <tr>
                    <td></td>
                    <td><input type = "text" name = "id" value="${row.Id}" hidden /></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><h2 class="web-container web-padding-small">${row.Name}</h2></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><h3 class="web-container web-padding-small">${row.Description}</h3></td>
                </tr>
                    <tr>
                        <td colspan="2" align="center"><img src="${row.Image}" alt="Vouchers" style="width:80%"></td>
                    </tr>
                <tr>
                    <td></td>
                    <td><input type = "hidden" name = "total" value="${row.Total}" hidden /></td>
                </tr>
                <tr>
                    <td><div class="web-container web-padding-small">Claim </div></td>
            <c:if test="${row.Category eq voucher}">
                    <td><input type = "number" name = "amountV" value="0" min="0" max="${row.Total - row.Claimed}" onkeydown="return false"/></td>
                    </c:if>
            <c:if test="${row.Category eq staycation}">
                    <td><input type = "number" name = "amountS" value="0" min="0" max="1" onkeydown="return false"/></td>
                    </c:if>
                </tr>
                <tr>
                    <td><input type = "hidden" name = "category" value = "${row.Category}" /></td>
                    <td><input type = "hidden" name = "empid" value = "<%=session.getAttribute("id") %>" /></td>
                </tr>
                <tr></c:forEach>
                    <td colspan="2"><input class="web-button web-grey web-block" id="btnClaimVoucher" name = "btnClaimVoucher" type = "submit" value = "Claim" /></td>
                </tr>
            </table>
        </form>

            <p><button class="web-button web-grey web-block" onclick="window.close()">Close</button></p></div>
</header> 
    <script type="text/javascript">
                window.onunload = refreshParent;
        function refreshParent() {
            window.opener.location.reload();
        }
        
    </script>
</body>
</html>
