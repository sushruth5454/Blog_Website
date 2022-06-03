package com.blog.servlets;

import com.blog.dao.CommentDao;
import com.blog.helper.ConnectionProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "CommentServlet", value = "/CommentServlet")
public class CommentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pid=Integer.parseInt(request.getParameter("post_id"));
        int userId=Integer.parseInt(request.getParameter("user_id"));
        String comment=request.getParameter("pComment");
        System.out.println(pid+" "+userId);
        System.out.println(comment);
        System.out.println("adding comment");
        System.out.println(pid);
        CommentDao commentDao=new CommentDao(ConnectionProvider.getConnection());
        commentDao.addCommentToPost(pid,userId,comment);
//        System.out.println("added comment");
        response.sendRedirect("profile.jsp");

    }
}
