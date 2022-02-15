<%-- 
    Document   : empForm
    Created on : Jan 8, 2022, 1:21:03 PM
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
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="style/web.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <title>Insert Vouchers</title>
    </head>
    <body>
        <h1><a href="#home" class="web-bar-item web-button"><b>Insert</b> Vouchers</a></h1>

        <header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">
            <img class="web-image" src="images/rewards2.png" alt="Rewards" width="auto" height="auto" style="-webkit-filter: blur(5px); filter: blur(5px); filter: opacity(20%);">
            <div class="web-display-middle web-margin-top web-left">

                <form action = "insertVoucherServlet" method = "POST" enctype="multipart/form-data">
                    <table>
                        <tr>
                            <td><input type = "hidden" name = "id" /></td>
                        </tr>
                        <tr>
                            <td><div class="web-container web-padding-small">Name </div></td>
                            <td><input type = "text" name = "name" required /></td>
                        </tr>
                        <tr>
                            <td><div class="web-container web-padding-small">Description </div></td>
                            <td><textarea type = "text" name = "description" value = "${row.Description}" rows = "4" cols = "50">${row.Description}</textarea></td>
                        </tr>
                        <tr>
                            <td><input type = "hidden" name = "image" /></td>
                        </tr>
                        <tr>
                            <td><div class="web-container web-padding-small">Image</div></td>
                            <td><input type="file" name="img" size="50"/></td>
                        </tr>
                        <tr>
                            <td><div class="web-container web-padding-small">Category</div></td>
                            <td><select name = "category" value = "voucher">
                                    <option value="voucher">Voucher</option>
                                    <option value="staycation">Staycation</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><div class="web-container web-padding-small">Total</div></td>
                            <td><input type = "number" name = "total" value = "100" /></td>
                        </tr>
                        <tr>
                            <td colspan="2"><input class="web-button web-grey web-block" id="btnInsertVoucher" name = "btnInsertVoucher" type = "submit" value = "Save" /></td>
                        </tr>
                    </table>
                </form>

                <p><button class="web-button web-grey web-block" onclick="window.close()">Close</button></p>  </div>
        </header> 
        <script type="text/javascript">
            window.onunload = refreshParent;
            function refreshParent() {
                window.opener.location.reload();
            }

        </script>
    </body>
</html>
