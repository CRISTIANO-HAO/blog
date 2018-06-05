package com.ssm.blog.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Comment {
    //评论的唯一id；
    private int id;
    //评论的父级id，根级id为0；
    private int pid;
    //对应的文章的id；
    private Long articleId;
    //用户id；
    private Long userId;
    //用户名称
    private String username;
    //用户邮箱
    private String email;
    //用户网址
    private String website;
    //评论内容
    private String content;
    //评论的时间
    private Date publishTime;
    //赞同数
    private int agreeNum;
    //反对数
    private int disagreeNum;
    //父节点
    private Comment parentComment;
    /*
    * 子节点
    * 需要初始化，否则报空指针
    * */
    private List<Comment> childrenComment = new ArrayList<Comment>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public void setChildrenComment(List<Comment> childrenComment) {
        this.childrenComment = childrenComment;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public int getAgreeNum() {
        return agreeNum;
    }

    public void setAgreeNum(int agreeNum) {
        this.agreeNum = agreeNum;
    }

    public int getDisagreeNum() {
        return disagreeNum;
    }

    public void setDisagreeNum(int disagreeNum) {
        this.disagreeNum = disagreeNum;
    }

    public Comment getParentComment() {
        return parentComment;
    }

    public void setParentComment(Comment parentComment) {
        this.parentComment = parentComment;
    }

    public List<Comment> getChildrenComment() {
        return childrenComment;
    }

    public void setTreeChildrenComment(Comment childrenComment) {
        //已经初始化，所以可以直接添加comment节点
        this.childrenComment.add(childrenComment);
    }
}
