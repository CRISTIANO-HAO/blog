package com.ssm.blog.service.impl;

import com.ssm.blog.dao.ArticleCategoryDao;
import com.ssm.blog.dao.TagDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssm.blog.dao.ArticleDao;
import com.ssm.blog.entity.Article;
import com.ssm.blog.service.ArticleService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService{
	@Autowired
	private ArticleDao articleDao;
	@Autowired
    private TagDao tagDao;
	@Autowired
    private ArticleCategoryDao articleCategoryDao;

	@Override
	public Article getById(Long articleId) {
		Article article = articleDao.get(articleId);
		return article;
	}

	@Override
	@Transactional
	public void addArticle(Article article) {
		articleDao.addArticle(article);
		articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());
		tagDao.addTag(article.getTags(),article.getArticleId());
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

	@Override
    @Transactional
	public void update(Article article) {
		tagDao.deleteByArticleId(article.getArticleId());
		tagDao.addTag(article.getTags(),article.getArticleId());

        articleCategoryDao.deleteByArticleId(article.getArticleId());
		articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());

		articleDao.update(article);
	}
}
