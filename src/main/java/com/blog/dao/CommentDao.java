package com.blog.dao;

import com.blog.servlets.RegisterServlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
    private Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }

    public List<List<String>> getCommentsByPostId(int pid){
        List<List<String>>comments=new ArrayList<>();
        try{
            String query="select * from comments where pid=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet set=pstmt.executeQuery();
            while (set.next()){
                List<String>temp=new ArrayList<>();
                temp.add(set.getString("comment"));
                temp.add(set.getString("userId"));
                comments.add(new ArrayList<>(temp));
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return comments;

    }
    public  void addCommentToPost(int pid,int userId,String comment){
        try {
            String query="insert into comments(pid,userId,comment) values(?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,userId);
            pstmt.setString(3,comment);
            pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
