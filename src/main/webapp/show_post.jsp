
<%@ page import="com.blog.helper.ConnectionProvider" %>
<%@ page import="com.blog.entities.Post" %>
<%@ page import="com.blog.entities.User" %>
<%@ page import="com.blog.dao.PostDao" %>
<%@ page import="com.blog.entities.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blog.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.dao.CommentDao" %>
<%@ page import="com.blog.dao.LikeDao" %><%--
  Created by IntelliJ IDEA.
  User: NSUSHRUT
  Date: 3/19/2022
  Time: 9:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="error_page.jsp" %>
<style>
    .profile-img{
        float: left;
        border-radius: 50%;
    }
    .image{
        border-radius: 50%;
        max-width: 50px;
        max-height: 50px;
    }
</style>
<%
    User user= (User) session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login.jsp");
    }
    int postId=Integer.parseInt(request.getParameter("post_id"));
    int postUserId=Integer.parseInt(request.getParameter("user_id"));
    int userId=user.getId();
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    Post post=d.getPostById(postId);
    UserDao userDao=new UserDao(ConnectionProvider.getConnection());
    CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());
    LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
    List<List<String>>comments=commentDao.getCommentsByPostId(postId);
    request.setAttribute("post_id",postId);
    request.setAttribute("user_id",userId);

