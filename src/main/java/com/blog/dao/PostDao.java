package com.blog.dao;

import com.blog.entities.Category;
import com.blog.entities.Post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category>getAllCategories(){
        ArrayList<Category>list=new ArrayList<>();
        try{
            String query="select * from categories";
            Statement stmt=this.con.createStatement();
            ResultSet set=stmt.executeQuery(query);
            while (set.next()){
                int id=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                list.add(new Category(id,name,description));
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return list;
    }

    public  boolean savePost(Post post){
        boolean saved=false;
        try{
            String query="insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setString(1,post.getpTitle());
            pstmt.setString(2,post.getpContent());
            pstmt.setString(3,post.getpCode());
            pstmt.setString(4,post.getpPic());
            pstmt.setInt(5,post.getCatId());
            pstmt.setInt(6,post.getUserId());
            pstmt.executeUpdate();
            saved=true;

            //insert postDetails;

        }catch (Exception e){
            e.printStackTrace();
        }
        return saved;
    }
    public List<Post> getAllPosts(){
        List<Post>posts=new ArrayList<>();
        try {
            String query = "select * from posts order by pid desc";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            ResultSet set=pstmt.executeQuery();
            while (set.next()){
                posts.add(new Post(set.getInt("pid"),set.getString("pTitle"),set.getString("pContent"),set.getString("pCode"),set.getString("pPic"),set.getTimestamp("pDate"),set.getInt("catId"),set.getInt("userId")));
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return posts;
    }

    public List<Post> getPostByCatId(int catId){
        List<Post>posts=new ArrayList<>();
        try {
            String query = "select * from posts where catId=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1,catId);
            ResultSet set=pstmt.executeQuery();
            while (set.next()){
                posts.add(new Post(set.getInt("pid"),set.getString("pTitle"),set.getString("pContent"),set.getString("pCode"),set.getString("pPic"),set.getTimestamp("pDate"),set.getInt("catId"),set.getInt("userId")));
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return posts;
    }
    public Post getPostById(int pid){
        Post post=null;
        try{
            String query="select * from posts where pid=?";
            PreparedStatement pstmt=this.con.prepareStatement(query);
            pstmt.setInt(1,pid);
            ResultSet set=pstmt.executeQuery();
            if (set.next()){
                post=new Post(set.getInt("pid"),set.getString("pTitle"),set.getString("pContent"),set.getString("pCode"),set.getString("pPic"),set.getTimestamp("pDate"),set.getInt("catId"),set.getInt("userId"));

            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return post;
    }
}
