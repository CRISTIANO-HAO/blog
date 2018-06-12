package com.ssm.blog.entity;

import java.util.Date;
import java.util.List;

public class Article {
    // 文章ID
    private long articleId;
    // 文章保存时间
    private Date saveTime;
    // 文章发布时间
    private Date publishTime;
    // 文章标题
    private String title;
    // 文章html摘要
    private String summaryHtmlContent;
    //文章摘要markdown内容
    private String summaryMarkdownContent;
    // 文章markdown内容
    private String markdownContent;
    // 文章html内容
    private String htmlContent;
    //文章状态; 0: 草稿； 1：发布；默认为0
    private int status;
    //上一篇文章id
    private long prevArticleId;
    //上一篇文章标题
    private String prevTitle;
    //下一篇文章标题
    private String nextTitle;
    //下一篇文章id
    private long nextArticleId;
    //文章标签
    private List<Tag> tags;
    //文章分类
    private List<Category> categories;
    //文章所属专栏
    private List<Column> columns;

    public long getArticleId() {
        return articleId;
    }

    public void setArticleId(long articleId) {
        this.articleId = articleId;
    }

    public Date getSaveTime() {
        return saveTime;
    }

    public void setSaveTime(Date saveTime) {
        this.saveTime = saveTime;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSummaryHtmlContent() {
        return summaryHtmlContent;
    }

    public void setSummaryHtmlContent(String summaryHtmlContent) {
        this.summaryHtmlContent = summaryHtmlContent;
    }

    public String getMarkdownContent() {
        return markdownContent;
    }

    public String getSummaryMarkdownContent() {
        return summaryMarkdownContent;
    }

    public void setSummaryMarkdownContent(String summaryMarkdownContent) {
        this.summaryMarkdownContent = summaryMarkdownContent;
    }

    public void setMarkdownContent(String markdownContent) {
        this.markdownContent = markdownContent;
    }

    public String getHtmlContent() {
        return htmlContent;
    }

    public void setHtmlContent(String htmlContent) {
        this.htmlContent = htmlContent;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getPrevArticleId() {
        return prevArticleId;
    }

    public void setPrevArticleId(long prevArticleId) {
        this.prevArticleId = prevArticleId;
    }

    public String getPrevTitle() {
        return prevTitle;
    }

    public void setPrevTitle(String prevTitle) {
        this.prevTitle = prevTitle;
    }

    public String getNextTitle() {
        return nextTitle;
    }

    public void setNextTitle(String nextTitle) {
        this.nextTitle = nextTitle;
    }

    public long getNextArticleId() {
        return nextArticleId;
    }

    public void setNextArticleId(long nextArticleId) {
        this.nextArticleId = nextArticleId;
    }

    public List<Tag> getTags() {
        return tags;
    }

    public void setTags(List<Tag> tags) {
        this.tags = tags;
    }

    public List<Category> getCategories() {
        return categories;
    }

    public void setCategories(List<Category> categories) {
        this.categories = categories;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public void setColumns(List<Column> columns) {
        this.columns = columns;
    }
}
