package com.blog.servlets;

import com.blog.dao.UserDao;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

/*@WebServlet(name = "RegisterServlet", value = "/RegisterServlet")*/
@MultipartConfig
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
//        response.setContentType("text/html");
        String check = request.getParameter("check");
//        out.println(check);
        if (check == null) {
            out.println("Please Agree terms and Conditions");
        } else {
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String gender = request.getParameter("user_gender");
            String about = request.getParameter("user_about");
            Part part=request.getPart("user_image");
            String fileName=part.getSubmittedFileName();
            /*System.out.println(name + " " + email + " " + password + " " + gender + " " + about + " ");
            out.println(name + " " + email + " " + password + " " + gender + " " + about + " ");*/
            //create user object
            User user = new User(name, email, password, gender, about,fileName);

            //create userDao object
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            String path=request.getRealPath("/")+"pics"+ File.separator+fileName;
            System.out.println(Helper.saveFile(part.getInputStream(),path));
            if (dao.saveUser(user)) {
                out.println("Succesfully Registered..");
            } else {
                out.println("Something Went Wrong..");
            }

        }
    }
}
