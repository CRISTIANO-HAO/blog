package com.ssm.blog.entity;

import java.util.Date;

public class Comment {
    //评论的唯一id；
    private int id;
    //评论的父级id，根级id为0；
    private int pid;
    //对应的文章的id；
    private Long articleId;
    //用户id；
    private Long userId;
    //评论内容
    private String content;
    //评论的时间
    private Date createTime;
    //赞同数
    private int agreeNum;
    //反对数
    private int disagreeNum;

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
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
}
