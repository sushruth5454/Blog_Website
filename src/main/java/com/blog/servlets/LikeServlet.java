package com.blog.servlets;

import com.blog.dao.LikeDao;
import com.blog.helper.ConnectionProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LikeServlet", value = "/LikeServlet")
public class LikeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pid=Integer.parseInt(request.getParameter("post_id"));
        int userId=Integer.parseInt(request.getParameter("user_id"));
        LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
        likeDao.addLike(pid,userId);
        response.sendRedirect("profile.jsp");
    }
}
