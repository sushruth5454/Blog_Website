<style>
    .img-style{
        max-width: 400px;
        max-height: 200px;
    }
</style>

<%@ page import="com.blog.dao.PostDao" %>
<%@ page import="com.blog.helper.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blog.entities.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blog.dao.UserDao" %>
<%@ page import="java.io.File" %>
<%@ page import="com.blog.dao.LikeDao" %>
<%@ page import="com.blog.dao.CommentDao" %>
<%
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    UserDao u=new UserDao(ConnectionProvider.getConnection());
    int cid=Integer.parseInt(request.getParameter("cid"));
    List<Post> posts=new ArrayList<>();
    if(cid==0) {
        //get all posts
        posts = d.getAllPosts();
    }
    else{
        posts=d.getPostByCatId(cid);
    }
    if(posts.size()==0)
    {
        %>
<div class="cotainer">
    <h1>There are no Posts in this Category</h1>
</div>
<%
    }
    else
    {

%>
<div class="row">
    <%
        for(Post p:posts){
            LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
            CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());

    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="post_pics/<%=p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <h3><%=p.getpTitle()%></h3>
                <p><%=p.getpContent()%></p>
                <pre><%=p.getpCode()%></pre>
            </div>
            <div class="card-footer text-center primary-background">
                <%--<h6> Created By : <%=u.getUserById(p.getUserId()).getName()%></h6>
                <h6>Created on  :<%=p.getpDate()%></h6>--%>
                    <a href="LikeServlet?post_id=<%=p.getPid()%>&user_id=<%=p.getUserId()%>" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span><%=likeDao.getLikesByPostId(p.getPid())%></span> </a>
                    <a href="show_post.jsp?post_id=<%=p.getPid()%>&user_id=<%=p.getUserId()%>" class="btn btn-outline-light btn-sm">Read More...</a>

                    <a href="#!" id="commentsBtn" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span><%=commentDao.getCommentsByPostId(p.getPid()).size()%></span> </a>


            </div>
    </div>
    </div>
        <%

            }
        }
        %>
