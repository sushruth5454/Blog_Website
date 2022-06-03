<%@ page import="com.blog.entities.Message" %><%--
  Created by IntelliJ IDEA.
  User: NSUSHRUT
  Date: 3/17/2022
  Time: 4:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <title>JSP - Hello World</title>
    <%--BootStrap Css Cdn--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <%--Font Awesome icons css link from w3 schools--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/mystyle.css">
</head>
<body>
<%--nav bar--%>
<%@include file="normal_navbar.jsp"%>
<main class="d-flex align-itens-center primary-background curve-background" style="height:70vh">
    <div class="container">
        <div class="row">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-header text-center primary-background text-white">
                        <span class="fa fa-user fa-3x"></span>
                        <h3>Login</h3>
                        <h4 id="login_msg"></h4>
                    </div>
                    <%
                    Message msg= (Message) session.getAttribute("msg");
                    if(msg!=null){
                        %>
                    <div class="alert <%=msg.getCssClass()%>" role="alert">
                        <%=msg.getContent()%>
                    </div>


                    <%
                        session.removeAttribute("msg");
                    }
                    %>

                <br>
                    <div class="card-body">
                        <form  id="login_from" action="LoginServlet" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" name="user_email" aria-describedby="emailHelp" placeholder="Enter email" required>
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <input type="password" name="user_password" class="form-control" id="exampleInputPassword1" placeholder="Password" required>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                            </div>
                            <div class="container text-center">
                            <button type="submit" class="btn btn-primary">Submit</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer"></div>


                </div>
            </div>
        </div>
    </div>


</main>



<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<%--sweet alert cdn ..--%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="js/check.js"></script>
</body>
</html>
