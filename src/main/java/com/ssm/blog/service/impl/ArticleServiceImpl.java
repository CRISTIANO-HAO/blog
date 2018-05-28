package com.ssm.blog.service.impl;

import com.ssm.blog.dao.ArticleCategoryDao;
import com.ssm.blog.dao.ArticleColumnDao;
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
	@Autowired
    private ArticleColumnDao articleColumnDao;

	@Override
	public Article getArticleById(Long articleId) {
		Article article = articleDao.getArticleById(articleId);
		return article;
	}

	@Override
	@Transactional
	public void addArticle(Article article) {
		articleDao.addArticle(article);
		articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());
		articleColumnDao.addArticleAndColumnId(article.getColumns(),article.getArticleId());
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
		//更新标签
		tagDao.deleteByArticleId(article.getArticleId());
		tagDao.addTag(article.getTags(),article.getArticleId());
        //更新分类
        articleCategoryDao.deleteByArticleId(article.getArticleId());
		articleCategoryDao.addArticleAndCategoryId(article.getCategories(),article.getArticleId());
		//更新专栏
        articleColumnDao.deleteByArticleId(article.getArticleId());
        articleColumnDao.addArticleAndColumnId(article.getColumns(),article.getArticleId());

		articleDao.update(article);
	}

	@Override
	public List<Article> getArticleByPage(Integer pageIndex, Integer pageSize) {
		List<Article> articleList = articleDao.getArticleByPage(pageIndex,pageSize);
		return articleList;
	}

}
