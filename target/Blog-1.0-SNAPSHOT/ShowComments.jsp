<%@ page import="com.blog.dao.CommentDao" %>
<%@ page import="com.blog.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: NSUSHRUT
  Date: 3/20/2022
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    System.out.println("in show comments");
    int pid=Integer.parseInt(request.getParameter("post_id"));
    int userId=Integer.parseInt(request.getParameter("user_id"));
    System.out.println("in show comments");
    CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());
    List<String>comments=commentDao.getCommentsByPostId(pid);

%>
<form action="CommentServlet?post_id=<%=pid%>&user_id=<%=userId%>" type="post">
    <textarea name="comment" rows="5" placeholder="Enter your comment"></textarea>
    <button type="submit">Add Comment</button>
</form>

<a href="#!" id="commentsBtn" class="btn btn-outline-light btn-sm" data-toggle="modal" data-target="#comment-modal"><i class="fa fa-commenting-o"></i><h4>Show Comments</h4><span><%=commentDao.getCommentsByPostId(pid).size()%></span> </a>


<div class="modal fade" id="comment-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<h5 class="modal-title" id="exampleModalLabel">Comments</h5>
<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>
<div class="modal-body">
    <%
        for(String c:comments){

    %>
    <h5><%=c%></h5>
    <%
        }
    %>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
<button type="button" class="btn btn-primary">Save changes</button>
</div>
</div>
</div>
</div>
