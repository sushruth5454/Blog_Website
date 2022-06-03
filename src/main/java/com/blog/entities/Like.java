package com.blog.entities;

public class Like {
    private int likeId;
    private int pid;
    private int userId;

    public Like(int likeId, int pid, int userId) {
        this.likeId = likeId;
        this.pid = pid;
        this.userId = userId;
    }

    public Like() {
    }

    public Like(int pid, int userId) {
        this.pid = pid;
        this.userId = userId;
    }

    public int getLikeId() {
        return likeId;
    }

    public void setLikeId(int likeId) {
        this.likeId = likeId;
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
}
