package com.ssm.blog.service;

import java.util.List;
import java.util.Map;

import com.ssm.blog.entity.Article;
import com.ssm.blog.utils.Page;

public interface ArticleService {

	void add(Article article);

	Article getById(Long articleId);

	List<Article> list(int offsetCount,int pageSize,String searchParam);

	int getTotalCount(String searchParam);

	boolean ifExistTitle(String title);

	void update(Article article);
}
