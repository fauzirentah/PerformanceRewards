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
        <form action = "registerServlet" method = "POST">
            <table align="center">
                <tr>
                    <td><input type = "hidden" name = "id" /></td>
                </tr>
                <tr>
                    <td>Name: </td>
                    <td><input type = "text" name = "name" /></td>
                </tr>
                    <td>Username: </td>
                    <td><input type = "text" name = "username" /></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type = "password" id="password" name = "password" /></td>
                </tr>
                <tr>
                    <td>Confirm password: </td>
                    <td><input type = "password" id="confirmpassword" name = "confirmpassword" /></td>
                </tr>
                <tr>
                    <td><input type = "hidden" name = "role" value="staff" /></td>
                </tr>
                <tr>
                    <td></td>
                   <td><input type = "submit" id="btnRegister" name = "btnRegister" value = "Register" />
                       <input type = "reset" value = "Reset" /></td>
                </tr>
            </table>
        </form>
                <h3>Already have an account? <a href="login.jsp">Login</a></h3>
  </div>
</header>        
                        
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#btnRegister").click(function () {
            var password = $("#password").val();
            var confirmPassword = $("#confirmpassword").val();
            if (password != confirmPassword) {
                alert("Password mismatch.");
                return false;
            }
            return true;
        });
    });
</script>

<!-- Footer -->
<footer class="web-center web-black web-padding-16">
  <p>CSC584 Group Project, Employee Reward Management System (Group 3)</p>
</footer>
    </body>
</html>
