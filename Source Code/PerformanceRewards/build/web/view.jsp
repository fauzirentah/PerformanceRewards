<%-- 
    Document   : viewimage
    Created on : Feb 8, 2022, 12:58:52 PM
    Author     : fauzi
--%>

<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<html>
<body>
    <div>
<%  Blob image = null;
    Connection con = null;
    byte[ ] imgData = null ;
    Statement stmt = null;
    ResultSet rs = null;

try {
Class.forName("org.apache.derby.jdbc.ClientDriver");
con = DriverManager.getConnection("jdbc:derby://localhost:1527/RewardsDB","rewardsapp","rewardsapp");
stmt = con.createStatement();
rs = stmt.executeQuery("select img from rewards where reward_id = 13");
if (rs.next()) {
image = rs.getBlob(1);
imgData = image.getBytes(1,(int)image.length());
} else {
out.println("Display Blob Example");
out.println("image not found for given id>");
return;
}

// display the image
response.setContentType("image/gif");
OutputStream o = response.getOutputStream();
o.write(imgData);
o.flush();
o.close();
} catch (Exception e) {
out.println("Unable To Display image");
out.println("Image Display Error=" + e.getMessage());
return;
} finally {
try {
rs.close();
stmt.close();
con.close();
} catch (SQLException e) {
e.printStackTrace();
}
}
%>        
    </div><img src="imgData"></img>
</body>
</html>