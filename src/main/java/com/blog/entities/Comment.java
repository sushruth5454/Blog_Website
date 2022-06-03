package com.blog.entities;

public class Comment {
    private int commentId;
    private int pid;
    private int userId;
    private String comment;

    public Comment(int commentId, int pid, int userId, String comment) {
        this.commentId = commentId;
        this.pid = pid;
        this.userId = userId;
        this.comment = comment;
    }

    public Comment() {
    }

    public Comment(int pid, int userId, String comment) {
        this.pid = pid;
        this.userId = userId;
        this.comment = comment;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
