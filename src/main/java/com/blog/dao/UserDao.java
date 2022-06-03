package com.blog.dao;
import com.blog.entities.User;

import java.sql.*;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    //method to insert user to database
    public boolean  saveUser(User user){
        boolean f=false;
        try{
            //user->database
            String query="insert into user(name,email,password,gender,about,profile) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getGender());
            pstmt.setString(5,user.getAbout());
            pstmt.setString(6,user.getProfile());
            pstmt.executeUpdate();
            f=true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return f;
    }
    public boolean updateUser(User user){
        boolean f=false;
        try{
            String query="update user set name=? , password=? , gender=? , about=? , profile=? where email=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getPassword());
            pstmt.setString(3,user.getGender());
            pstmt.setString(4,user.getAbout());
            pstmt.setString(5,user.getProfile());
            pstmt.setString(6,user.getEmail());
            pstmt.executeUpdate();
            f=true;

        }catch (Exception e){
            e.printStackTrace();
        }
        return f;
    }
    //get user by email and password
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        try{
            String query="select * from user where email=?";
            PreparedStatement pstmt=con.prepareStatement(query);
            pstmt.setString(1,email);
            ResultSet set=pstmt.executeQuery();
            if(set.next()){
                user=new User();
                user.setId(set.getInt("id"));
                String name=set.getString("name");
                user.setName(name);
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("reg_date"));
                user.setProfile(set.getString("profile"));
            }


        }catch (Exception e){
            e.printStackTrace();
        }
        return  user;
    }
    public User getUserById(int id){
        User user=new User();
        try{
            String query="select * from user where id=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,id);
            ResultSet set=pstmt.executeQuery();
            while (set.next()){
                user.setId(set.getInt("id"));
                user.setName(set.getString("name"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("reg_date"));
                user.setProfile(set.getString("profile"));
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return user;
    }
}
