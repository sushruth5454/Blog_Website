package com.blog.servlets;

import com.blog.dao.UserDao;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
@MultipartConfig
@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //fetch username and password
        PrintWriter out=response.getWriter();
        String userEmail=request.getParameter("user_email");
        String userPassword=request.getParameter("user_password");

        //get user by dao
        UserDao dao=new UserDao(ConnectionProvider.getConnection());
        User user=dao.getUserByEmailAndPassword(userEmail,userPassword);
        if(user==null){
            Message msg=new Message("You Have not registered","error","alert-danger");
            HttpSession s=request.getSession();
            s.setAttribute("msg",msg);
//            response.sendRedirect("login.jsp");


            out.println("You Have not registered"); //this for ajax
        }
        else if(!user.getPassword().equals(userPassword)){
            Message msg=new Message("Password Doesn't Match","warning","alert-warning");
            HttpSession s=request.getSession();
            s.setAttribute("msg",msg);
//            response.sendRedirect("login.jsp");
            out.println("Password Doesn't Match");
        }
        else{

            Message msg=new Message("Successfully logged in..","success","alert-success");
            HttpSession s=request.getSession();
            s.setAttribute("msg",msg);
            out.println("Successfully logged in..");
            //create a session
            s.setAttribute("currentUser",user);
//            response.sendRedirect("profile.jsp");

        }



    }
}
