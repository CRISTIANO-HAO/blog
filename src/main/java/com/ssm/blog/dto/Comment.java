package com.ssm.blog.dto;

import java.util.Date;

public class Comment {
    //评论的唯一id；
    private int id;
    //对应的文章的id；
    private Long articleId;
    //文章标题
    private String title;
    //用户名称
    private String username;
    //评论内容
    private String content;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
