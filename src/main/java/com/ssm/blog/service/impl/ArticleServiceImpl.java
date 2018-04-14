package com.ssm.blog.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;

@Service
public class ArticleServiceImpl implements ArticleService{
	
	@Autowired
	private ArticleDao articleDao;

	
	@Override
	public void save(Article article) {
		
		articleDao.save(article);
	}

}
