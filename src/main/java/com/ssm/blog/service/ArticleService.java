package com.ssm.blog.service;

import java.util.List;
import java.util.Map;

import com.ssm.blog.entity.Article;
import com.ssm.blog.utils.Page;

public interface ArticleService {

	void save(Article article);

	List<Article> list(Page page,String searchParam);
	List<Article> list(Map<String,Object> pageMap);

	int getTotalCount(String searchParam);
}
