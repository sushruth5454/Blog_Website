<%--
  Created by IntelliJ IDEA.
  User: NSUSHRUT
  Date: 3/18/2022
  Time: 11:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<html>
<head>
    <title>Sorry ! Something went wrong</title>
    <%--BootStrap Css Cdn--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <%--Font Awesome icons css link from w3 schools--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/mystyle.css">
</head>
<body>
<div class="container text-center">
    <img src="img/computer.png" class="img-fluid">
    <h3 class="display-3">Sorry ! Something went wrong</h3>
    <h4><%= exception%></h4>
    <a class="btn btn-lg btn-lg btn-outline-primary" href="index.jsp">Home</a>
</div>

</body>
</html>
