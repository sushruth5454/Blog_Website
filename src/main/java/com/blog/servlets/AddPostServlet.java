package com.blog.servlets;

import com.blog.dao.PostDao;
import com.blog.entities.Message;
import com.blog.entities.Post;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;

@MultipartConfig
@WebServlet(name = "AddPostServlet", value = "/AddPostServlet")
public class AddPostServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cid=Integer.parseInt(request.getParameter("cid"));
        String pTitle=request.getParameter("pTitle");
        String pContent=request.getParameter("pContent");
        String pCode=request.getParameter("pCode");
        Part part=request.getPart("pPic");
        String fileName=part.getSubmittedFileName();

        HttpSession session=request.getSession();
        //get user
        User user= (User) session.getAttribute("currentUser");

        Post p=new Post(pTitle,pContent,pCode,fileName,cid,user.getId());
        PostDao pDao=new PostDao(ConnectionProvider.getConnection());
        boolean saved=pDao.savePost(p);
//        System.out.println(saved);
        if(saved){
            Message msg=new Message("Posted Successfully","success","alert-success");
            session.setAttribute("msg",msg);


            //save photo to servers folder
            String path=request.getRealPath("/")+"post_pics"+File.separator+part.getSubmittedFileName();
            System.out.println(path);
            System.out.println(Helper.saveFile(part.getInputStream(),path));

        }
        else{
            Message msg=new Message("Something error has occured in posting..Not Posted","error","alert-danger");
            session.setAttribute("msg",msg);
        }


    }
}
