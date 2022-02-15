<%-- 
    Document   : registration
    Created on : Feb 2, 2022, 10:37:53 AM
    Author     : fauzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style/web.css">
        <link rel="stylesheet" href="style/login.css">
        <title>Employee Rewards System Registration</title>
    </head>
    <body align="center">
<div class="web-top">
  <div class="web-bar web-white web-wide web-padding web-card">
    <a href="" class="web-bar-item web-button">Employee <b>Rewards</b> Registration</a>
    </div>
  </div>
    
<!-- Header -->
<header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">
  <img class="web-image" src="images/rewards2.png" alt="Rewards" width="1500" height="800" style="-webkit-filter: blur(5px); filter: blur(5px); filter: opacity(20%);">
  <div class="web-display-middle web-margin-top web-center">
      <h2><b>Registration Success!</b> Please login using your new username and password.</h2>
  </div>
</header>        
                        
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    window.setTimeout(function(){

        // Move to a new location or you can do something else
        window.location.href = "/PerformanceRewards/";

    }, 3000);
</script>

<!-- Footer -->
<footer class="web-center web-black web-padding-16">
  <p>CSC584 Group Project, Employee Reward Management System (Group 3)</p>
</footer>
    </body>
</html>