%>
<html>
<head>
    <title><%=post.getpTitle()%></title>
    <%--BootStrap Css Cdn--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <%--Font Awesome icons css link from w3 schools--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/mystyle.css">

    <style>
        .post-title{
            font-weight: 100;
            font-size: 30px;
        }
        .post-content{
            font-weight: 100;
            font-size: 25px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>TechBlog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="profile.jsp"><span class="fa fa-home"></span>Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>contact</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-edit"></span>Post</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    catagories
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Java</a>
                    <a class="dropdown-item" href="#">Python</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Another Language</a>
                </div>
            </li>
        </ul>
        <ul class="navbar-nav mr-right">
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%=user.getName()%></a>
            </li>
            <li class="nav-item">
                <a id="logout" class="nav-link" href="LogoutServlet"><span class="fa fa-user"></span>Logout</a>
            </li>

        </ul>
    </div>
</nav>

<%--end of nav bar--%>

<%--main content of body--%>
<div class="container">
    <div class="row my-4">
        <div class="col-md-8 offset-md-2">
            <div class="card">
                <div class="card-header primary-background text-white">
                    <h4 class="post-title"><%=post.getpTitle()%></h4>
                </div>
                <div class="card-body">
                    <img class="card-img-top my-2" src="post_pics/<%=post.getpPic()%>" alt="Card image cap">
                    <div class="row my-3">
                        <div class="col-md-6">
                            <p>Posted By : <a href="#!"><%=userDao.getUserById(post.getUserId()).getName()%></a> </p>
                        </div>
                        <div class="col-md-6">
                            <p>Posted On: <%=post.getpDate().toLocaleString()%> </p>

                        </div>
                    </div>
                    <p class="post-content"><%=post.getpContent()%></p>
                    <br>
                    <br>
                    <div class="post-code">
                    <pre><%=post.getpCode()%></pre>
                    </div>
                </div>
                <div class="card-footer primary-background">
                    <a href="LikeServlet?post_id=<%=postId%>&user_id=<%=userId%>" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span><%=likeDao.getLikesByPostId(postId)%></span> </a>
                    <a href="#!" class="btn btn-outline-light btn-sm" data-toggle="modal" data-target="#comment-modal"><i class="fa fa-commenting-o"></i><span><%=comments.size()%></span> </a>

                    <%--comment modal--%>
                    <div>
                        <textarea class="form-control" id="pComment" name="pComment" rows="5" placeholder="Enter your comment"></textarea>
                        <button type="submit" onclick="addComment(<%=postId%>,<%=userId%>)">Add Comment</button>
                                    <%
                                        for(List<String>details:comments){
                                            System.out.println(details.get(1));
                                            User postedUser=userDao.getUserById(Integer.parseInt(details.get(1)));

                                    %>
                                    <div class="card">
                                        <div class="card-body">
                                    <p class="form-control"><%=details.get(0)%></p>
                                            <div class="profile-img">
                                                <img class="image" class="card-img-top" src="pics/<%=postedUser.getProfile()%>" alt="Card image cap">
                                            </div>
                                            <div>
                                                <h6 class="my-3">&nbsp;&nbsp;&nbsp;&nbsp;Commented By: <%=postedUser.getName()%></h6>
                                            </div>
                                    </div>
                                    </div>

                                    <%
                                        }
                                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<%--end of main content--%>







<%--modals--%>
<%--start of profile modal from bootstrap modal--%>
<!--  profile Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-center">
                <h5 class="modal-title" id="exampleModalLabel">Profile Information</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <img src="pics/<%=user.getProfile()%>" class="image-fluid" style="border-radius: 70%;max-width: 250px;">
                    <br>
                    <h5 class="modal-title mt-3" id="exampleModal"><%=user.getName()%></h5>
                    <div class="container" id="profile-details">
                        <table class="table">
                            <tbody>
                            <tr>
                                <th scope="row">Email</th>
                                <td id="userEmail"><%=user.getEmail()%></td>
                            </tr>
                            <tr>
                                <th scope="row">Gender</th>
                                <td id="userGender"><%=user.getGender()%></td>
                            </tr>
                            <tr>
                                <th scope="row">About</th>
                                <td id="userAbout"><%=user.getAbout()%></td>
                            </tr>
                            <tr>
                                <th scope="row">Registered ON</th>
                                <td ><%=user.getDateTime()%></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>

                    <%--profile edit--%>
                    <div class="container" id="profile-edit" style="display: none;">
                        <h3 class="mt-3">Please Edit Carefully</h3>
                        <form action="EditServlet" method="post" enctype="multipart/form-data">
                            <table class="table">
                                <tr>
                                    <th scope="row">User ID</th>
                                    <td><%=user.getId()%></td>
                                </tr>
                                <tr>
                                    <th scope="row">User Name</th>
                                    <td><input type="text" class="form-control" name="user_new_name" value="<%=user.getName()%>"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Email</th>
                                    <td><input type="email" class="form-control" name="user_new_email" value="<%= user.getEmail()%>"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Password</th>
                                    <td><input type="text" class="form-control" name="user_new_password" value="<%= user.getPassword()%>"></td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender</th>
                                    <td id="user_new_Gender"><%=user.getGender()%></td>

                                </tr>
                                <tr>
                                    <th scope="row">About</th>
                                    <td><textarea rows="3" class="form-control" name="user_new_about"><%=user.getAbout()%></textarea></td>
                                </tr>
                                <tr>
                                    <th scope="row">New Profile Picture</th>
                                    <td><input type="file" name="user_new_image" class="form-control"></td>
                                </tr>
                            </table>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-primary">Save</button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="editBtn">EDIT</button>
            </div>
        </div>
    </div>
</div>

<%--end of profile modal--%>

<%--                   Start of Add post modal--%>



<!-- Button trigger modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary-background text-center">
                <h5 class="modal-title" id="exampleModalLabel1">Provide the post Details</h5>
                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="add-post-form" action="AddPostServlet" method="post">
                    <div class="form-group">
                        <select class="form-control" name="cid">
                            <option selected disabled>---Select Cataegory---</option>
                            <%
                                PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list=postd.getAllCategories();
                                for(Category c:list){
                            %>
                            <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="text" name="pTitle" placeholder="Enter Post title" class="form-control">
                    </div>

                    <div class="form-group">
                        <textarea name="pContent" placeholder="Enter Content" rows="5" class="form-control"></textarea>
                    </div>

                    <div class="form-group">
                        <textarea name="pCode" placeholder="Enter your program(if any)" rows="5" class="form-control"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Select your pic</label>
                        <br>
                        <input type="file" name="pPic">
                    </div>
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>



                </form>



            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Understood</button>
            </div>
        </div>
    </div>
</div>


<%--                    end of Add post modal--%>











<%--jquery script--%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>

<%--bootstrap script--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<%--sweet alert cdn ..--%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="js/check.js"></script>

<%--profile edit--%>
<script>
    $(document).ready(function(){
        let editStatus=false;
        $("#editBtn").click(function (){
            if(editStatus==false){
                $("#profile-edit").show();
                $("#profile-details").hide();
                editStatus=true;
                $(this).text("BACK");
            }
            else{
                $("#profile-details").show();
                $("#profile-edit").hide();
                editStatus=false;
                $(this).text("EDIT");

            }

        })
    })
    function addComment(pid,userId){
        console.log(pid+" "+userId);
        const d={
            post_id:pid,
            user_id:userId,
            pComment:$("#pComment").val()
        }
        $.ajax({
            url:"CommentServlet",
            data:d,
            success:function (data,textStatus,jqXHR){
                console.log("success");
                swal("Comment posted Successfully", "", "success")
                    .then((value) => {
                        window.location = "show_post.jsp?post_id=${post_id}&user_id=${user_id}";
                    });


            },
            error:function (jqXHR,textStatus,errorThrown) {
                console.log("error");

            }
        })
    }
</script>

</body>
</html>
