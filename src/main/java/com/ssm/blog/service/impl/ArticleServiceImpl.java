package com.ssm.blog.service.impl;

import com.ssm.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService{
	@Autowired
	private ArticleDao articleDao;

	@Override
	public Article getById(Long articleId) {
		Article article = articleDao.get(articleId);
		return article;
	}

	@Override
	@Transactional
	public void add(Article article) {
		
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

    @Override
    public boolean ifExistTitle(String title) {
    	//没有找到相同标题的文章，返回false
	    boolean ifExistTitle = articleDao.ifExistTitle(title) > 0 ? true : false;
        return ifExistTitle;
    }
}
