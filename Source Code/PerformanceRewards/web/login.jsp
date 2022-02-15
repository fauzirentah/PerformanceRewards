<%-- 
    Document   : login
    Created on : Feb 6, 2022, 2:13:41 PM
    Author     : fauzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>Collect Your Rewards</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="style/web.css">
<link rel="stylesheet" href="style/login.css">

<body>

<div class="web-top">
  <div class="web-bar web-white web-wide web-padding web-card">
    <a href="" class="web-bar-item web-button">Employee <b>Rewards</b> Catalogue</a>
    </div>
  </div>

<!-- Header -->
<header class="web-display-container web-content web-wide" style="max-width:1500px;" id="home">
  <img class="web-image" src="images/rewards2.png" alt="Rewards" width="1500" height="800">
  <div class="web-display-middle web-margin-top web-center">
    <a href="#" onclick="document.getElementById('id01').style.display='block'"><h1 class="web-xxlarge web-text-white"><span class="web-padding web-black web-opacity-min"><b>Login to Rewards Catalogue</b></span> <span class="web-hide-small web-text-light-grey"></span></h1></a>
  </div>
</header>

<!-- Page content -->
<div class="web-content web-padding" style="max-width:1564px">
</div>
<!-- End page content -->

<div id="id01" class="modal" style="max-width: 100%; align: center !important;">
  
  <form class="modal-content animate" style="max-width: 30%;" action="loginServlet" method="POST">
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      <img src="images/img_avatar2.png" alt="Avatar" class="avatar">
    </div>

    <div class="container">
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" required>

      <label for="password"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" required>
        
      <button type="submit">Login</button><!--
      <label>
        <input type="checkbox" checked="checked" name="remember"> Remember me
      </label>-->
    </div>

    <div class="container" style="background-color:#f1f1f1">
      <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
      <span class="psw">Don't have an account? <a href="registration.jsp">Register</a>.</span>
    </div>
  </form>
</div>


<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

<!-- Footer -->
<footer class="web-center web-black web-padding-16">
  <p>CSC584 Group Project, Employee Reward Management System (Group 3)</p>
</footer>

</body>
</html>
