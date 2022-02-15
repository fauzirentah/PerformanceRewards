<%-- 
    Document   : success
    Created on : Feb 8, 2022, 9:50:53 PM
    Author     : fauzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <link rel="stylesheet" href="style/web.css">
        <title>Success</title>
    </head>
    <body>
        <h1 class="web-display-middle web-margin-top web-left"><b>Success</b></h1>
        
<header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">
    <progress class="web-display-middle web-margin-top web-left" value="0" max="3" id="progressBar"></progress>
  <img class="web-image" src="images/rewards2.png" alt="Rewards" width="auto" height="auto" style="-webkit-filter: blur(5px); filter: blur(5px); filter: opacity(20%);">
  <div class="web-display-middle web-margin-top web-left">
      
  </div>
  </header> 
        <script> 
setTimeout("window.close()",3000);

var timeleft = 1;
var downloadTimer = setInterval(function(){
  if(timeleft <= 0){
    clearInterval(downloadTimer);
  }
  document.getElementById("progressBar").value = 1 - timeleft;
  timeleft -= 1;
}, 1000);


</script>
    </body>
</html>
