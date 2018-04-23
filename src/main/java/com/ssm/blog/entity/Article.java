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
	// 文章摘要
	private String summaryContent;
	// 文章markdown内容
	private String markdownContent;
	// 文章html内容
	private String htmlContent;
	//文章标签
	private List<Category> categories;

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

	public String getSummaryContent() {
		return summaryContent;
	}

	public void setSummaryContent(String summaryContent) {
		this.summaryContent = summaryContent;
	}

	public String getMarkdownContent() {
		return markdownContent;
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

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

}
