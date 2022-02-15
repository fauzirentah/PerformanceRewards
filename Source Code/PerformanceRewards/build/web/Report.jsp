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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="web.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <title>Insert Staycation</title>
    </head>
    <body>
        <h1><a href="#home" class="web-bar-item web-button"><b>Insert</b> Staycation</a></h1>
        <c:if test="${not empty errorMsgs}">
            <p>
                <font color='red'>Please correct the following errors:
            <ul>
                <c:forEach var="message" items="${errorMsgs}">
                    <li>${message}</li>
                    </c:forEach>
            </ul>
            </font>
        </p>
    </c:if>

    <sql:query var="result" dataSource="${rewardsDatasource}">
        SELECT COUNT(*) AS "Total" FROM REWARDSAPP.REWARDS
    </sql:query>                            
    <c:forEach var="row" items="${result.rowsByIndex}">
        <c:forEach var="column" items="${row}"><c:set var="countRow" value="${column=column+1}"/>
        </c:forEach>
    </c:forEach>

    <c:set var="id" value="${param.id}" />
    <c:set var="name" value="${param.name}" />
    <c:set var="description" value="${param.description}" />
    <c:set var="image" value="${param.image}" />
    <c:set var="category" value="${param.category}" />

    <c:if test="${(id!=null)&&(name!=null)&&(description!=null)&&(image!=null)&&(category!=null)}" var="result">

        <sql:update var="result" dataSource="${rewardsDatasource}">
            INSERT INTO rewards
            VALUES (?,?,?,?,?)
            <sql:param value="${countRow}"/>
            <sql:param value="${name}"/>
            <sql:param value="${description}"/>
            <sql:param value="${image}"/>
            <sql:param value="${category}"/>
        </sql:update>
    </c:if>

    <form action = "insertStaycation.jsp" method = "GET">
        <table>
            <tr>
                <td><input type = "hidden" name = "id" /></td>
            </tr>
            <tr>
                <td><div class="web-container web-padding-small">Name </div></td>
                <td><input type = "text" name = "name" /></td>
            </tr>
            <tr>
                <td><div class="web-container web-padding-small">Description </div></td>
                <td><input type = "text" name = "description" /></td>
            </tr>
            <tr>
                <td><div class="web-container web-padding-small">Image </div></td>
                <td><input type = "text" name = "image" /></td>
            </tr>
            <tr>
                <td><input type = "hidden" name = "category" value = "staycation"/></td>
            </tr>
            <tr><td></td>
                <td><input type = "submit" value = "Save" /></td>
            </tr>
        </table>
    </form>
    <br />        <br />
    <sql:query var="result" dataSource="${rewardsDatasource}">
        SELECT reward_id AS "Number", 
        reward_name AS "Name", 
        description AS "Description", 
        image AS "Image",
        category AS "Category" FROM REWARDSAPP.REWARDS
        WHERE category = 'staycation'
        ORDER BY reward_id ASC
    </sql:query>

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
<br />
    <p><button class="web-button web-light-grey web-block" onclick="window.close()">Close</button></p>

</body>
</html>
