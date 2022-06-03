package com.blog.servlets;

import com.blog.dao.UserDao;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@MultipartConfig
@WebServlet(name = "EditServlet", value = "/EditServlet")
public class EditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String new_name=request.getParameter("user_new_name");
//        String new_email=request.getParameter("user_new_email");
        String new_password=request.getParameter("user_new_password");
        String new_about=request.getParameter("user_new_about");

        Part part=request.getPart("user_new_image");
        String imageName=part.getSubmittedFileName();
        System.out.println(imageName);
        PrintWriter out=response.getWriter();
        System.out.println(new_name+" "+new_password+" "+new_about);

        HttpSession s= request.getSession();
        User user= (User) s.getAttribute("currentUser");

        //delete old profile pic in servlet pics folder
        String path=request.getRealPath("/")+"pics"+ File.separator+user.getProfile();
        if(Helper.deleteFile(path)){
            System.out.println("successfully deleted");
        }
        else{
            System.out.println("not deleted...");
        }





        //get the user from session
        user.setName(new_name);
        user.setAbout(new_about);
        user.setProfile(imageName);
        user.setPassword(new_password);

        //update database
        UserDao dao=new UserDao(ConnectionProvider.getConnection());
        boolean updated=dao.updateUser(user);
        if(updated){
            //save new profile pic in  pics folder
            String new_path=request.getRealPath("/")+"pics"+File.separator+user.getProfile();
            if(Helper.saveFile(part.getInputStream(),new_path)) {
                Message msg=new Message("Updated successfully..","success","alert-success");
                s.setAttribute("msg",msg);
                out.println("Updated Succesfully..");
            }
            else{
                Message msg=new Message("Not updated..","error","alert-danger");
                s.setAttribute("msg",msg);
                out.println("Not updated..");
            }
        }
        else{
            Message msg=new Message("Not updated..","error","alert-danger");
            s.setAttribute("msg",msg);
            out.println("Not Updated..");
        }
        response.sendRedirect("profile.jsp");



    }
}
