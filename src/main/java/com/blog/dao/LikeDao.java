package com.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
    private Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public int getLikesByPostId(int pid){
        int likes=0;
        try {
            String query = "select count(*) as likesCount from likes where pid=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet set=pstmt.executeQuery();
            if(set.next()){
                likes=set.getInt("likesCount");
            }

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return likes;
    }
    public void addLike(int pid,int userId){
        try{
            String query="insert into likes(pid,userId) values(?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            pstmt.setInt(2,userId);
            pstmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
