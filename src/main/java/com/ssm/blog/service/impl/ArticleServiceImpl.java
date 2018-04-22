package com.ssm.blog.service.impl;

import com.ssm.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;

import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService{
	@Override
	public Article getById(Long articleId) {
		Article article = articleDao.get(articleId);
		return article;
	}

	@Autowired
	private ArticleDao articleDao;

	
	@Override
	public void save(Article article) {
		
		articleDao.add(article);
	}

	@Override
	public List<Article> list(int offsetCount,int pageSize, String searchParam) {
		List<Article> articleList = articleDao.list(offsetCount,pageSize,searchParam);
		return articleList;
	}

	@Override
	public int getTotalCount(String searchParam) {
		int totalCount = articleDao.getTotalCount(searchParam);
		return totalCount;
	}
}
