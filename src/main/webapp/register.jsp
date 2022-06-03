<%--
  Created by IntelliJ IDEA.
  User: NSUSHRUT
  Date: 3/17/2022
  Time: 4:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <%--BootStrap Css Cdn--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <%--Font Awesome icons css link from w3 schools--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/mystyle.css">

</head>
<body>
<%@include file="normal_navbar.jsp"%>
<main class="d-flex align-items-center primary-background" style="">
<div class="container">
    <div class="row">
         <div class="col-md-6 offset-md-3">
             <div class="card">
                 <div class="card-header primary-background text-center text-white mt-1">
                     <span class="fa fa-user-plus fa-3x"></span>
                     <h3>Register Here</h3>
                     <h4 id="msg_header"></h4>
                 </div>
                 <div class="card-body">

                     <form id="myform" action="RegisterServlet"method="post">
                         <div class="form-group">
                             <label for="user_name">User Name</label>
                             <input name="user_name" type="text" class="form-control" id="user_name" placeholder="Enter user name">
                         </div>
                         <div class="form-group">
                             <label for="user_email">Email address</label>
                             <input type="email" class="form-control" name="user_email" id="user_email" aria-describedby="emailHelp" placeholder="Enter email">
                             <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                         </div>
                         <div class="form-group">
                             <label for="user_password">Password</label>
                             <input type="password" class="form-control" name="user_password" id="user_password" placeholder="Password">
                         </div>
                         <div class="form-group">
                             <label for="user_password_2">Confirm Password</label>
                             <input onkeyup="checkPassword()" type="password" class="form-control" name="user_password_2" id="user_password_2" placeholder="Re Enter Password">
                             <h6 id="msg"></h6>
                         </div>
                         <div class="form-group">
                             <label>Select your Gender</label>
                             <br>
                             <input type="radio" name="user_gender" value="Male">Male
                             <input type="radio" name="user_gender" value="Female">Female
                         </div>
                         <div class="form-group">
                             <textarea name="user_about" class="form-control" id="user_about" rows="5" placeholder="Enter Something about you"></textarea>
                         </div>
                         <div class="form-group">
                             <label>Choose Your Profile Picture</label>
                             <br>
                             <td><input type="file" name="user_image" class="form-control"></td>
                         </div>
                         <div class="form-check">
                             <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                             <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                         </div>
                         <div class="loader text-center" style="display: none">
                             <span class="fa fa-refresh fa-spin fa-3x"></span>
                             <h4>please wait..</h4>
                         </div>
                         <button type="submit" class="btn btn-primary text-center sub-btn">Submit</button>
                     </form>
                 </div>

         </div>
</div>
    </div>
</div>
</main>

<%--jquery script--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

<%--bootstrap script--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<%--sweet alert cdn ..--%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="js/check.js"></script>
</body>
</html>
