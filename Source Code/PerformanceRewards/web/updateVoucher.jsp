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
        <title>Update Vouchers</title>
    </head>
    <body>
        <% if (session.getAttribute("login") == null || session.getAttribute("login") == "") {
                response.sendRedirect("login.jsp");
            }
        %>
        <h1><a href="#home" class="web-bar-item web-button"><b>Update</b> Vouchers</a></h1>
        
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
            SELECT reward_id AS "Id", reward_name AS "Name", 
            description AS "Description", 
            image AS "Image",
            category AS "Category", 
            total as "Total" FROM REWARDSAPP.REWARDS
            WHERE reward_id = <%= request.getParameter("id") %>
        </sql:query>
            
        <form action = "updateVoucherServlet" method = "POST">
            <table><c:forEach var="row" items="${result.rows}">
                <tr>
                    <td></td>
                    <td><input type = "text" name = "id" value="${row.Id}" hidden /></td>
                </tr>
                <tr>
                    <td><div class="web-container web-padding-small">Name </div></td>
                    <td><input type = "text" name = "name" value = "${row.Name}" required /></td>
                </tr>
                <tr>
                    <td><div class="web-container web-padding-small">Description </div></td>
                    <td><textarea type = "text" name = "description" value = "${row.Description}" rows = "4" cols = "50">${row.Description}</textarea></td>
                </tr>
                    <tr>
                        <td><div class="web-container web-padding-small">Image </div></td>
                        <td><img src="${row.Image}" alt="Vouchers" style="width:50%"></td>
                    </tr>
                <tr>
                    <td></td>
                    <td><input type = "hidden" name = "total" value="${row.Total}" hidden /></td>
                </tr>
                <tr>
                    <td><div class="web-container web-padding-small">Add Stock </div></td>
                    <td><input type = "number" name = "additional" value="0" min="0" max="100" onkeydown="return false" /></td>
                </tr>
                <tr>
                    <td><input type = "hidden" name = "category" value = "${row.Category}" /></td>
                </tr>
                <tr></c:forEach>
                    <td colspan="2"><input class="web-button web-grey web-block" id="btnUpdateVoucher" name = "btnUpdateVoucher" type = "submit" value = "Update" /></td>
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
